require 'ai'
require 'board'
require 'game_rules'

describe AI do 
  let (:game_rules) {GameRules.new}
  let (:board)      {Board.new}

  before :each do
    @ai = AI.new(game_rules, 'X', 'O')
  end

  context 'score' do 
    it 'returns 0 for a tie' do
      board.spaces = ['X', 'X', 'O', 
                      'X', 'O', 'E', 
                      'E', 'X', 'X']
      @ai.rank(board.spaces).should == 0
    end

    it 'returns -100 for a min player win' do 
      board.spaces = ['X']*9

      @ai.rank(board.spaces).should == -100
    end

    it 'returns 100 for a max player win' do 
      board.spaces = ['O']*9

      @ai.rank(board.spaces).should == 100
    end
  end

  context 'winning move' do
    it 'finds the move at depth 1' do
      board.spaces = [nil, 'O', 'X',
                      'O', 'X', nil,
                      'O', 'X', nil]

      @ai.find_best_move(board).should == 0
    end

    it 'finds best move at depth 2' do
      board = [nil, 'O', 'X',
               nil, 'X', nil,
               'O', 'X', nil]
      open_spaces = [0, 3, 5, 8]

      @ai.find_best_move(open_spaces, board).should == 0
    end

    it 'finds the best move at depth 4' do 
      board = ['O', 'X', nil,
               'X', 'X', 'O',
               nil, nil , nil]
      open_spaces = [2, 6, 7, 8]

      @ai.find_best_move(open_spaces, board).should == 2
    end

    it 'chooses a win over a block' do 
      board = ['O', 'X', 'O',
               'X', 'X', 'O',
               nil, nil , nil]
      open_spaces = [6, 7, 8]

      @ai.find_best_move(open_spaces, board).should == 8
    end
  end

  context 'tie' do
    it "returns the move for a tie at depth 1" do
      board = ['X', 'O', 'X',
               'O', 'X', 'O',
               'O', 'X', nil]
      open_spaces = [8]

      @ai.find_best_move(open_spaces, board).should == 8
    end

    it "return the move for a tie at depth 2" do 
      board = ['X', nil, 'X',
               'O', 'X', 'O',
               'O', nil, 'X']
      open_spaces = [1, 7]

      @ai.find_best_move(open_spaces, board).should == 1
    end
  end

  context 'minimax' do
    it "returns 100 for a win at depth 0" do
      board = [nil, 'O', 'X',
               'O', 'X', nil,
               'O', 'X', nil]

      open_spaces = [0, 5, 8]
      current_player = "O"
      depth = 0

      @ai.minimax(board, depth, open_spaces, current_player, 0).should == 100
    end

    it "returns 99 for a depth of 1" do 
      board = ['O', nil, nil,
               nil, nil, nil,
               nil, 'X', 'X']
      open_spaces = [1, 2, 3, 4, 5, 6]
      depth = 0
      current_player = "O"

      @ai.minimax(board, depth, open_spaces, current_player, 0).should == 99
    end
  end
end