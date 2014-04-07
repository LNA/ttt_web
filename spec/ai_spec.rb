require 'ai'
require 'board'
require 'game_rules'

describe AI do 

  let (:game_rules) {GameRules.new}
  let (:ai)         {AI.new(game_rules)}
  let (:board)      {Board.new}

  it "finds the best move for the first level" do 
    ai.game_piece = "O"
    board.spaces = [nil, "X", "O", 
                    "X", nil, "X", 
                    nil, "O", "O"]

    ai.find_best_move(board.spaces).should == 6
  end
end