require 'ai'
require 'game_rules'

describe AI do 
  let (:game_rules) {GameRules.new}

  before :each do
    @ai = AI.new(game_rules, 'X', 'O')
  end

  context 'score' do 
    it 'returns 0 for a tie' do
      spaces = ['X', 'X', 'O', 
                'X', 'O', 'E', 
                'E', 'X', 'X']
      @ai.rank(spaces).should == 0
    end

    it 'returns -100 for a min player win' do 
      spaces = ['X']*9

      @ai.rank(spaces).should == -100
    end

    it 'returns 100 for a max player win' do 
      spaces = ['O']*9

      @ai.rank(spaces).should == 100
    end
  end

  context 'winning move' do
    it 'finds the move at depth 1' do
      spaces = [nil, 'O', 'X',
                'O', 'X', nil,
                'O', 'X', nil]

      open_spaces = [0, 5, 8]

      @ai.find_best_move(open_spaces, spaces).should == 0
    end

    it 'finds best move at depth 2' do
      spaces = [nil, 'O', 'X',
                nil, 'X', nil,
                'O', 'X', nil]
      open_spaces = [0, 3, 5, 8]

      @ai.find_best_move(open_spaces, spaces).should == 0
    end

    it 'finds the best move at depth 4' do 
      spaces = ['O', 'X', nil,
                'X', 'X', 'O',
                nil, nil , nil]
      open_spaces = [2, 6, 7, 8]

      @ai.find_best_move(open_spaces, spaces).should == 2
    end

    it 'chooses a win over a block' do 
      spaces = ['O', 'X', 'O',
                'X', 'X', 'O',
                nil, nil , nil]
      open_spaces = [6, 7, 8]

      @ai.find_best_move(open_spaces, spaces).should == 8
    end
  end

  context 'tie' do
    it "returns the move for a tie at depth 1" do
      spaces = ['X', 'O', 'X',
                'O', 'X', 'O',
                'O', 'X', nil]
      open_spaces = [8]

      @ai.find_best_move(open_spaces, spaces).should == 8
    end

    it "return the move for a tie at depth 2" do 
      spaces = ['X', nil, 'X',
                'O', 'X', 'O',
                'O', nil, 'X']
      open_spaces = [1, 7]

      @ai.find_best_move(open_spaces, spaces).should == 1
    end
  end
end