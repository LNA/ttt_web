class GameRules
  def valid(move, spaces)
    if (spaces[move.to_i].is_a? String) || move > 8
      false
    else
      true
    end
  end

  def full_board?
    if (@board.spaces.include? nil ) == true
      false
    else
      true
    end
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

  def tie?
    full_board? == true && winner == false
  end

  def game_over?
    winner || tie?
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