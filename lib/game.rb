class Game
  attr_accessor :player_one, :player_two,
                :player_one_piece, :player_two_piece,
                :player_one_type, :player_two_type

  def initialize(params = {})
    @player_one_piece = params[:player_one_piece]
    @player_two_piece = params[:player_two_piece]
    @player_one_type = params[:player_one_type]
    @player_two_type = params[:player_two_type]
  end

  def update(params ={})
    @player_one_piece = params[:player_one_piece] unless @player_one_piece.nil?
    @player_two_piece = params[:player_two_piece] unless @player_two_piece.nil?
  end

  def either_player_is_ai(player_one, player_two)
    player_one == 'ai' || player_two == 'ai'
  end
end
