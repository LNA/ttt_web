class GameTree
  attr_accessor :board, 
                :current_player, 
                :possible_game_states

  def generate_all_possible_moves
    game_state = GameState.new('X', Array.new(9))
    
    build_branches_for(game_state, -100, 100)

    game_state
  end
  
  def build_branches_for(current_game_state, alpha, beta) 
    next_player = (current_game_state.current_player == 'X' ? 'O' : 'X') 
    current_game_state.board.each_with_index do |player, position| 
      if player != "X" && player != "O"
        next_board = current_game_state.board.dup  
        next_board[position] = current_game_state.current_player 

        game_child = GameState.new(next_player, next_board)
        current_game_state.possible_game_states << game_child

        

        set_alpha_beta(current_game_state, alpha, beta) if current_game_state.game_over?
        prune_branches_if_alpha_is_greater_than_beta(game_child, alpha, beta)
      end
    end
  end

  def set_alpha_beta(current_game_state, alpha, beta)
    current_game_state_rank = current_game_state.rank

    if current_game_state.current_player == "O" && alpha < current_game_state_rank
      alpha = current_game_state_rank
    else current_game_state.current_player == "X" && beta > current_game_state_rank
      beta = current_game_state_rank
    end
  end

  def set_alpha(current_game_state, alpha, beta)
    current_game_state_rank = current_game_state.rank

    if current_game_state.current_player == "O" && alpha < current_game_state_rank
      alpha = current_game_state_rank
    end
  end

  def set_beta(current_game_state, alpha, beta)
    current_game_state_rank = current_game_state.rank

    if current_game_state.current_player == "X" && beta > current_game_state_rank
      beta = current_game_state_rank
    end
  end

  def ai_first_move(current_game_state)
    if current_game_state.board.include?("O")
      false
    else
      true
    end
  end

  def force_ai_first_move(current_game_state)
    if current_game_state.board[4] == nil
      current_game_state.board[4] = 'O'
    else
      current_game_state.board[0] = 'O'
    end
    current_game_state
  end

  def prune_branches_if_alpha_is_greater_than_beta(current_game_state, alpha, beta)
    if alpha >= beta
      return
    elsif ai_first_move(current_game_state) == true
      current_game_state.possible_game_states << force_ai_first_move(current_game_state)
      return
    else
      build_branches_for(current_game_state, alpha, beta)
    end
  end
end