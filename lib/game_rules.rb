class GameRules
  attr_accessor :current_player
  def valid?(move, board)
    board.spaces[move.to_i] == nil && move.to_i < 9
  end

  def full?(board)
    board.count(nil) == 0
  end

  def winner(board)
    win_sets.each do |set|
      set = set.first
      check(board, set)
    end
    false
  end

  def check(board, set)
    if board[set].uniq.count == 1 
      return set[0] if board[set][0] != nil
    end
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
end