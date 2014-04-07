require 'ai'
require 'board'

describe AI do 
  let (:ai)    {AI.new}
  let (:board) {Board.new}

  it "makes a move" do 
    board.spaces = [nil, nil, nil, 
                    nil, "X", "X", 
                    nil, nil, nil]

    space = ai.find_best_move(board.spaces)
    baord.fill(space, 'O')

    baord.spaces.should == [nil, nil, nil, 
                            nil, "X", "X", 
                            nil, nil, nil]
  end
end