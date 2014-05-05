class Board
  attr_accessor :spaces, :open_spaces

  def initialize
    @spaces = [nil]*9
  end

  def fill(move, game_piece)   
    @spaces[move.to_i] = game_piece
  end

  def open_spaces
    open_spaces = []
    @spaces.each_with_index do |player, space|
      if player == nil
        open_spaces << space
      end
    end
    open_spaces
  end
end