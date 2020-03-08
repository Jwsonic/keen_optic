defmodule KeenOptic.Ecto.UtilsTest do
  use ExUnit.Case, async: true

  alias KeenOptic.Ecto.Utils

  describe "rename_params/2" do
    test "it renames the given parameters" do
      result = Utils.rename_params(%{"key1" => "value1", "key2" => "value2"}, [{"key1", "key_1"}])

      assert %{"key_1" => "value1", "key2" => "value2"} == result
    end
  end
end
