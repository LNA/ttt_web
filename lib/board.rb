class Board
  attr_accessor :spaces

  def initialize
    @spaces = [nil]*9
  end

  def fill(space, game_piece)
    @spaces[space] = game_piece
  end

  def open_spaces
  end
end