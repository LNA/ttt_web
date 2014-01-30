class UI
  attr_accessor :board,
                :game

  def welcome
    puts "Welcome to ttt. You are player X." 
  end

  def display_grid(board)
    output = []
    0.upto(8) do |position| 
      output << " #{board[position] || position} "
    end
    puts output.each_slice(3){|row| puts row.join}
  end 

  def ask_for_move
    puts "Enter your move:"
  end

  def invalid_move_message
    puts "Sorry invalid move! Try again:"
  end

  def gets_move
    gets.chomp
  end

  def winner_message(winner)
    if winner == 'O'
      puts "AI has won!"
    else
      puts "Its a tie!"
    end
  end
  
  def game_over
    puts "Game Over!"
  end
end