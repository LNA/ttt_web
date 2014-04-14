require 'ai'
require 'game_rules'

describe AI do 
  let (:game_rules) {GameRules.new}

  before :each do
    @ai = AI.new(game_rules, 'X', 'O')
  end

  context '#next_open_space' do 
    it 'finds the next open space' do 
      test_board = ['X', 'O', 'X',
                    'O', 'X', nil,
                    'O', 'X', nil]
      @ai.next_open_space(test_board).should == 5 
    end
  end

  context '#next_player' do 
    it 'returns the next player' do 
      @ai.current_player = @max_player

      @ai.next_player.should == 'X'
    end
  end

  context '#rank' do 
    it 'returns 0 for a tie' do
      spaces = ['X', 'X', 'O', 
                'X', 'O', 'E', 
                'E', 'X', 'X']
      @ai.rank(spaces).should == 0
    end

    it 'returns -1 for a min player win' do 
      spaces = ['X']*9

      @ai.rank(spaces).should == -1
    end

    it 'returns 1 for a max player win' do 
      spaces = ['O']*9

      @ai.rank(spaces).should == 1
    end
  end

  context 'rank of 1' do
    it 'finds the winning rank on the first branch' do
      spaces = [nil, 'O', 'X',
                'O', 'X', nil,
                'O', 'X', nil]

      open_spaces = [0, 5, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 1
    end

    it 'finds the winning rank on the second branch' do
      spaces = [nil, 'O', 'X',
                'O', 'X', nil,
                'O', 'X', nil]
      open_spaces = [0, 5, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.min_player).should == 1
    end

    it 'finds the winning rank on the fifth branch' do 
      spaces = ['O', 'X', nil,
                'X', 'X', 'O',
                nil, nil , nil]
      open_spaces = [2, 6, 7, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 1
    end

    it 'finds the winning rank on the ninth branch' do 
      spaces = [nil]*9
                
      open_spaces = [0, 1, 2, 3, 4, 5, 6, 7, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 1
    end
  end

  context 'rank of 0' do
    it "returns the 0 for a tie" do
      spaces = ['X', 'O', 'X',
                'O', 'X', 'O',
                'O', 'X', nil]
      open_spaces = [8]

      @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 0
    end
  end
end