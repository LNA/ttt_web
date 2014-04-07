require 'game_rules'
class AI
  attr_accessor :game_piece, :game_over, :space
  def initialize(game_rules)
    @game_rules = game_rules 
  end

  def find_best_move(spaces, depth=0)
    spaces.each_with_index do |player, space|
      if player == nil 
        next_board = spaces.dup
        next_board[space] = @game_piece
        return_space_to_be_played(next_board, space)
      end 
    end 
    @space
  end

  def return_space_to_be_played(next_board, space)
    if @game_rules.game_over?(next_board)
      if rank(next_board) == 1
        @space = space
      end
    end
  end

  def rank(spaces)
    @rank ||= final_state_rank(spaces) || intermediate_state_rank(spaces)
  end

  def intermediate_state_rank(spaces)
    ranks = spaces.collect{ |game_state| game_state.rank }
    if @game.current_player == game_piece
      ranks.max
    else
      ranks.min
    end
  end 


  def final_state_rank(spaces)
    if @game_rules.game_over?(spaces).class == String
      return 0 if @game_rules.tie?(spaces)
      @game_rules.winner?(spaces) == @game_piece ? 1 : -1
    end
  end
end