defmodule KeenOptic.Dota do
  @moduledoc """
  Dota is an API client using [HTTPoison.Base](https://hexdocs.pm/httpoison/1.6.2/HTTPoison.Base.html)
  to implement relevant Dota API calls.
  """
  use HTTPoison.Base

  alias KeenOptic.Dota.RealTimeStats

  @api_host "api.steampowered.com"

  @prod_path_base "/IDOTA2Match_570/"
  @test_path_base "/IDOTA2Match_205790/"

  @live_game_path "/IDOTA2Match_570/GetTopLiveGame/v1/"
  @real_time_stats_path "/IDOTA2MatchStats_570/GetRealtimeStats/v1"

  @default_query_params [format: "JSON", partner: 0]
  @default_http_opts [hackney: [pool: :dota]]

  def live_games do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- get(@live_game_path) do
      {:ok, body}
    else
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Got status code #{status_code}."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      error ->
        error
    end
  end

  @spec real_time_stats(non_neg_integer()) :: {:ok, RealTimeStats.t()} | {:error, String.t()}
  def real_time_stats(server_steam_id) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           do_request(@real_time_stats_path, %{server_steam_id: server_steam_id}),
         {:ok, data} <- Jason.decode(body),
         {:ok, stats} <- RealTimeStats.from_map(data) do
      {:ok, stats}
    else
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Got status code #{status_code}."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      error ->
        error
    end
  end

  # HTTPoison.Base callbacks

  defp build_url(path) do
    @api_host <> path_base() <> path
  end

  def process_request_options(opts) do
    params =
      opts
      |> Keyword.get(:params, [])
      |> (&Keyword.merge(@default_query_params, &1)).()
      |> Keyword.merge(key: api_key())

    opts |> Keyword.merge(params: params) |> Keyword.merge(@default_http_opts) |> IO.inspect()
  end

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, data} -> data
      {:error, _error} -> body
    end
  end

  # Private methods

  defp do_request(path, params) when is_map(params) do
    query =
      params
      |> Map.merge(%{
        format: "JSON",
        key: api_key()
      })
      |> URI.encode_query()

    url =
      URI.to_string(%URI{
        host: @api_host,
        path: path,
        scheme: "https",
        query: query
      })

    HTTPoison.request(:get, url)
  end

  # https://api.steampowered.com/IDOTA2MatchStats_570/GetRealtimeStats/v1?key=6E4A91A7C018C1742D26EB81178ED01D&format=JSON&server_steam_id=90132710204079112
  # https://api.steampowered.com/IDOTA2MatchStats_570/GetRealtimeStats/v1?format=JSON&key=6E4A91A7C018C1742D26EB81178ED01D&server_steam_id=90132710769730568

  defp path_base do
    case Application.get_env(:keen_optic, :dota_api_env, :test) do
      :prod -> @prod_path_base
      _ -> @test_path_base
    end
  end

  defp api_key do
    Application.get_env(:keen_optic, :dota_api_key)
  end
end
