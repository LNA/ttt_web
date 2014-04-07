require 'board'

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
end