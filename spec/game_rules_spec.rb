require 'board'
require 'game_rules'

describe GameRules do 
  let (:board)      {Board.new}
  let (:game_rules) {GameRules.new}

  it "returns true for a valid move" do 
    spaces = [nil]*9
    game_rules.valid(0, spaces).should == true
  end
end