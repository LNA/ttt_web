class MockGameState
  attr_accessor :board, 
                :checked_final_state,
        				:checked_move,
        				:final_state,
                :found_game_state,                
                :played_move,
                :possible_game_states


  def valid(move)
  	@checked_move = true
  end

  def game_state_for(move)
  	@found_game_state = true
  end

  def game_over
  	@checked_final_state = true
  end

  def ai_play_best_move
    @played_move = true
    MockGameState.new
  end
end