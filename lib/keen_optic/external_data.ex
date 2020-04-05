defmodule KeenOptic.ExternalData do
  @moduledoc """
  A macro for building structs from maps of data from an external source.
  """

  @doc """
  Invoked before attempting to cast params. Allows the implementer to coerce external params
  into a shape that will cast nicely into their struct.
  """
  @callback coerce_params(map()) :: {:ok, map()} | {:error, String.t()}

  @doc """
  Invoked after casting. This is where the implementer should add their custom embeds.
  """
  @callback extra_changes(Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias __MODULE__

      @behaviour KeenOptic.ExternalData

      @before_compile KeenOptic.ExternalData
      # @after_compile KeenOptic.ExternalData

      # Default implementations for our behaviours.
      def coerce_params(params), do: {:ok, params}
      def extra_changes(changeset, _params), do: changeset

      defoverridable coerce_params: 1, extra_changes: 2
    end
  end

  defmacro __before_compile__(env) do
    quote location: :keep do
      @type t() :: %unquote(env.module){}

      @spec new(map() | list(map())) :: {:ok, t()} | {:error, String.t()}
      def new(list) when is_list(list) do
        results =
          list
          |> Enum.map(&new/1)
          |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

        case results do
          %{error: [error | _rest]} -> {:error, error}
          %{ok: data} -> {:ok, data}
          %{} -> {:ok, []}
        end
      end

      def new(params) when is_map(params) do
        with {:ok, params} <- coerce_params(params),
             {:ok, data} <- do_cast(params) do
          {:ok, data}
        else
          {:error, %Ecto.Changeset{} = changeset} ->
            {:error, error_string(changeset)}

          {:error, _error} = error ->
            error
        end
      end

      defp do_cast(params) do
        embeds = :embeds |> __schema__() |> MapSet.new()

        allowed_params =
          :fields
          |> __schema__()
          |> MapSet.new()
          |> MapSet.difference(embeds)
          |> MapSet.to_list()

        %unquote(env.module){}
        |> cast(params, allowed_params)
        |> extra_changes(params)
        |> apply_action(:insert)
      end

      defp error_string(%Ecto.Changeset{} = changeset) do
        changeset
        |> Ecto.Changeset.traverse_errors(&elem(&1, 0))
        |> Enum.reduce("", fn {key, value}, acc ->
          "#{acc}#{Atom.to_string(key)} #{value}. "
        end)
        |> String.trim_trailing()
      end
    end
  end
end
