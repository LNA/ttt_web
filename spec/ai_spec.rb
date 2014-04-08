require 'ai'
require 'game_rules'

describe AI do 
  let (:board)      {Board.new}
  let (:game_rules) {GameRules.new}

  before :each do
    @ai = AI.new(game_rules, board, "X")
    @ai.game_piece = "O"
  end

  context 'blocking opponent wins' do
    it "finds the best move for a game with a depth of zero" do 
      spaces = [nil, "X", "O", 
                "O", nil, nil, 
                nil, "X", "X"]

      @ai.find_best_move(spaces).should == 6
    end

    it "blocks an opponent win" do 
      spaces = [nil, nil, "X", 
                "X", nil, "X", 
                nil, nil, "O"]

      @ai.find_best_move(spaces).should == 4
    end
  end

  context 'playing a winning move' do
    it "plays a winning move instead" do
      spaces = [nil, nil, "X", 
                nil, nil, "X", 
                "O", nil, "O"]

      @ai.find_best_move(spaces).should == 7
    end

    it "plays a winning move instead of blocking an opponent" do 
      spaces = [nil, nil, "X", 
                "X", nil, "X", 
                "O", nil, "O"]

      @ai.find_best_move(spaces).should == 7
    end
  end
end