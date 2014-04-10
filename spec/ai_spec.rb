require 'ai'
require 'game_rules'

describe AI do 
  let (:board)      {Board.new}
  let (:game_rules) {GameRules.new}

  before :each do
    @ai = AI.new(game_rules, board, 'X', 'O')
  end

  context '#open_spaces' do 
    it 'returns the open spaces for a board' do 
      spaces = [nil, "X", "O", 
                "O", nil, nil, 
                nil, "X", nil]
      @ai.open_spaces(spaces).should == [0, 4, 5, 6, 8]
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

  context 'finds the winning move on the first branch' do
    it 'returns 1 as the rank for the next winning move' do
      spaces = [nil, 'O', 'X',
                'O', 'X', nil,
                'O', 'X', nil]

      open_spaces = [0, 5, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 1
    end
  end

  context 'finds the winning move on the second branch' do
    it 'returns 1 as the rank if ai goes first' do 
      spaces = [nil, 'O', 'X',
                'O', 'X', nil,
                'O', 'X', nil]
      open_spaces = [0, 5, 8]

      @ai.find_best_rank(open_spaces, spaces, @ai.min_player).should == 1
    end
  end

  # context 'finds the winning move on the fifth branch' do 
  #   it 'returns 1 as the rank for a move' do 
  #     spaces = []
  #     open_spaces = []

  #     @ai.find_best_rank(open_spaces, spaces, @ai.max_player).should == 1
  #   end
  # end
end