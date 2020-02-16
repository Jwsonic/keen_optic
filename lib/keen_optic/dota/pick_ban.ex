defmodule KeenOptic.Dota.PickBan do
  use TypedStruct

  alias __MODULE__

  typedstruct do
    field :hero, non_neg_integer(), enforce: true
    field :team, non_neg_integer(), enforce: true
  end

  @spec from_map(list(map())) :: list(Pick.t()) | {:error, String.t()}
  def from_list(list) do
    picks = Enum.map(list, &from_map/1)

    error = picks |> Enum.filter(&is_error?/1) |> Enum.take(1)

    case error do
      [] -> {:ok, picks}
      [error] -> error
    end
  end

  @spec from_map(map()) :: Pick.t() | {:error, String.t()}
  def from_map(%{"hero" => hero, "team" => team}) do
    %PickBan{
      hero: hero,
      team: team
    }
  end

  def from_map(map), do: {:error, "Does not match Pick shape #{inspect(map)}."}

  defp is_error?({:error, _message}), do: true
  defp is_error?(_), do: false
end
