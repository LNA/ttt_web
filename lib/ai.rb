require 'game_rules'
require 'board'

class AI
  attr_accessor :board, :current_player, :game_piece,
                :game_over, :max_player, :min_player, :open_spaces, :possible_moves, 
                :rank, :space

  def initialize(game_rules, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
  end

  WIN, TIE, LOSS = 100, 0, -100
 
   def find_best_move(board)
    depth, best_score, @possible_moves = 1, TIE, {}
    return 0 if opponent_played_top_left_coner_set_up_on(board)
    return 8 if opponent_played_bottom_right_coner_set_up_on(board)
    board.open_spaces.each do |move|
      make_move(board, move, @max_player)
      score = rank(board.spaces) - depth  
      return move if score == 99
      return_best_move_for(board, depth, current_player, move, score)
    end
    best_move = @possible_moves.key(@possible_moves.values.max)
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
    score = (rank(board.spaces)).abs - depth unless @game_rules.winner(board.spaces) == false
    score = rank(board.spaces) if @game_rules.winner(board.spaces) == false
    @possible_moves[move] = score
  end

  def opponent_played_top_left_coner_set_up_on(board)
    board.open_spaces.count == 6 && @game_rules.top_left_corner_set_up(board.spaces)
  end

  def opponent_played_bottom_right_coner_set_up_on(board)
    board.open_spaces.count == 6 && @game_rules.bottom_right_corner_set_up(board.spaces)
  end

  def return_best_move_for(board, depth, current_player, move, score)
    score_available_moves(board, depth, next_player(current_player), move)
    board = reset(board, move)
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
    elsif @game_rules.winner(board) == @max_player
      return WIN
    else
      return LOSS
    end
  end
end