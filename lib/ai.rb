require 'game_rules'
require 'board'

class AI
  attr_accessor  :current_player, :possible_moves   
  def initialize(game_rules)
    @game_rules = game_rules
  end

  WIN, TIE, LOSS = 100, 0, -100
 
   def find_best_move(board)
  end

  def score_available_moves(board, depth, current_player, move)
  end

  def track_possible_moves(board, depth, move)
    @possible_moves[move] = score #only replace if its another score
  end

  def next_player(current_player)
    current_player == "X" ? "O" : "X"
  end

  def reset(board, move)
    board.spaces[move] = nil
    board
  end

  def make_move(board, move, current_player)
    board.spaces[move] = current_player
    board
  end

  def rank(board)
    if @game_rules.tie?(board)
      return TIE
    elsif @game_rules.winner(board) == "O"
      return WIN
    else
      return LOSS
    end
  end
end