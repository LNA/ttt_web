class GameRules
  def valid(move, board)
    if (board[move.to_i].is_a? String) || move > 8
      false
    else
      true
    end
  end

  def full?(board)
    if (board.include? nil )
      false
    else
      true
    end
  end

  def winner(board)
    [first_row(board), 
     second_row(board), 
     third_row(board),
     left_column(board), 
     middle_column(board),    
     right_column(board),
     left_diag_winner(board),
     right_diag_winner(board)
    ].each do |line|
      if line.uniq.count == 1
        return line[0]
      end
    end
    false
  end

  def tie?(board)
    full?(board) == true && winner(board) == false
  end

  def game_over(board)
    winner(board) || tie?(board)
  end

private

  def first_row(board)
    board[0..2]
  end

  def second_row(board)
    board[3..5]
  end

  def third_row(board)
    board[6..8]
  end

  def left_column(board)
    [board[0], board[3], board[6]]
  end

  def middle_column(board)
    [board[1], board[4], board[7]]
  end

  def right_column(board)
    [board[2], board[5], board[8]]
  end

  def left_diag_winner(board)
    [board[0], board[4], board[8]]
  end
  
  def right_diag_winner(board)
    [board[2], board[4], board[6]]
  end
end