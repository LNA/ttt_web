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

  WIN = 100
  TIE = 0
  LOSS = -100 

   def find_best_move(board)
    depth = 0
    best_score = 5
    @possible_moves = {}


    board.open_spaces.each do |move|
      make_move(board, move, @max_player)
      score = rank(board.spaces) - depth
      reset(board, move)
      @possible_moves[score] = move

      minimax(board, depth, @max_player)
      @possible_moves[score] = move
    end
    return_best_move_by_rank
  end

  def minimax(board, depth, current_player)
    depth += 1
    board.open_spaces.each do |move|
      board = make_move(board, move, @max_player)
      score = rank(board.spaces) - depth
      if score < -101
        score = score.abs
      end

      @possible_moves[score] = move
      minimax(board, depth, @min_player) 
      reset(board, move)
    end
  end

  def reset(board, space)
    board.spaces[space] = nil
    board
  end

  def next_move_for(depth, move, board)
    board.spaces[depth]
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

  def return_best_move_by_rank
    if @possible_moves.keys.include?(99)
      best_move = @possible_moves[99]
    else
      best_score = @possible_moves.keys.max
      best_move = @possible_moves[best_score]
    end
    best_move
  end
end