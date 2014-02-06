$: << File.expand_path(File.dirname(__FILE__))
require 'game'
require 'ui'
require 'game_options'
require 'game_state'

ui = UI.new
ui.welcome
ui.ask_for_player_one_type
player_one = ui.gets_player_one_type
ui.ask_for_player_two_type
player_two = ui.gets_player_two_type

game_options = GameOptions.new(player_one, player_two)

game_options.set_player_type(player_one, player_two)
game_options.set_game_type()

game_state = GameState.new('X', Array.new(9))

game = Game.new(ui, game_options, game_state)

game.run