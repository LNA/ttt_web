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
      if score == 100
        return move 
      else
        best_move = minimax(board, depth, @max_player, move) 
        board = reset(board, move)
      end
    end
    best_score = @possible_moves.values.max
    best_move = @possible_moves.key(best_score)
  end

  def minimax(board, depth, current_player, move)
    score = (rank(board.spaces) - depth).abs
    if @game_rules.game_over(board.spaces) != false
      @possible_moves[move] = score
      return move
    else
      depth += 1
      board.open_spaces.each do |move|
        current_player = next_player(current_player)
        board = make_move(board, move, current_player)
        score = - minimax(board, depth, current_player, move)
        board = reset(board, move)
      end
    end
    best_score = @possible_moves.values.max
    best_move = @possible_moves.key(best_score)
  end

  def next_player(current_player)
    if current_player == 'X'
      current_player = 'O'
    else
      current_player = 'X'
    end
    current_player
  end

  def reset(board, move)
    board.spaces[move] = nil
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
end