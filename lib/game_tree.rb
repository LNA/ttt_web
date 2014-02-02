class GameTree
  attr_accessor :board, 
                :current_player, 
                :possible_game_states

  def generate_all_possible_moves
    game_state = GameState.new('X', Array.new(9))
    
    build_branches_for(game_state)

    game_state
  end
  
  def build_branches_for(current_game_state) 
    next_player = (current_game_state.current_player == 'X' ? 'O' : 'X') 
    current_game_state.board.each_with_index do |player, position| 
      if player != "X" && player != "O"
        next_board = current_game_state.board.dup  
        next_board[position] = current_game_state.current_player 

        game_child = GameState.new(next_player, next_board)
        current_game_state.possible_game_states << game_child
        build_branches_for(game_child)
      end
    end
  end
end