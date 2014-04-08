require 'game_rules'
require 'board'

class AI
  attr_accessor :game_piece, :game_over, :space
  def initialize(game_rules, board, max_player)
    @game_rules = game_rules 
    @board = board
    @max_player = max_player
  end

  def find_best_move(spaces, depth=0)
    @open_spaces = []
    spaces.each_with_index do |player, space|
      if player == nil 
        @open_spaces << space
        next_board = spaces.dup
        next_board[space] = @game_piece
        return_space_to_be_played(next_board, space, spaces)
      end 
    end 
    @space
  end
  
private

  def return_space_to_be_played(next_board, space, spaces)
    if @game_rules.game_over?(next_board)
      if rank(next_board, @max_player) == 1
        @space = space
      end
    else
      block_max_player_win(spaces, @max_player)
    end
  end

  def block_max_player_win(spaces, max_player)
    @open_spaces.each do |space|
      current_spaces = spaces.dup
      current_spaces[space] = @max_player
      if final_state_rank(current_spaces, @max_player) == -1
        @space = space
      end
    end
  end

  def rank(spaces, max_player)
    @rank ||= final_state_rank(spaces, @max_player) 
  end

  def final_state_rank(spaces, max_player)
    if @game_rules.game_over?(spaces).class == String
      return 0 if @game_rules.tie?(spaces)
      return 1  if @game_rules.winner?(spaces) == @game_piece
      return  -1 if @game_rules.winner?(spaces) == @max_player
    end
  end
end