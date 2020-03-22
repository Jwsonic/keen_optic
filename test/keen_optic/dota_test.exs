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
                   average_mmr: 7908,
                   dire_score: 23,
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
                   radiant_lead: -5450,
                   radiant_score: 36,
                   server_steam_id: 90_133_485_951_488_011,
                   spectators: 741
                 }
                 | _rest
               ] = games
      end
    end
  end

  describe "Dota.real_time_stats/1" do
    test "it fetches and parses real time stats correctly" do
      use_cassette "real_time_stats" do
        assert {:ok,
                %KeenOptic.Dota.RealTimeStats{
                  dire: %KeenOptic.RealTimeStats.Team{
                    net_worth: 0,
                    players: [
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 99_394_623,
                        name: "get me out",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 321_580_662,
                        name: "Тварь",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 73_562_326,
                        name: "arturo b",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 72_312_627,
                        name: "kimchi",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 317_880_638,
                        name: "light your sword'",
                        x: 0.0,
                        y: 0.0
                      }
                    ],
                    score: 0
                  },
                  match: %KeenOptic.Dota.Match{
                    bans: [],
                    game_mode: 22,
                    game_state: 8,
                    game_time: -16,
                    league_id: 0,
                    match_id: 5_294_873_401,
                    picks: [],
                    server_steam_id: 90_133_486_099_891_208
                  },
                  match_id: nil,
                  radiant: %KeenOptic.RealTimeStats.Team{
                    net_worth: 0,
                    players: [
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 96_189_126,
                        name: ".safelane idc",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 25_907_144,
                        name: "土猫",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 366_396_778,
                        name: "mode Zang64000x4",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 54_580_962,
                        name: "Aang",
                        x: 0.0,
                        y: 0.0
                      },
                      %KeenOptic.RealTimeStats.Player{
                        account_id: 100_483_784,
                        name: "Max2",
                        x: 0.0,
                        y: 0.0
                      }
                    ],
                    score: 0
                  },
                  server_steam_id: nil
                }} = Dota.real_time_stats(90_133_486_099_891_208)
      end
    end
  end
end
