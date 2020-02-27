defmodule KeenOptic.Dota.Hero do
  @moduledoc """
  The Hero module contains
  """
  use Ecto.Schema

  alias __MODULE__

  @term_key __MODULE__

  @primary_key {:id, :id, autogenerate: false}
  embedded_schema do
    field :name, :string
  end

  def all_heroes do
    try do
      :persistent_term.get(@term_key)
    rescue
      _ ->
        :persistent_term.put(@term_key, heroes())
        :persistent_term.get(@term_key)
    end
  end

  defp heroes do
    [
      %Hero{
        name: "npc_dota_hero_antimage",
        id: 1
      },
      %Hero{
        name: "npc_dota_hero_axe",
        id: 2
      },
      %Hero{
        name: "npc_dota_hero_bane",
        id: 3
      },
      %Hero{
        name: "npc_dota_hero_bloodseeker",
        id: 4
      },
      %Hero{
        name: "npc_dota_hero_crystal_maiden",
        id: 5
      },
      %Hero{
        name: "npc_dota_hero_drow_ranger",
        id: 6
      },
      %Hero{
        name: "npc_dota_hero_earthshaker",
        id: 7
      },
      %Hero{
        name: "npc_dota_hero_juggernaut",
        id: 8
      },
      %Hero{
        name: "npc_dota_hero_mirana",
        id: 9
      },
      %Hero{
        name: "npc_dota_hero_nevermore",
        id: 11
      },
      %Hero{
        name: "npc_dota_hero_morphling",
        id: 10
      },
      %Hero{
        name: "npc_dota_hero_phantom_lancer",
        id: 12
      },
      %Hero{
        name: "npc_dota_hero_puck",
        id: 13
      },
      %Hero{
        name: "npc_dota_hero_pudge",
        id: 14
      },
      %Hero{
        name: "npc_dota_hero_razor",
        id: 15
      },
      %Hero{
        name: "npc_dota_hero_sand_king",
        id: 16
      },
      %Hero{
        name: "npc_dota_hero_storm_spirit",
        id: 17
      },
      %Hero{
        name: "npc_dota_hero_sven",
        id: 18
      },
      %Hero{
        name: "npc_dota_hero_tiny",
        id: 19
      },
      %Hero{
        name: "npc_dota_hero_vengefulspirit",
        id: 20
      },
      %Hero{
        name: "npc_dota_hero_windrunner",
        id: 21
      },
      %Hero{
        name: "npc_dota_hero_zuus",
        id: 22
      },
      %Hero{
        name: "npc_dota_hero_kunkka",
        id: 23
      },
      %Hero{
        name: "npc_dota_hero_lina",
        id: 25
      },
      %Hero{
        name: "npc_dota_hero_lich",
        id: 31
      },
      %Hero{
        name: "npc_dota_hero_lion",
        id: 26
      },
      %Hero{
        name: "npc_dota_hero_shadow_shaman",
        id: 27
      },
      %Hero{
        name: "npc_dota_hero_slardar",
        id: 28
      },
      %Hero{
        name: "npc_dota_hero_tidehunter",
        id: 29
      },
      %Hero{
        name: "npc_dota_hero_witch_doctor",
        id: 30
      },
      %Hero{
        name: "npc_dota_hero_riki",
        id: 32
      },
      %Hero{
        name: "npc_dota_hero_enigma",
        id: 33
      },
      %Hero{
        name: "npc_dota_hero_tinker",
        id: 34
      },
      %Hero{
        name: "npc_dota_hero_sniper",
        id: 35
      },
      %Hero{
        name: "npc_dota_hero_necrolyte",
        id: 36
      },
      %Hero{
        name: "npc_dota_hero_warlock",
        id: 37
      },
      %Hero{
        name: "npc_dota_hero_beastmaster",
        id: 38
      },
      %Hero{
        name: "npc_dota_hero_queenofpain",
        id: 39
      },
      %Hero{
        name: "npc_dota_hero_venomancer",
        id: 40
      },
      %Hero{
        name: "npc_dota_hero_faceless_void",
        id: 41
      },
      %Hero{
        name: "npc_dota_hero_skeleton_king",
        id: 42
      },
      %Hero{
        name: "npc_dota_hero_death_prophet",
        id: 43
      },
      %Hero{
        name: "npc_dota_hero_phantom_assassin",
        id: 44
      },
      %Hero{
        name: "npc_dota_hero_pugna",
        id: 45
      },
      %Hero{
        name: "npc_dota_hero_templar_assassin",
        id: 46
      },
      %Hero{
        name: "npc_dota_hero_viper",
        id: 47
      },
      %Hero{
        name: "npc_dota_hero_luna",
        id: 48
      },
      %Hero{
        name: "npc_dota_hero_dragon_knight",
        id: 49
      },
      %Hero{
        name: "npc_dota_hero_dazzle",
        id: 50
      },
      %Hero{
        name: "npc_dota_hero_rattletrap",
        id: 51
      },
      %Hero{
        name: "npc_dota_hero_leshrac",
        id: 52
      },
      %Hero{
        name: "npc_dota_hero_furion",
        id: 53
      },
      %Hero{
        name: "npc_dota_hero_life_stealer",
        id: 54
      },
      %Hero{
        name: "npc_dota_hero_dark_seer",
        id: 55
      },
      %Hero{
        name: "npc_dota_hero_clinkz",
        id: 56
      },
      %Hero{
        name: "npc_dota_hero_omniknight",
        id: 57
      },
      %Hero{
        name: "npc_dota_hero_enchantress",
        id: 58
      },
      %Hero{
        name: "npc_dota_hero_huskar",
        id: 59
      },
      %Hero{
        name: "npc_dota_hero_night_stalker",
        id: 60
      },
      %Hero{
        name: "npc_dota_hero_broodmother",
        id: 61
      },
      %Hero{
        name: "npc_dota_hero_bounty_hunter",
        id: 62
      },
      %Hero{
        name: "npc_dota_hero_weaver",
        id: 63
      },
      %Hero{
        name: "npc_dota_hero_jakiro",
        id: 64
      },
      %Hero{
        name: "npc_dota_hero_batrider",
        id: 65
      },
      %Hero{
        name: "npc_dota_hero_chen",
        id: 66
      },
      %Hero{
        name: "npc_dota_hero_spectre",
        id: 67
      },
      %Hero{
        name: "npc_dota_hero_doom_bringer",
        id: 69
      },
      %Hero{
        name: "npc_dota_hero_ancient_apparition",
        id: 68
      },
      %Hero{
        name: "npc_dota_hero_ursa",
        id: 70
      },
      %Hero{
        name: "npc_dota_hero_spirit_breaker",
        id: 71
      },
      %Hero{
        name: "npc_dota_hero_gyrocopter",
        id: 72
      },
      %Hero{
        name: "npc_dota_hero_alchemist",
        id: 73
      },
      %Hero{
        name: "npc_dota_hero_invoker",
        id: 74
      },
      %Hero{
        name: "npc_dota_hero_silencer",
        id: 75
      },
      %Hero{
        name: "npc_dota_hero_obsidian_destroyer",
        id: 76
      },
      %Hero{
        name: "npc_dota_hero_lycan",
        id: 77
      },
      %Hero{
        name: "npc_dota_hero_brewmaster",
        id: 78
      },
      %Hero{
        name: "npc_dota_hero_shadow_demon",
        id: 79
      },
      %Hero{
        name: "npc_dota_hero_lone_druid",
        id: 80
      },
      %Hero{
        name: "npc_dota_hero_chaos_knight",
        id: 81
      },
      %Hero{
        name: "npc_dota_hero_meepo",
        id: 82
      },
      %Hero{
        name: "npc_dota_hero_treant",
        id: 83
      },
      %Hero{
        name: "npc_dota_hero_ogre_magi",
        id: 84
      },
      %Hero{
        name: "npc_dota_hero_undying",
        id: 85
      },
      %Hero{
        name: "npc_dota_hero_rubick",
        id: 86
      },
      %Hero{
        name: "npc_dota_hero_disruptor",
        id: 87
      },
      %Hero{
        name: "npc_dota_hero_nyx_assassin",
        id: 88
      },
      %Hero{
        name: "npc_dota_hero_naga_siren",
        id: 89
      },
      %Hero{
        name: "npc_dota_hero_keeper_of_the_light",
        id: 90
      },
      %Hero{
        name: "npc_dota_hero_wisp",
        id: 91
      },
      %Hero{
        name: "npc_dota_hero_visage",
        id: 92
      },
      %Hero{
        name: "npc_dota_hero_slark",
        id: 93
      },
      %Hero{
        name: "npc_dota_hero_medusa",
        id: 94
      },
      %Hero{
        name: "npc_dota_hero_troll_warlord",
        id: 95
      },
      %Hero{
        name: "npc_dota_hero_centaur",
        id: 96
      },
      %Hero{
        name: "npc_dota_hero_magnataur",
        id: 97
      },
      %Hero{
        name: "npc_dota_hero_shredder",
        id: 98
      },
      %Hero{
        name: "npc_dota_hero_bristleback",
        id: 99
      },
      %Hero{
        name: "npc_dota_hero_tusk",
        id: 100
      },
      %Hero{
        name: "npc_dota_hero_skywrath_mage",
        id: 101
      },
      %Hero{
        name: "npc_dota_hero_abaddon",
        id: 102
      },
      %Hero{
        name: "npc_dota_hero_elder_titan",
        id: 103
      },
      %Hero{
        name: "npc_dota_hero_legion_commander",
        id: 104
      },
      %Hero{
        name: "npc_dota_hero_ember_spirit",
        id: 106
      },
      %Hero{
        name: "npc_dota_hero_earth_spirit",
        id: 107
      },
      %Hero{
        name: "npc_dota_hero_terrorblade",
        id: 109
      },
      %Hero{
        name: "npc_dota_hero_phoenix",
        id: 110
      },
      %Hero{
        name: "npc_dota_hero_oracle",
        id: 111
      },
      %Hero{
        name: "npc_dota_hero_techies",
        id: 105
      },
      %Hero{
        name: "npc_dota_hero_winter_wyvern",
        id: 112
      },
      %Hero{
        name: "npc_dota_hero_arc_warden",
        id: 113
      },
      %Hero{
        name: "npc_dota_hero_abyssal_underlord",
        id: 108
      },
      %Hero{
        name: "npc_dota_hero_monkey_king",
        id: 114
      },
      %Hero{
        name: "npc_dota_hero_pangolier",
        id: 120
      },
      %Hero{
        name: "npc_dota_hero_dark_willow",
        id: 119
      },
      %Hero{
        name: "npc_dota_hero_grimstroke",
        id: 121
      },
      %Hero{
        name: "npc_dota_hero_mars",
        id: 129
      },
      %Hero{
        name: "npc_dota_hero_void_spirit",
        id: 126
      },
      %Hero{
        name: "npc_dota_hero_snapfire",
        id: 128
      }
    ]
  end
end
