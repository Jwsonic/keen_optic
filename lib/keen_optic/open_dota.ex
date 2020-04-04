defmodule KeenOptic.OpenDota do
  @moduledoc """
  OpenDota fetches data from the OpenDota APIs.
  """
  @pro_players_url "https://api.opendota.com/api/proPlayers"

  alias KeenOptic.OpenDota.ProPlayer

  @spec pro_players() :: {:ok, ProPlayer.t()} | {:error, String.t()}
  def pro_players do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get(@pro_players_url),
         {:ok, data} <- Jason.decode(body),
         {:ok, players} <- ProPlayer.new(data) do
      {:ok, players}
    else
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received status code #{status_code}."}

      {:error, %HTTPoison.Error{} = error} ->
        {:error, HTTPoison.Error.message(error)}

      {:error, %Jason.DecodeError{} = error} ->
        {:error, Jason.DecodeError.message(error)}

      {:error, _error} = error ->
        error
    end
  end
end
