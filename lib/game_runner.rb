$: << File.expand_path(File.dirname(__FILE__))
require 'ai'
require 'board'
require 'console_runner'
require 'ui'
require 'game_rules'

board = Board.new
game_rules = GameRules.new
ai = AI.new(game_rules)
ui = UI.new
console_runner = ConsoleRunner.new(ai, board, game_rules, ui)
console_runner.start_game
