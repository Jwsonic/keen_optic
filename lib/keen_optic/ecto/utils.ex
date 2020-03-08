defmodule KeenOptic.Ecto.Utils do
  @moduledoc """
  Re-usable utilities for working with Ecto structs.
  """

  @type old_key() :: String.t()
  @type new_key() :: String.t()
  @type rename_pair() :: {old_key(), new_key()}

  @doc """
  Re-names params that don't come in with the key we want.
  """
  @spec rename_params(map(), list(rename_pair())) :: map()
  def rename_params(params, rename_pairs) do
    Enum.reduce(rename_pairs, params, &rename/2)
  end

  @type input() :: any()
  @type result() :: any()
  @type ok_result() :: {:ok, result()}
  @type err_result() :: {:error, result()}

  @doc """
  Reduces a list of results to either the first of its errors, or the list of ok results.
  """
  @spec reduce_results(list(input()), (input() -> ok_result() | err_result())) ::
          list(ok_result()) | err_result()
  def reduce_results(list, mapper) do
    results =
      list
      |> Enum.map(mapper)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    case results[:error] do
      nil -> {:ok, results[:ok]}
      [error | _rest] -> error
    end
  end

  defp rename({old, new}, acc) do
    acc
    |> Map.get(old)
    |> (&Map.put(acc, new, &1)).()
  end
end
