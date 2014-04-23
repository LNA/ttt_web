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
      board.spaces = [nil, 'O', 'X',
                      nil, 'X', nil,
                      'O', 'X', nil]

      @ai.find_best_move(board).should == 3
    end

    it 'finds the best move at depth 4' do 
      board.spaces = ['O', 'X', nil,
                      'X', 'X', 'O',
                      nil, nil , nil]

      @ai.find_best_move(board).should == 7
    end

    it 'chooses a win over a block' do 
      board.spaces = ['O', 'X', 'O',
                      'X', 'X', 'O',
                      nil, nil , nil]

      @ai.find_best_move(board).should == 8
    end
  end

  context 'tie' do
    it "returns the move for a tie at depth 1" do
      board.spaces = ['X', 'O', 'X',
                      'O', 'X', 'O',
                      'O', 'X', nil]

      @ai.find_best_move(board).should == 8
    end

    it "return the move for a tie at depth 2" do 
      board.spaces = ['X', nil, 'O',
                      'O', 'X', 'X',
                      'X', nil, 'O']

      @ai.find_best_move(board).should == 1
    end

    it "return the move for a tie at depth 3" do 
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

    it "scores a loss when there is only two moves left correctly" do
      board.spaces = [nil, 'O', 'X',
                      nil, 'X', 'X',
                      'O', 'X', 'O']
      @ai.find_best_move(board)

      @ai.possible_moves.should == {0=>98, 3=>-100}
    end 

    it "scores a tie in two moves correctly" do
      board.spaces = ['X', 'O', 'O',
                      'O', 'X', 'X',
                      nil, nil, 'O']
      depth = 0
      @ai.find_best_move(board)
      @ai.possible_moves.should == {6=>["two scores"], 7=>["two scores"]}
    end 
  end

  context 'forking' do # look up strategies
    it 'blocks the knight set up' do 
    end
  end
end