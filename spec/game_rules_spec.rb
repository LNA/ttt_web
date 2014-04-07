require 'board'
require 'game_rules'

describe GameRules do 
  let (:spaces) {[nil]*9}
  let (:game_rules)  {GameRules.new}

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
end