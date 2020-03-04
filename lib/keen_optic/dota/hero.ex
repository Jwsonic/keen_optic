defmodule KeenOptic.Dota.Hero do
  @moduledoc """
  The Hero module contains
  """
  use Ecto.Schema

  alias __MODULE__

  @term_key __MODULE__

  @type t() :: %Hero{}

  @primary_key {:id, :id, autogenerate: false}
  embedded_schema do
    field :name, :string
    field :image_url, :string
  end

  @spec heroes() :: %{required(non_neg_integer()) => Hero.t()}
  def heroes do
    try do
      :persistent_term.get(@term_key)
    rescue
      _ ->
        :persistent_term.put(@term_key, hero_map())
        :persistent_term.get(@term_key)
    end
  end

  @spec hero(non_neg_integer()) :: Hero.t() | :unknown
  def hero(hero_id) do
    Map.get(heroes(), hero_id, :unknown)
  end

  # This has to be a function so we can reference the struct.
  defp hero_map do
    %{
      105 => %Hero{
        id: 105,
        image_url: "/images/heroes/icons/techies.png",
        name: "npc_dota_hero_techies"
      },
      48 => %Hero{
        id: 48,
        image_url: "/images/heroes/icons/luna.png",
        name: "npc_dota_hero_luna"
      },
      62 => %Hero{
        id: 62,
        image_url: "/images/heroes/icons/bounty_hunter.png",
        name: "npc_dota_hero_bounty_hunter"
      },
      11 => %Hero{
        id: 11,
        image_url: "/images/heroes/icons/nevermore.png",
        name: "npc_dota_hero_nevermore"
      },
      39 => %Hero{
        id: 39,
        image_url: "/images/heroes/icons/queenofpain.png",
        name: "npc_dota_hero_queenofpain"
      },
      83 => %Hero{
        id: 83,
        image_url: "/images/heroes/icons/treant.png",
        name: "npc_dota_hero_treant"
      },
      63 => %Hero{
        id: 63,
        image_url: "/images/heroes/icons/weaver.png",
        name: "npc_dota_hero_weaver"
      },
      34 => %Hero{
        id: 34,
        image_url: "/images/heroes/icons/tinker.png",
        name: "npc_dota_hero_tinker"
      },
      68 => %Hero{
        id: 68,
        image_url: "/images/heroes/icons/ancient_apparition.png",
        name: "npc_dota_hero_ancient_apparition"
      },
      26 => %Hero{
        id: 26,
        image_url: "/images/heroes/icons/lion.png",
        name: "npc_dota_hero_lion"
      },
      78 => %Hero{
        id: 78,
        image_url: "/images/heroes/icons/brewmaster.png",
        name: "npc_dota_hero_brewmaster"
      },
      52 => %Hero{
        id: 52,
        image_url: "/images/heroes/icons/leshrac.png",
        name: "npc_dota_hero_leshrac"
      },
      15 => %Hero{
        id: 15,
        image_url: "/images/heroes/icons/razor.png",
        name: "npc_dota_hero_razor"
      },
      64 => %Hero{
        id: 64,
        image_url: "/images/heroes/icons/jakiro.png",
        name: "npc_dota_hero_jakiro"
      },
      75 => %Hero{
        id: 75,
        image_url: "/images/heroes/icons/silencer.png",
        name: "npc_dota_hero_silencer"
      },
      81 => %Hero{
        id: 81,
        image_url: "/images/heroes/icons/chaos_knight.png",
        name: "npc_dota_hero_chaos_knight"
      },
      71 => %Hero{
        id: 71,
        image_url: "/images/heroes/icons/spirit_breaker.png",
        name: "npc_dota_hero_spirit_breaker"
      },
      129 => %Hero{
        id: 129,
        image_url: "/images/heroes/icons/mars.png",
        name: "npc_dota_hero_mars"
      },
      20 => %Hero{
        id: 20,
        image_url: "/images/heroes/icons/vengefulspirit.png",
        name: "npc_dota_hero_vengefulspirit"
      },
      109 => %Hero{
        id: 109,
        image_url: "/images/heroes/icons/terrorblade.png",
        name: "npc_dota_hero_terrorblade"
      },
      50 => %Hero{
        id: 50,
        image_url: "/images/heroes/icons/dazzle.png",
        name: "npc_dota_hero_dazzle"
      },
      17 => %Hero{
        id: 17,
        image_url: "/images/heroes/icons/storm_spirit.png",
        name: "npc_dota_hero_storm_spirit"
      },
      111 => %Hero{
        id: 111,
        image_url: "/images/heroes/icons/oracle.png",
        name: "npc_dota_hero_oracle"
      },
      25 => %Hero{
        id: 25,
        image_url: "/images/heroes/icons/lina.png",
        name: "npc_dota_hero_lina"
      },
      65 => %Hero{
        id: 65,
        image_url: "/images/heroes/icons/batrider.png",
        name: "npc_dota_hero_batrider"
      },
      98 => %Hero{
        id: 98,
        image_url: "/images/heroes/icons/shredder.png",
        name: "npc_dota_hero_shredder"
      },
      79 => %Hero{
        id: 79,
        image_url: "/images/heroes/icons/shadow_demon.png",
        name: "npc_dota_hero_shadow_demon"
      },
      13 => %Hero{
        id: 13,
        image_url: "/images/heroes/icons/puck.png",
        name: "npc_dota_hero_puck"
      },
      44 => %Hero{
        id: 44,
        image_url: "/images/heroes/icons/phantom_assassin.png",
        name: "npc_dota_hero_phantom_assassin"
      },
      8 => %Hero{
        id: 8,
        image_url: "/images/heroes/icons/juggernaut.png",
        name: "npc_dota_hero_juggernaut"
      },
      99 => %Hero{
        id: 99,
        image_url: "/images/heroes/icons/bristleback.png",
        name: "npc_dota_hero_bristleback"
      },
      36 => %Hero{
        id: 36,
        image_url: "/images/heroes/icons/necrolyte.png",
        name: "npc_dota_hero_necrolyte"
      },
      67 => %Hero{
        id: 67,
        image_url: "/images/heroes/icons/spectre.png",
        name: "npc_dota_hero_spectre"
      },
      7 => %Hero{
        id: 7,
        image_url: "/images/heroes/icons/earthshaker.png",
        name: "npc_dota_hero_earthshaker"
      },
      66 => %Hero{
        id: 66,
        image_url: "/images/heroes/icons/chen.png",
        name: "npc_dota_hero_chen"
      },
      85 => %Hero{
        id: 85,
        image_url: "/images/heroes/icons/undying.png",
        name: "npc_dota_hero_undying"
      },
      76 => %Hero{
        id: 76,
        image_url: "/images/heroes/icons/obsidian_destroyer.png",
        name: "npc_dota_hero_obsidian_destroyer"
      },
      1 => %Hero{
        id: 1,
        image_url: "/images/heroes/icons/antimage.png",
        name: "npc_dota_hero_antimage"
      },
      32 => %Hero{
        id: 32,
        image_url: "/images/heroes/icons/riki.png",
        name: "npc_dota_hero_riki"
      },
      69 => %Hero{
        id: 69,
        image_url: "/images/heroes/icons/doom_bringer.png",
        name: "npc_dota_hero_doom_bringer"
      },
      37 => %Hero{
        id: 37,
        image_url: "/images/heroes/icons/warlock.png",
        name: "npc_dota_hero_warlock"
      },
      126 => %Hero{
        id: 126,
        image_url: "/images/heroes/icons/void_spirit.png",
        name: "npc_dota_hero_void_spirit"
      },
      35 => %Hero{
        id: 35,
        image_url: "/images/heroes/icons/sniper.png",
        name: "npc_dota_hero_sniper"
      },
      84 => %Hero{
        id: 84,
        image_url: "/images/heroes/icons/ogre_magi.png",
        name: "npc_dota_hero_ogre_magi"
      },
      104 => %Hero{
        id: 104,
        image_url: "/images/heroes/icons/legion_commander.png",
        name: "npc_dota_hero_legion_commander"
      },
      3 => %Hero{
        id: 3,
        image_url: "/images/heroes/icons/bane.png",
        name: "npc_dota_hero_bane"
      },
      82 => %Hero{
        id: 82,
        image_url: "/images/heroes/icons/meepo.png",
        name: "npc_dota_hero_meepo"
      },
      119 => %Hero{
        id: 119,
        image_url: "/images/heroes/icons/dark_willow.png",
        name: "npc_dota_hero_dark_willow"
      },
      45 => %Hero{
        id: 45,
        image_url: "/images/heroes/icons/pugna.png",
        name: "npc_dota_hero_pugna"
      },
      55 => %Hero{
        id: 55,
        image_url: "/images/heroes/icons/dark_seer.png",
        name: "npc_dota_hero_dark_seer"
      },
      6 => %Hero{
        id: 6,
        image_url: "/images/heroes/icons/drow_ranger.png",
        name: "npc_dota_hero_drow_ranger"
      },
      2 => %Hero{
        id: 2,
        image_url: "/images/heroes/icons/axe.png",
        name: "npc_dota_hero_axe"
      },
      94 => %Hero{
        id: 94,
        image_url: "/images/heroes/icons/medusa.png",
        name: "npc_dota_hero_medusa"
      },
      49 => %Hero{
        id: 49,
        image_url: "/images/heroes/icons/dragon_knight.png",
        name: "npc_dota_hero_dragon_knight"
      },
      106 => %Hero{
        id: 106,
        image_url: "/images/heroes/icons/ember_spirit.png",
        name: "npc_dota_hero_ember_spirit"
      },
      41 => %Hero{
        id: 41,
        image_url: "/images/heroes/icons/faceless_void.png",
        name: "npc_dota_hero_faceless_void"
      },
      91 => %Hero{
        id: 91,
        image_url: "/images/heroes/icons/wisp.png",
        name: "npc_dota_hero_wisp"
      },
      87 => %Hero{
        id: 87,
        image_url: "/images/heroes/icons/disruptor.png",
        name: "npc_dota_hero_disruptor"
      },
      33 => %Hero{
        id: 33,
        image_url: "/images/heroes/icons/enigma.png",
        name: "npc_dota_hero_enigma"
      },
      42 => %Hero{
        id: 42,
        image_url: "/images/heroes/icons/skeleton_king.png",
        name: "npc_dota_hero_skeleton_king"
      },
      74 => %Hero{
        id: 74,
        image_url: "/images/heroes/icons/invoker.png",
        name: "npc_dota_hero_invoker"
      },
      120 => %Hero{
        id: 120,
        image_url: "/images/heroes/icons/pangolier.png",
        name: "npc_dota_hero_pangolier"
      },
      113 => %Hero{
        id: 113,
        image_url: "/images/heroes/icons/arc_warden.png",
        name: "npc_dota_hero_arc_warden"
      },
      60 => %Hero{
        id: 60,
        image_url: "/images/heroes/icons/night_stalker.png",
        name: "npc_dota_hero_night_stalker"
      },
      43 => %Hero{
        id: 43,
        image_url: "/images/heroes/icons/death_prophet.png",
        name: "npc_dota_hero_death_prophet"
      },
      10 => %Hero{
        id: 10,
        image_url: "/images/heroes/icons/morphling.png",
        name: "npc_dota_hero_morphling"
      },
      70 => %Hero{
        id: 70,
        image_url: "/images/heroes/icons/ursa.png",
        name: "npc_dota_hero_ursa"
      },
      9 => %Hero{
        id: 9,
        image_url: "/images/heroes/icons/mirana.png",
        name: "npc_dota_hero_mirana"
      },
      72 => %Hero{
        id: 72,
        image_url: "/images/heroes/icons/gyrocopter.png",
        name: "npc_dota_hero_gyrocopter"
      },
      121 => %Hero{
        id: 121,
        image_url: "/images/heroes/icons/grimstroke.png",
        name: "npc_dota_hero_grimstroke"
      },
      86 => %Hero{
        id: 86,
        image_url: "/images/heroes/icons/rubick.png",
        name: "npc_dota_hero_rubick"
      },
      19 => %Hero{
        id: 19,
        image_url: "/images/heroes/icons/tiny.png",
        name: "npc_dota_hero_tiny"
      },
      56 => %Hero{
        id: 56,
        image_url: "/images/heroes/icons/clinkz.png",
        name: "npc_dota_hero_clinkz"
      },
      95 => %Hero{
        id: 95,
        image_url: "/images/heroes/icons/troll_warlord.png",
        name: "npc_dota_hero_troll_warlord"
      },
      128 => %Hero{
        id: 128,
        image_url: "/images/heroes/icons/snapfire.png",
        name: "npc_dota_hero_snapfire"
      },
      57 => %Hero{
        id: 57,
        image_url: "/images/heroes/icons/omniknight.png",
        name: "npc_dota_hero_omniknight"
      },
      51 => %Hero{
        id: 51,
        image_url: "/images/heroes/icons/rattletrap.png",
        name: "npc_dota_hero_rattletrap"
      },
      101 => %Hero{
        id: 101,
        image_url: "/images/heroes/icons/skywrath_mage.png",
        name: "npc_dota_hero_skywrath_mage"
      },
      14 => %Hero{
        id: 14,
        image_url: "/images/heroes/icons/pudge.png",
        name: "npc_dota_hero_pudge"
      },
      5 => %Hero{
        id: 5,
        image_url: "/images/heroes/icons/crystal_maiden.png",
        name: "npc_dota_hero_crystal_maiden"
      },
      54 => %Hero{
        id: 54,
        image_url: "/images/heroes/icons/life_stealer.png",
        name: "npc_dota_hero_life_stealer"
      },
      18 => %Hero{
        id: 18,
        image_url: "/images/heroes/icons/sven.png",
        name: "npc_dota_hero_sven"
      },
      61 => %Hero{
        id: 61,
        image_url: "/images/heroes/icons/broodmother.png",
        name: "npc_dota_hero_broodmother"
      },
      103 => %Hero{
        id: 103,
        image_url: "/images/heroes/icons/elder_titan.png",
        name: "npc_dota_hero_elder_titan"
      },
      31 => %Hero{
        id: 31,
        image_url: "/images/heroes/icons/lich.png",
        name: "npc_dota_hero_lich"
      },
      22 => %Hero{
        id: 22,
        image_url: "/images/heroes/icons/zuus.png",
        name: "npc_dota_hero_zuus"
      },
      29 => %Hero{
        id: 29,
        image_url: "/images/heroes/icons/tidehunter.png",
        name: "npc_dota_hero_tidehunter"
      },
      114 => %Hero{
        id: 114,
        image_url: "/images/heroes/icons/monkey_king.png",
        name: "npc_dota_hero_monkey_king"
      },
      97 => %Hero{
        id: 97,
        image_url: "/images/heroes/icons/magnataur.png",
        name: "npc_dota_hero_magnataur"
      },
      21 => %Hero{
        id: 21,
        image_url: "/images/heroes/icons/windrunner.png",
        name: "npc_dota_hero_windrunner"
      },
      89 => %Hero{
        id: 89,
        image_url: "/images/heroes/icons/naga_siren.png",
        name: "npc_dota_hero_naga_siren"
      },
      27 => %Hero{
        id: 27,
        image_url: "/images/heroes/icons/shadow_shaman.png",
        name: "npc_dota_hero_shadow_shaman"
      },
      107 => %Hero{
        id: 107,
        image_url: "/images/heroes/icons/earth_spirit.png",
        name: "npc_dota_hero_earth_spirit"
      },
      47 => %Hero{
        id: 47,
        image_url: "/images/heroes/icons/viper.png",
        name: "npc_dota_hero_viper"
      },
      100 => %Hero{
        id: 100,
        image_url: "/images/heroes/icons/tusk.png",
        name: "npc_dota_hero_tusk"
      },
      40 => %Hero{
        id: 40,
        image_url: "/images/heroes/icons/venomancer.png",
        name: "npc_dota_hero_venomancer"
      },
      96 => %Hero{
        id: 96,
        image_url: "/images/heroes/icons/centaur.png",
        name: "npc_dota_hero_centaur"
      },
      73 => %Hero{
        id: 73,
        image_url: "/images/heroes/icons/alchemist.png",
        name: "npc_dota_hero_alchemist"
      },
      90 => %Hero{
        id: 90,
        image_url: "/images/heroes/icons/keeper_of_the_light.png",
        name: "npc_dota_hero_keeper_of_the_light"
      },
      30 => %Hero{
        id: 30,
        image_url: "/images/heroes/icons/witch_doctor.png",
        name: "npc_dota_hero_witch_doctor"
      },
      58 => %Hero{
        id: 58,
        image_url: "/images/heroes/icons/enchantress.png",
        name: "npc_dota_hero_enchantress"
      },
      80 => %Hero{
        id: 80,
        image_url: "/images/heroes/icons/lone_druid.png",
        name: "npc_dota_hero_lone_druid"
      },
      88 => %Hero{
        id: 88,
        image_url: "/images/heroes/icons/nyx_assassin.png",
        name: "npc_dota_hero_nyx_assassin"
      },
      59 => %Hero{
        id: 59,
        image_url: "/images/heroes/icons/huskar.png",
        name: "npc_dota_hero_huskar"
      },
      77 => %Hero{
        id: 77,
        image_url: "/images/heroes/icons/lycan.png",
        name: "npc_dota_hero_lycan"
      },
      23 => %Hero{
        id: 23,
        image_url: "/images/heroes/icons/kunkka.png",
        name: "npc_dota_hero_kunkka"
      },
      28 => %Hero{
        id: 28,
        image_url: "/images/heroes/icons/slardar.png",
        name: "npc_dota_hero_slardar"
      },
      46 => %Hero{
        id: 46,
        image_url: "/images/heroes/icons/templar_assassin.png",
        name: "npc_dota_hero_templar_assassin"
      },
      102 => %Hero{
        id: 102,
        image_url: "/images/heroes/icons/abaddon.png",
        name: "npc_dota_hero_abaddon"
      },
      108 => %Hero{
        id: 108,
        image_url: "/images/heroes/icons/abyssal_underlord.png",
        name: "npc_dota_hero_abyssal_underlord"
      },
      112 => %Hero{
        id: 112,
        image_url: "/images/heroes/icons/winter_wyvern.png",
        name: "npc_dota_hero_winter_wyvern"
      },
      92 => %Hero{
        id: 92,
        image_url: "/images/heroes/icons/visage.png",
        name: "npc_dota_hero_visage"
      },
      53 => %Hero{
        id: 53,
        image_url: "/images/heroes/icons/furion.png",
        name: "npc_dota_hero_furion"
      },
      93 => %Hero{
        id: 93,
        image_url: "/images/heroes/icons/slark.png",
        name: "npc_dota_hero_slark"
      },
      110 => %Hero{
        id: 110,
        image_url: "/images/heroes/icons/phoenix.png",
        name: "npc_dota_hero_phoenix"
      },
      16 => %Hero{
        id: 16,
        image_url: "/images/heroes/icons/sand_king.png",
        name: "npc_dota_hero_sand_king"
      },
      38 => %Hero{
        id: 38,
        image_url: "/images/heroes/icons/beastmaster.png",
        name: "npc_dota_hero_beastmaster"
      },
      4 => %Hero{
        id: 4,
        image_url: "/images/heroes/icons/bloodseeker.png",
        name: "npc_dota_hero_bloodseeker"
      },
      12 => %Hero{
        id: 12,
        image_url: "/images/heroes/icons/phantom_lancer.png",
        name: "npc_dota_hero_phantom_lancer"
      }
    }
  end
end
