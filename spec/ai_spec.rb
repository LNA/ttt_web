require 'ai'
require 'board'
require 'game_rules'

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
      board.spaces = [nil] * 9
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
  end
end