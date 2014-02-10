class GameState
  attr_accessor :board,
                :current_player,
                :possible_game_states    

  def initialize(current_player, board)
    @current_player = current_player
    @board = board
    @possible_game_states = [] 
  end

  def valid(move)
    if @board[move.to_i].is_a? String
      false
    else
      true
    end
  end

  def full_board?
    if (@board.include? nil ) == true
      false
    else
      true
    end
  end

  def game_state_for(move)
    @possible_game_states.find { |game_state| game_state.board[move.to_i] == 'X' }
  end

  def rank
    @rank ||= final_state_rank || intermediate_state_rank
  end

  def intermediate_state_rank
    ranks = @possible_game_states.collect{ |game_state| game_state.rank }
    if current_player == 'O'
      ranks.max
    else
      ranks.min
    end
  end 

  def final_state_rank
    if game_over
      return 0 if tie
      winner == 'O' ? 1 : -1
    end
  end

  def ai_play_best_move
    @possible_game_states.max{ |a, b| a.rank <=> b.rank }
  end

  def winner
    [first_row, 
     second_row, 
     third_row,
     left_column, 
     middle_column,    
     right_column,
     left_diag_winner,
     right_diag_winner
    ].each do |line|
      if line.uniq.count == 1
        return line[0]
      end
    end
    false
  end

  def tie
    full_board? == true && winner == false
  end

  def game_over
    winner || tie
  end

private
  def first_row
    @board[0..2]
  end

  def second_row
    @board[3..5]
  end

  def third_row
    @board[6..8]
  end

  def left_column
    [@board[0], @board[3], @board[6]]
  end

  def middle_column
    [@board[1], @board[4], @board[7]]
  end

  def right_column
    [@board[2], @board[5], @board[8]]
  end

  def left_diag_winner
    [@board[0], @board[4], @board[8]]
  end
  
  def right_diag_winner
    [@board[2], @board[4], @board[6]]
  end
end