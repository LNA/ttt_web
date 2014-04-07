require 'board'
require 'game_rules'

describe GameRules do 
  let (:game_rules)  {GameRules.new}
  let (:spaces) {[nil]*9}


  context "#valid_move" do
    it "returns true for a valid move" do 
      game_rules.valid(0, spaces).should == true
    end

    it "returns false for a move of 100" do 
      game_rules.valid(100, spaces).should == false
    end

    it "returns false for a taken space" do 
      spaces[0] = 'X'

      game_rules.valid(0, "O").should == false
    end
  end

  context "#full_board?" do 
    it "returns false for a board that is not full" do
      game_rules.full_board?(spaces).should == false
    end

    it "returns true for a full board" do 
      spaces = ["X"]*9

      game_rules.full_board?(spaces).should == true
    end
  end 
end