defmodule KeenOptic.Dota.Pick do
  use TypedStruct
  @before_compile ExternalData

  typedstruct do
    field :hero, non_neg_integer(), enforce: true
    field :team, non_neg_integer(), enforce: true
  end
end
