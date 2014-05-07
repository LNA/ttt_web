require 'spec_helper'

describe Board do 
  let (:test_board) {Board.new}

  it "has nine spaces" do 
    test_board.spaces.count.should == 9 
  end

  it "can fill its spaces" do 
    test_board.fill(4, "X")

    test_board.spaces.should == [nil, nil, nil, 
                                 nil, "X", nil, 
                                 nil, nil, nil]
  end

  it "returns its open spaces" do 
    test_board.spaces = [nil]*9
    test_board.spaces[0] = 'X'
    test_board.spaces[1] = 'X'
    test_board.spaces[2] = 'X'
    
    test_board.open_spaces.should == [3, 4, 5, 6, 7, 8]
  end
end