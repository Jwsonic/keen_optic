defmodule KeenOptic.Dota.Api do
  @moduledoc """
  Implements various HTTP API calls to the Dota2 APIs.
  """

  alias KeenOptic.Dota.{LiveGame, RealTimeStats}

  @api_host "api.steampowered.com"
  @scheme "https"

  @live_game_path "/IDOTA2Match_570/GetTopLiveGame/v1/"
  @real_time_stats_path "/IDOTA2MatchStats_570/GetRealtimeStats/v1"

  @default_query_params %{format: "JSON", partner: 0}

  def live_matches do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <- do_request(@live_game_path),
         {:ok, data} <- Jason.decode(body),
         list when is_list(list) <- Map.get(data, "game_list", :missing_key),
         {:ok, games} <-
           LiveGame.from_list(list) do
      {:ok, games}
    else
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Got status code #{status_code}."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      :missing_key ->
        {:error, "'game_list' key was missing from the response."}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec real_time_stats(non_neg_integer()) ::
          {:ok, RealTimeStats.t()} | {:error, String.t()} | {:error, :no_match}
  def real_time_stats(server_steam_id) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           do_request(@real_time_stats_path, %{server_steam_id: server_steam_id}),
         {:ok, data} <- Jason.decode(body),
         {:ok, stats} <- RealTimeStats.from_map(data) do
      {:ok, stats}
    else
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, :no_match}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Got status code #{status_code}."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      error ->
        error
    end
  end

  # Private methods
  defp do_request(path, params \\ %{}) when is_map(params) do
    query =
      params
      |> Map.merge(@default_query_params)
      |> Map.merge(api_query_params())
      |> URI.encode_query()

    url =
      URI.to_string(%URI{
        host: @api_host,
        path: path,
        scheme: @scheme,
        query: query
      })

    HTTPoison.request(:get, url)
  end

  defp api_query_params do
    %{key: Application.get_env(:keen_optic, :dota_api_key)}
  end
end
