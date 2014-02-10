require 'spec_helper'
require 'mock_ui'
require 'mock_game_state'
require 'ui'
require 'console_runner'

describe ConsoleRunner do 
  let (:ui) {MockUI.new}
  let (:game_state) {MockGameState.new}

  let (:player_one_piece) {"X"}
  let (:player_two_piece) {"O"}
  let (:game) {Game.new(player_one_piece, player_two_piece)}

  let (:mock_ui) {MockUI.new}
  let (:mock_game_state) {MockGameState.new}

  let (:console_runner) {ConsoleRunner.new(ui, game_state, game)}

end

