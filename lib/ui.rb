class UI

  WELCOME_MESSAGE = "Welcome to ttt!"
  INVALID_MOVE_MESSAGE = "Sorry invalid move! Try again:"
  GAME_OVER_MESSAGE = "Game Over!"

  def welcome_user
    puts WELCOME_MESSAGE
  end

  def gets_player_type(player_number)
    puts "Select Player #{player_number} type.  H for human, A for ai."
    type = gets.chomp
    type.upcase
  end

  def gets_player_game_piece
    puts "Please select a letter to be your game peice"
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
    puts "Enter your move:"
  end

  def invalid_move_message
    puts INVALID_MOVE_MESSAGE
  end

  def gets_move
    gets.chomp
  end

  def winner_message(winner)
    puts "#{winner} has won!"
  end

  def tie_message
    puts "Its a tie!"
  end

  def game_over
    puts GAME_OVER_MESSAGE
  end
end