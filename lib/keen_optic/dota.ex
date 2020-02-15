defmodule KeenOptic.Dota do
  @moduledoc """
  Dota is an API client using [HTTPoison.Base](https://hexdocs.pm/httpoison/1.6.2/HTTPoison.Base.html)
  to implement relevant Dota API calls.
  """
  use HTTPoison.Base

  @api_host "api.steampowered.com"

  @prod_path_base "/IDOTA2Match_570/"
  @test_path_base "/IDOTA2Match_205790/"

  @live_game_path "GetTopLiveGame/v1/"

  @base_uri %URI{
    authority: @api_host,
    fragment: nil,
    host: @api_host,
    path: nil,
    port: 443,
    query: nil,
    scheme: "https",
    userinfo: nil
  }

  @base_query %{
    "format" => "JSON",
    "partner" => 0
  }

  @default_http_opts [hackney: [pool: :dota]]

  def live_games do
    get(@live_game_path)
  end

  # HTTPoison.Base callbacks

  def process_url(path) do
    uri = %URI{
      path: path_base() <> path,
      query: query()
    }

    @base_uri
    |> URI.merge(uri)
    |> URI.to_string()
  end

  def process_request_options(opts) do
    Keyword.merge(opts, @default_http_opts)
  end

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, data} -> data
      {:error, _error} -> body
    end
  end

  # Private methods

  defp path_base do
    case Application.get_env(:keen_optic, :dota_api_env, :test) do
      :prod -> @prod_path_base
      _ -> @test_path_base
    end
  end

  defp query do
    @base_query
    |> Map.merge(%{"key" => Application.get_env(:keen_optic, :dota_api_key)})
    |> URI.encode_query()
  end
end
