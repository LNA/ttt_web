$: << File.expand_path(File.dirname(__FILE__))
require 'ai'
require 'board'
require 'console_runner'
require 'ui'
require 'game_options'
require 'game_rules'

ai = AI.new
board = Board.new
game_rules = GameRules.new
ui = UI.new
console_runner = ConsoleRunner.new(board, game_rules, ui)
console_runner.start_game