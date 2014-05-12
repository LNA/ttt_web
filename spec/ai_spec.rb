require 'spec_helper'

describe AI do
  let (:game_rules) {GameRules.new}
  let (:board)      {Board.new}

  before :each do
    @ai = AI.new(game_rules)
  end

  context '#find_best_move' do
    it 'plays the last open move' do
      board.spaces = ['X', 'O', 'O',
                      'X', 'O', 'X',
                      'O', nil, 'O']

      @ai.find_best_move(board, 'X', 'O').should == 7
    end

    it 'blocks the doubble set up' do 
      board.spaces = [nil] * 9 
      board.spaces[0] = 'O'
      board.spaces[4] = 'X'
      board.spaces[8] = 'X'

      acceptable_moves = [1, 2, 6]
      move = @ai.find_best_move(board, 'X', 'O')

      acceptable_moves.should include(move)
    end

    it "blocks the top left corner set up" do
      board.spaces = [nil] * 9
      board.spaces[1] = 'X'
      board.spaces[3] = 'X'
      board.spaces[4] = 'O'
      acceptable_moves = [0, 2]
      move = @ai.find_best_move(board, 'X', 'O')

      acceptable_moves.should include(move)
    end

    it "blocks the top right corner set up" do
      board.spaces = [nil] * 9
      board.spaces[1] = 'X'
      board.spaces[5] = 'X'
      board.spaces[4] = 'O'

      acceptable_moves = [0, 2]
      move = @ai.find_best_move(board, 'X', 'O')

      acceptable_moves.should include(move)
    end

    it "blocks the bottom left corner set up" do
      board.spaces = [nil] * 9
      board.spaces[7] = 'X'
      board.spaces[3] = 'X'
      board.spaces[4] = 'O'

      acceptable_moves = [0, 6]
      move = @ai.find_best_move(board, 'X', 'O')
      acceptable_moves.should include(move)
    end

    it "blocks the bottom right corner set up" do
      board.spaces = [nil] * 9
      board.spaces[5] = 'X'
      board.spaces[7] = 'X'
      board.spaces[4] = 'O'

      acceptable_moves = [0, 6]
      move = @ai.find_best_move(board, 'X', 'O')
      acceptable_moves.should include(move)
    end

    it 'blocks an L set up' do 
      board.spaces = [ 'X', nil, nil,
                       nil, 'O', nil,
                       nil, 'X', nil ]

      board.spaces[0] = 'X'
      board.spaces[7] = 'X'
      board.spaces[4] = 'O'

      acceptable_moves = [3, 5, 6, 8]
      move = @ai.find_best_move(board, 'X', 'O')
      acceptable_moves.should include(move)
    end

    it 'played move' do 
      board.spaces = [nil] * 9
      board.spaces[1] = 'X'
      board.spaces[4] = 'X'
      board.spaces[0] = 'O'

      @ai.find_best_move(board, 'X', 'O').should == 7
    end

    # it 'chooses a corner or center as opening move' do 
    #   board.spaces = [nil] * 9
    #   move = @ai.find_best_move(board)

    #   move.should be_even
    # end


  it "gets the best move available from a board with 2 available spaces" do
    board.spaces = ["o","x","o",
                    "o","x","o",
                    nil,nil,"o"]

    @ai.find_best_move(board, 'o', 'x').should == 7
  end

  it "gets the best move available from a board with 3 available spaces" do
    board.spaces = [nil,"o","x",
                    "x","o","x",
                    nil,nil,"o"]

    @ai.find_best_move(board, 'x', 'o').should == 0
  end

  # it "gets the best move available from a board with 3 available spaces" do
  # board.spaces = ["x","o","x",
  #                 "x","o","x",
  #                 "7","8","9"]
  #   subject.move(board,["x","o"]).should == 7
  # end

#   it "gets the best move available from a board with 4 available spaces" do
#   # board.spaces = ["x","x","o",
#                   # "x","o","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 7
#   end

#   it "gets the best move available from a board with 5 available spaces" do
#   # board.spaces = ["x","o","o",
#                   # "x","5","6",
#                   # "o","8","9"]
#     subject.move(board,["x","o"]).should == 5
#   end

#   it "gets the best move available from a board with 6 available spaces" do
#   # board.spaces = ["x","o","3",
#                   # "x","5","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 7
#   end

#   it "gets the best move available from a board with 5 available spaces" do
#   # board.spaces = ["x","o","3",
#                   # "o","x","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 9
#   end

#   it "gets the best move available from a board with 6 available spaces" do
#   # board.spaces = ["x","o","3",
#                   # "4","o","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 8
#   end

#   it "gets the best move available from a board with 6 available spaces" do
#   # board.spaces = ["x","o","3",
#                   # "4","x","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 9
#   end

  it "gets the best move available from a board with 8 available spaces" do
    board.spaces = ["o",nil,nil,
                    nil,nil,nil,
                    nil,nil,nil]

    @ai.find_best_move(board, 'o', 'x').should == 4
  end

#   it "gets the best move available from a board with 9 available spaces" do
#   # board.spaces = ["1","2","3",
#                   # "4","5","6",
#                   # "7","8","9"]

#     subject.move(board,["x","o"]).should == 1
#   end

# end

  end
end