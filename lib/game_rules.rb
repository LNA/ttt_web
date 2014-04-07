class GameRules
  def valid(move, spaces)
    if (spaces[move.to_i].is_a? String) || move > 8
      false
    else
      true
    end
  end

  def full_board?(spaces)
    if (spaces.include? nil ) == true
      false
    else
      true
    end
  end

  def winner?(spaces)
    [first_row(spaces), 
     second_row(spaces), 
     third_row(spaces),
     left_column(spaces), 
     middle_column(spaces),    
     right_column(spaces),
     left_diag_winner(spaces),
     right_diag_winner(spaces)
    ].each do |line|
      if line.uniq.count == 1
        return line[0]
      end
    end
    false
  end

  def tie?(spaces)
    full_board?(spaces) == true && winner?(spaces) == false
  end

  def game_over?(spaces)
    winner?(spaces) || tie?(spaces)
  end

private

  def first_row(spaces)
    spaces[0..2]
  end

  def second_row(spaces)
    spaces[3..5]
  end

  def third_row(spaces)
    spaces[6..8]
  end

  def left_column(spaces)
    [spaces[0], spaces[3], spaces[6]]
  end

  def middle_column(spaces)
    [spaces[1], spaces[4], spaces[7]]
  end

  def right_column(spaces)
    [spaces[2], spaces[5], spaces[8]]
  end

  def left_diag_winner(spaces)
    [spaces[0], spaces[4], spaces[8]]
  end
  
  def right_diag_winner(spaces)
    [spaces[2], spaces[4], spaces[6]]
  end
end