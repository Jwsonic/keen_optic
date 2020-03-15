defmodule KeenOptic.DotaTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias KeenOptic.Dota
  alias KeenOptic.Dota.LiveGame

  setup_all do
    HTTPoison.start()
  end

  describe "Dota.live_games/0" do
    test "it fetches and parses live games correctly" do
      use_cassette "live_games" do
        assert {:ok, games} = Dota.live_games()

        assert 10 = length(games)

        Enum.each(games, fn game -> assert %LiveGame{} = game end)

        assert [
                 %KeenOptic.Dota.LiveGame{
                   average_mmr: nil,
                   dire_score: nil,
                   game_mode: 22,
                   game_time: 2543,
                   league_id: 0,
                   players: [
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 404_150_207,
                       hero: %KeenOptic.Dota.Hero{
                         id: 66,
                         image_url: "/images/heroes/icons/chen.png",
                         name: "npc_dota_hero_chen"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 115_331_673,
                       hero: %KeenOptic.Dota.Hero{
                         id: 128,
                         image_url: "/images/heroes/icons/snapfire.png",
                         name: "npc_dota_hero_snapfire"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 415_766_070,
                       hero: %KeenOptic.Dota.Hero{
                         id: 93,
                         image_url: "/images/heroes/icons/slark.png",
                         name: "npc_dota_hero_slark"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 141_729_618,
                       hero: %KeenOptic.Dota.Hero{
                         id: 126,
                         image_url: "/images/heroes/icons/void_spirit.png",
                         name: "npc_dota_hero_void_spirit"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 363_871_826,
                       hero: %KeenOptic.Dota.Hero{
                         id: 98,
                         image_url: "/images/heroes/icons/shredder.png",
                         name: "npc_dota_hero_shredder"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 113_929_302,
                       hero: %KeenOptic.Dota.Hero{
                         id: 88,
                         image_url: "/images/heroes/icons/nyx_assassin.png",
                         name: "npc_dota_hero_nyx_assassin"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 117_514_269,
                       hero: %KeenOptic.Dota.Hero{
                         id: 96,
                         image_url: "/images/heroes/icons/centaur.png",
                         name: "npc_dota_hero_centaur"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 1_005_588_988,
                       hero: %KeenOptic.Dota.Hero{
                         id: 89,
                         image_url: "/images/heroes/icons/naga_siren.png",
                         name: "npc_dota_hero_naga_siren"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 144_336_093,
                       hero: %KeenOptic.Dota.Hero{
                         id: 65,
                         image_url: "/images/heroes/icons/batrider.png",
                         name: "npc_dota_hero_batrider"
                       }
                     },
                     %KeenOptic.Dota.LiveGame.Player{
                       account_id: 19_672_354,
                       hero: %KeenOptic.Dota.Hero{
                         id: 58,
                         image_url: "/images/heroes/icons/enchantress.png",
                         name: "npc_dota_hero_enchantress"
                       }
                     }
                   ],
                   radiant_lead: nil,
                   radiant_score: nil,
                   server_steam_id: 90_133_485_951_488_011,
                   spectators: 741
                 }
                 | _rest
               ] = games
      end
    end
  end
end
