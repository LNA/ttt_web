require 'ai'
require 'board'
require 'game_rules'

describe AI do
  let (:game_rules) {GameRules.new}
  let (:board)      {Board.new}

  before :each do
    @ai = AI.new(game_rules)
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
      board.spaces = [nil, 'O', 'X',
                      nil, 'X', nil,
                      'O', 'X', nil]

      @ai.find_best_move(board).should == 5
    end

    it 'finds the best move at depth 4' do
      board.spaces = ['O', 'X', nil,
                      'X', 'X', 'O',
                      nil, nil , nil]

      @ai.find_best_move(board).should == 7
    end

    it 'finds the best move at depth 5' do 
      board.spaces = ['X', 'X', nil,
                      nil, nil, nil,
                      'O', nil, nil]

      @ai.find_best_move(board).should == 2
    end

    it 'chooses a win over a block' do
      board.spaces = ['O', 'X', 'O',
                      'X', 'X', 'O',
                      nil, nil , nil]

      @ai.find_best_move(board).should == 8
    end
  end

  context 'tie' do
    it 'returns the move for a tie at depth 1' do
      board.spaces = ['X', 'O', 'X',
                      'O', 'X', 'O',
                      'O', 'X', nil]

      @ai.find_best_move(board).should == 8
    end

    it 'return the move for a tie at depth 3' do
      board.spaces = ['X', nil, 'O',
                      nil, 'X', 'X',
                      'X', nil, 'O']

      @ai.find_best_move(board).should == 3
    end
  end

  context 'minimax score for possible moves' do
    it "returns the move if only one move left" do
      board.spaces = [nil, 'O', 'X',
                      'O', 'X', 'X',
                      'O', 'X', 'O']

      @ai.find_best_move(board).should == 0
    end 

    it 'scores a loss when there are only two moves left correctly' do
      board.spaces = [nil, 'O', 'X',
                      nil, 'X', 'X',
                      'O', 'X', 'O']
      @ai.find_best_move(board)

      @ai.possible_moves.should == {0=>0, 3=>100}
    end 

    it 'scores a tie in two moves correctly' do
      board.spaces = ['X', 'O', 'O',
                      'O', 'X', 'X',
                      nil, nil, 'O']
      depth = 0
      @ai.find_best_move(board)
      @ai.possible_moves.should == {7=>0, 6=>0}
    end 
  end

  context 'chess moves' do
    it 'blocks the two corner set up' do
      board.spaces = ['X', nil, nil,
                      nil, 'O', nil,
                      nil, nil, 'X']

      @ai.find_best_move(board).should == 6
    end

    it 'blocks the top left edge set up' do
      board.spaces = [nil, 'X', nil,
                      'X', 'O', nil,
                      nil, nil, nil]

      @ai.find_best_move(board).should == 0
    end

    it 'blocks the top right edge set up' do
      board.spaces = [nil, 'X', nil,
                      nil, 'O', 'X',
                      nil, nil, nil]

      @ai.find_best_move(board).should == 2
    end

    it 'blocks the bottom left edge set up' do
      board.spaces = [nil, nil, nil,
                      'X', 'O', nil,
                      nil, 'X', nil]

      @ai.find_best_move(board).should == 6
    end

    it 'blocks the bottom right edge set up' do
      board.spaces = [nil, nil, nil,
                      nil, 'O', 'X',
                      nil, 'X', nil]

      @ai.find_best_move(board).should == 8
    end

    it 'blocks an L set up' do 
      board.spaces = ['X', nil, nil,
                      nil, 'O', nil,
                      nil, 'X', nil]

      @ai.find_best_move(board).should == 3
    end
  end

  context 'fails in play' do 
    it 'works' do
      board.spaces = [nil, nil, nil,
                      nil, 'X', 'X',
                      'O', nil, nil]

      @ai.find_best_move(board).should == 3
    end
  end
end