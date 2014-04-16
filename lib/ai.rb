require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :game_piece,
                :game_over, :max_player, :min_player, :open_spaces,  
                :rank, :space

  def initialize(game_rules, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
  end

  WIN = 100
  TIE = 0
  LOSS = -100 # will need to take absolute value of

  def find_best_move(open_spaces, board)
    depth = 0
    best_score = 5

    board.each_with_index do |player, space|
      if player == nil
        make_move(board, space, @max_player)
        score = minimax(board, depth, open_spaces, @max_player, best_score)
        reset(board, space)
        if score > best_score
          best_score = score 
          best_move = space 
          return best_move
        end
      end
    end
  end

  #private

  def minimax(board, depth, open_spaces, current_player, best_score)
    depth += 1
    open_spaces.each do |move|
      make_move(board, move, current_player)
      score = rank(board)
      if score > best_score
        best_score = score - depth
      end    
      if score == TIE
        list(move, score) 
      end       
      reset(board, move)
      unless next_move_for(depth, open_spaces) == nil
        move = next_move_for(depth, open_spaces)
        make_move(board, move, @max_player)
        score = minimax(board, depth, open_spaces, @min_player, best_score)
      end
    end
    best_score
  end

  def list(move, score)
    possible_moves = Hash.new
    possible_moves[move] = score
  end

  def reset(board, space)
    board[space] = nil
    board
  end

  def next_move_for(depth, open_spaces)
    open_spaces[depth]
  end

  def make_move(board, move, current_player)
    board[move] = current_player
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