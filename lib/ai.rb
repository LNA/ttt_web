require 'game_rules'
require 'board'

class AI
  attr_accessor  :current_player, :possible_moves   
  def initialize(game_rules)
    @game_rules = game_rules
  end

 WIN, TIE, LOSS = 100, 0, -100
 
   def find_best_move(board)
    best_score, @possible_moves = TIE, {}
    current_player = 'X'
  
    board.open_spaces.each do |move|
      depth = 1
      make_move(board, move, next_player(current_player))
      score = rank(board.spaces) - depth 
      track_possible_moves(board, depth, move)
      return move if score == 99 
      score_available_moves(board, depth, next_player(current_player), move)
      board = reset(board, move)
    end
    best_score = @possible_moves.values.max
    best_move = @possible_moves.key(best_score)
  end

  def score_available_moves(board, depth, current_player, move)
    if @game_rules.game_over?(board.spaces) 
       track_possible_moves(board, depth, move)
    else
      depth += 1
      board.open_spaces.each do |move|
        cloned_board = board.clone
        make_move(cloned_board, move, current_player)
        score_available_moves(cloned_board, depth, next_player(current_player), move)
        board = reset(cloned_board, move)
      end
    end
  end

  def track_possible_moves(board, depth, move)
    score = (rank(board.spaces)).abs - depth if @game_rules.winner(board.spaces) == 'X'
    score = rank(board.spaces) - depth if @game_rules.winner(board.spaces) == 'O'
    score = rank(board.spaces) if @game_rules.winner(board.spaces) == false 
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