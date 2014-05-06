class GameRules
  attr_accessor :current_player
  def valid?(move, board)
    board.spaces[move.to_i] == nil && move.to_i < 9
  end

  def full?(board)
    board.count(nil) == 0
  end

  def winner(board)
    win_sets.each do |line|
      line = line.first
      if board[line].uniq.count == 1 
        if board[line][0] != nil
          return line[0]
        end
      end
    end
    false
  end

  def tie?(board)
    full?(board) == true && winner(board) == false
  end

  def game_over?(board)
    full?(board) || winner(board)
  end

  def win_sets
    [[0..2], [3..5], [6..8], [0..6], [1..7], [2..8], [0..8], [2..6]]
  end

  def winner?(board)
    wining_game_piece = []
    win_sets.each do |set|
      set = set.first
      if board[set].uniq.count == 1 && board[set][0] != nil
        wining_game_piece << board[set][0]
      end
      wining_game_piece
    end
    wining_game_piece.first
  end

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