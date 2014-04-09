require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :game_piece, 
                :game_over, :space

  def initialize(game_rules, board, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules 
    @board = board
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
  end

  def open_spaces(spaces)
    @open_spaces = []

    spaces.each_with_index do |player, open_space|
      if player == nil 
        @open_spaces << open_space 
      end
    end
    @open_spaces
  end

  def find_best_move(open_spaces, spaces)
    @open_spaces = open_spaces

    @open_spaces.each do |space|
      next_board = spaces.dup
      next_board[space] = @game_piece
      next_player
      @open_spaces.shift
      find_best_move(@open_spaces, next_board)
    end

    @open_spaces.each do |space|
      next_board = spaces.dup
      next_board[space] = @max_player

      if rank(next_board, @max_player) == -1
        return space
      else
        @open_spaces.shift
        find_best_move(@open_spaces, spaces)
      end
    end
  end

  def next_player
    if @current_player == @min_player
      @current_player = @max_player
    else
      @current_player = @min_player
    end
    @current_player
  end

  def rank(spaces)
    return 0  if @game_rules.tie?(spaces)
    return -1 if @game_rules.winner(spaces) == @min_player
    return 1  if @game_rules.winner(spaces) == @max_player
  end
end