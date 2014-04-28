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
    depth = 1
    best_score = TIE
    @possible_moves = {}

    board.open_spaces.each do |move|
      make_move(board, move, @max_player)
      score = rank(board.spaces) - depth  
      if score == 99
        return move
      else
        score_available_moves(board, depth, next_player(current_player), move)
        board = reset(board, move)
      end
    end
    best_score = @possible_moves.values.max
    best_move = @possible_moves.key(best_score)
  end

  def score_available_moves(board, depth, current_player, move)
    if @game_rules.game_over?(board.spaces) 
       score = (rank(board.spaces)).abs - depth if @game_rules.winner(board.spaces) == 'X'
       score = rank(board.spaces) - depth if @game_rules.winner(board.spaces) == 'O'
       score = rank(board.spaces) if @game_rules.winner(board.spaces) == false
       @possible_moves[move] = score
    else
      depth += 1
      board.open_spaces.each do |move|
        cloned_board = board.clone
        make_move(cloned_board, move, current_player)
        puts "depth = #{depth}"
        puts "move = #{move}"
        puts "player = #{current_player}"
        puts "#{board.spaces}"
        puts "#{rank(board.spaces)}"
        puts "#" * 50
        score_available_moves(cloned_board, depth, next_player(current_player), move)
        board = reset(cloned_board, move)
      end
    end
  end

  def next_player(current_player)
    if current_player == 'X'
      'O'
    else
      'X'
    end
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