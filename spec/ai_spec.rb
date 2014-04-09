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

  context '#final_state_rank' do 
    it 'returns 0 for a tie' do
      spaces = ['X', 'X', 'O', 
                'X', 'O', 'E', 
                'E', 'X', 'X']
      @ai.final_state_rank(spaces).should == 0
    end

    it 'returns -1 for a min player win' do 
      spaces = ['X']*9

      @ai.final_state_rank(spaces).should == -1
    end

    it 'returns 1 for a max player win' do 
      spaces = ['O']*9

      @ai.final_state_rank(spaces).should == 1
    end
  end

  context 'scoring spaces' do
    it "returns the score for space zero of 1 for a max win " do
      spaces = [nil, 'O', 'X'
                'O', 'X', nil,
                'O', 'X', nil]

      open_spaces = [0, 5, 8]

      @ai.find_best_move(open_spaces, spaces).should == [3]
    end
  end
end