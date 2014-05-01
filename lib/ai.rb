require 'game_rules'
require 'board'
require 'pry'

class AI
  attr_accessor  :current_player, :game_piece, :possible_moves, :opponent_piece
  def initialize(game_rules, game_piece, opponent_piece)
    @game_rules = game_rules
    @possible_moves = {}
    @game_piece = game_piece
    @opponent_piece = opponent_piece
  end

  WIN, TIE, LOSS, IN_PROGRESS_SCORE = 500, 0, -500, 100

  def find_best_move(board)
    current_player = @game_piece
    depth = 1
    board.open_spaces.each do |move|
      cloned_board = board.clone
      make_move(cloned_board, move, current_player)
      score = rank(cloned_board.spaces, depth)
      track_best(move, score) if @game_rules.game_over?(board.spaces)
      score = score_available_moves(board, depth + 1, next_player(current_player), move, score)
      track_best(move, score) 
      board = reset(board, move)
    end
    best_move
  end

  def score_available_moves(board, depth, current_player, move, score)
    return score if @game_rules.game_over?(board.spaces)
    board.open_spaces.each do |move|
      cloned_board = board.clone
      make_move(cloned_board, move, current_player)
      score = rank(cloned_board.spaces, depth) if @game_rules.game_over?(board.spaces)
      new_score = score_available_moves(cloned_board, depth + 1, next_player(current_player), move, score)
      if new_score > score
        score = new_score
      end
      board = reset(board, move)
    end
    return score
  end

  def track_best(move, score)
    if @possible_moves.count > 0
      add_new_possible(move, score)
    else
      @possible_moves[move] = score
    end
  end

  def best_move
    @possible_moves.each { |k, v| @possible_moves[k] = v.abs }
    best_score = @possible_moves.values.max
    @possible_moves.key(best_score)
  end

  def add_new_possible(move, score)
    if @possible_moves[move] == nil || @possible_moves[move] < score.abs
      @possible_moves[move] = score
    end
    @possible_moves
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

  def rank(board, depth)
    if @game_rules.game_over?(board)
      return TIE - depth if @game_rules.tie?(board)
      return WIN - depth if @game_rules.winner(board) == @game_piece
      return LOSS + depth if @game_rules.winner(board) == @opponent_piece
    else
      return IN_PROGRESS_SCORE
    end
  end
end