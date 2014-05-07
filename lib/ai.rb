require 'game_rules'

class AI
  attr_accessor  :current_player
  def initialize(game_rules)
    @game_rules = game_rules
  end

  WIN, TIE, LOSS, IN_PROGRESS_SCORE = 500, 0, -500, 100

  def find_best_move(board, opponent_piece, game_piece)
    possible_moves = {}
    current_player = game_piece
    depth = 1
    board.open_spaces.each do |move|
      cloned_board = board.clone
      make_move(cloned_board, move, current_player)
      score = rank(cloned_board.spaces, depth, opponent_piece, game_piece)
      track_best(move, score, possible_moves)
      new_score = score_available_moves(board, depth + 1, next_player(current_player, opponent_piece, game_piece), score, opponent_piece, game_piece)
      if new_score > score
        score = new_score
      end
      board = reset(board, move)
    end
    best_move(possible_moves)
  end

private
  def score_available_moves(board, depth, current_player, score, opponent_piece, game_piece)
    return score if @game_rules.game_over?(board.spaces)
    board.open_spaces.each do |move|
      make_move(board, move, current_player)
      if current_player == opponent_piece
        score = score_available_moves(board, depth + 1, next_player(current_player, opponent_piece, game_piece), score, opponent_piece, game_piece) * -1
      else
        score = score_available_moves(board, depth + 1, next_player(current_player, opponent_piece, game_piece), score, opponent_piece, game_piece)
      end
      board = reset(board, move)
    end
    return score
  end

  def track_best(move, score, possible_moves)
    possible_moves[move] = score
  end

  def best_move(possible_moves)
    best_score = possible_moves.values.max
    possible_moves.key(best_score)
  end

  def next_player(current_player, opponent_piece, game_piece)
    current_player == opponent_piece ? game_piece : opponent_piece
  end

  def reset(board, move)
    board.spaces[move] = nil
    board
  end

  def make_move(board, move, current_player)
    board.spaces[move] = current_player
    board
  end

  def rank(board, depth, opponent_piece, game_piece)
    if @game_rules.game_over?(board)
      return TIE - depth if @game_rules.tie?(board)
      return WIN - depth if @game_rules.winner(board) == game_piece
      return LOSS - depth if @game_rules.winner(board) == opponent_piece
    else
      return IN_PROGRESS_SCORE
    end
  end
end