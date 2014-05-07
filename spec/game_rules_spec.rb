require 'spec_helper'

describe GameRules do 
  let (:game_rules)  {GameRules.new}
  let (:board)       {Board.new}

  context "#valid_move?" do
    it "returns true for a valid move" do 
      game_rules.valid?(0, board).should == true
    end

    it "returns false for a move of 100" do 
      game_rules.valid?(100, board).should == false
    end

    it "returns false for a taken space" do 
      board.spaces[0] = 'X'

      game_rules.valid?(0, board).should == false
    end
  end

  context "#full?" do 
    it "returns false for a board that is not full" do
      board.spaces = [nil] * 9

      game_rules.full?(board.spaces).should == false
    end

    it "returns true for a full board" do 
      board.spaces = ["X"]*9

      game_rules.full?(board.spaces).should == true
    end
  end 

  context "#tie?" do 
    it 'returns true in the case of a tie' do 
      board.spaces[0] = 'X'
      board.spaces[1] = 'X'
      board.spaces[2] = 'O'
      board.spaces[3] = 'O'
      board.spaces[4] = 'O'
      board.spaces[5] = 'X'
      board.spaces[6] = 'X'
      board.spaces[7] = 'X'
      board.spaces[8] = 'O'

      game_rules.tie?(board.spaces).should == true
    end

    it 'returns false in the case of a win' do 
      board.spaces = ["X"] * 9

      game_rules.tie?(board.spaces).should == false
    end

    it 'returns false in the case of an empty board' do
      board.spaces = [nil] * 9

      game_rules.tie?(board.spaces).should == false
    end
  end

  context "#game_over?" do 
    it "returns true for a full board" do 
      board.spaces = ["X"]*9

      game_rules.game_over?(board.spaces).should == true
    end

    it "returns false if the game is not over" do       
      game_rules.winner(board.spaces).should == false
    end
  end

  context "#winner" do 
    it "returns the winner on a full board" do 
      board.spaces = ['X'] * 9

      game_rules.winner(board.spaces).should == "X"
    end

    it "returns the winner on a partially full board" do 
      board.spaces[0] = 'X'
      board.spaces[3] = 'X'
      board.spaces[6] = 'X'

      game_rules.winner(board.spaces).should == 'X'
    end

    it "returns the false if there is no winner" do 
      board.spaces = [nil] * 9

      game_rules.winner(board.spaces).should == false
    end

    it "returns false in the case of a tie" do 
      board.spaces[0] = 'X'
      board.spaces[1] = 'X'
      board.spaces[2] = 'O'
      board.spaces[3] = 'O'
      board.spaces[4] = 'O'
      board.spaces[5] = 'X'
      board.spaces[6] = 'X'
      board.spaces[7] = 'X'
      board.spaces[8] = 'O'

      game_rules.winner(board.spaces).should == false
    end
  end
end