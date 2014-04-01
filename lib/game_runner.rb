$: << File.expand_path(File.dirname(__FILE__))
require 'game'
require 'ui'
require 'game_options'
require 'game_state'
require 'console_runner'

ui = UI.new
game_state = GameState.new('X', Array.new(9))
console_runner = ConsoleRunner.new(ui, game_state)
console_runner.start_game

