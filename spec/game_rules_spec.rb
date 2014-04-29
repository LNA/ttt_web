require 'board'
require 'game_rules'

describe GameRules do 
  let (:game_rules)  {GameRules.new}
  let (:board)       {Board.new}


  context "#valid_move?" do
    it "returns true for a valid move" do 
      game_rules.valid?(0, board.spaces).should == true
    end

    it "returns false for a move of 100" do 
      game_rules.valid?(100, board.spaces).should == false
    end

    it "returns false for a taken space" do 
      board.spaces[0] = 'X'

      game_rules.valid?(0, "O").should == false
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

  context "#game_over?" do 
    it "returns true for a full board" do 
      board = ["X"]*9

      game_rules.game_over?(board).should == true
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

  context "top_corner_set_up" do 
    it "returns true for a 1-3 set up" do 
      board.spaces = [nil]*9
      board.spaces[1] = 'X'
      board.spaces[3] = 'X'

      game_rules.top_corner_set_up(board.spaces).should == true
    end

    it "returns true for a 1-5 set up" do 
      board.spaces = [nil]*9
      board.spaces[1] = 'X'
      board.spaces[5] = 'X'

      game_rules.top_corner_set_up(board.spaces).should == true
    end
  end

  context "bottom_corner_set_up" do
    it "returns true for a 7-3 set up" do 
      board.spaces = [nil]*9
      board.spaces[7] = 'X'
      board.spaces[3] = 'X'

      game_rules.bottom_corner_set_up(board.spaces).should == true
    end

    it "returns true for a 7-5 set up" do 
      board.spaces = [nil]*9
      board.spaces[7] = 'X'
      board.spaces[5] = 'X'

      game_rules.bottom_corner_set_up(board.spaces).should == true
    end
  end 
end