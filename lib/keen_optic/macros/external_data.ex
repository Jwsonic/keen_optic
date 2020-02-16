defmodule ExternalData do
  @moduledoc """
  ExternalData is a macro that adds a function `from_json` that will attempt to decode a `String.t()`
  into the struct.
  """

  defmacro __before_compile__(_env) do
    quote do
      import ExternalData

      ExternalData.__register_string_keys__(__MODULE__)

      @enforce_keys Module.get_attribute(__MODULE__, :enforce_keys, [])

      @types Module.get_attribute(__MODULE__, :types, []) |> IO.inspect()

      @spec from_json(String.t() | map()) ::
              {:ok, __MODULE__.t()} | {:error, String.t()} | {:error, Jason.DecodeError.t()}
      def from_json(string) when is_bitstring(string) do
        IO.inspect(@types)

        case Jason.decode(string) do
          {:ok, data} -> from_json(data)
          {:error, message} -> {:error, message}
        end
      end

      def from_json(data) when is_map(data) do
        allowed_data = ExternalData.__allowed_data__(@string_keys, data)

        case ExternalData.__missing_keys__(@enforce_keys, allowed_data) do
          [] -> {:ok, struct(__MODULE__, allowed_data)}
          keys -> {:error, "You must provide #{inspect(keys)}."}
        end
      end
    end
  end

  def __allowed_data__(allowed_keys, data) do
    data
    |> Map.take(allowed_keys)
    |> Enum.reduce(%{}, fn {key, value}, acc -> Map.put(acc, String.to_atom(key), value) end)
  end

  @doc false
  def __missing_keys__(enforce_keys, data) do
    Enum.reject(enforce_keys, &Map.has_key?(data, &1))
  end

  @doc false
  def __register_string_keys__(module) do
    Module.register_attribute(module, :string_keys, accumulate: true)

    module
    |> Module.get_attribute(:fields, [])
    |> Enum.each(fn {key, _value} ->
      Module.put_attribute(module, :string_keys, Atom.to_string(key))
    end)
  end
end
