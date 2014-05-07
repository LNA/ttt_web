class UI

  WELCOME      = "Welcome to ttt!"
  ENTER_MOVE   = "Enter your move:"
  INVALID_MOVE = "Sorry invalid move! Try again:"
  GAME_OVER    = "Game Over!"
  TIE          = "Its a tie!"

  def welcome_user
    puts WELCOME
  end
    
  def gets_type_for(player_number)
    puts "Select Player #{player_number} type.  H for human, A for ai."
    type = gets.chomp
    type.upcase
  end

  def gets_game_piece_for(player_number)
    puts "Player #{player_number}: Please select a letter to be your game peice"
    piece = gets.chomp
    piece.upcase
  end

  def display_grid(board)
    output = []
    0.upto(8) do |position|
      output << " #{board[position] || position} "
    end
    puts output.each_slice(3){|row| puts row.join}
  end

  def ask_player_for_move
    puts ENTER_MOVE
  end

  def invalid_move_message
    puts INVALID_MOVE
  end

  def gets_move
    gets.chomp
  end

  def winner_message(winner)
    puts "#{winner} has won!"
  end

  def tie_message
    puts TIE
  end

  def game_over
    puts GAME_OVER
  end
end