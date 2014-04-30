require 'game_rules'
require 'board'

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
    board.open_spaces.each do |move|
      depth = 1                                     
      cloned_board = board.clone                  
      make_move(cloned_board, move, current_player) 
      score = rank(cloned_board.spaces, depth)             
      @possible_moves[move] = score 
      reset(board, move)
    end
    best_move 
   end

   def best_move
    @possible_moves.each { |k, v| @possible_moves[k] = v.abs }
    best_score = @possible_moves.values.max
    @possible_moves.key(best_score)
   end

  # def score_available_moves(board, depth, current_player, move)
  #   #Note: a -97 is better than a 94.
  #   # add score to @possible_moves if game is over and score is highest for that move
  #   board.open_spaces.each do |move|
  #     depth = 1                                     # set depth to one
  #     cloned_board = board.clone                    # clone board
  #     make_move(cloned_board, move, current_player) # make move on cloned board
  #     score = rank(cloned_board.spaces, depth)
  #     @possible_moves[move] = score
  #     score_available_moves(cloned_board, depth, next_player(current_player), move) # call minimax on cloned board
  #     reset(cloned_board, move)                     # reset board 
  #   end
  # end

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
      return TIE if @game_rules.tie?(board)
      return WIN - depth if @game_rules.winner(board) == @game_piece
      return LOSS + depth if @game_rules.winner(board) == @opponent_piece
    else
      return IN_PROGRESS_SCORE
    end
  end
end