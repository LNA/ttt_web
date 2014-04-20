require 'board'
require 'game_rules'

describe GameRules do 
  let (:game_rules)  {GameRules.new}
  let (:board)       {Board.new}


  context "#valid_move" do
    it "returns true for a valid move" do 
      game_rules.valid(0, board.spaces).should == true
    end

    it "returns false for a move of 100" do 
      game_rules.valid(100, board.spaces).should == false
    end

    it "returns false for a taken space" do 
      board.spaces[0] = 'X'

      game_rules.valid(0, "O").should == false
    end
  end

  context "#full_board?" do 
    it "returns false for a board that is not full" do
      game_rules.full?(board.spaces).should == false
    end

    it "returns true for a full board" do 
      board.spaces = ["X"]*9

      game_rules.full?(board.spaces).should == true
    end
  end 

  context "#game_over" do 
    it "returns the winning game piece" do 
      board = ["X"]*9

      game_rules.winner(board).should == "X"
    end

    it "returns false in the case of a tie" do 
      board.spaces = ["X", "X", "O", 
                      "O", "O", "X", 
                      "X", "X", "O"]

      game_rules.winner(board.spaces).should == false

    end

    it "returns nil if the game is not over" do       
      game_rules.winner(board.spaces).should == nil
    end
  end
end