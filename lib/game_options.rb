class GameOptions
  attr_accessor  :game_type, :player, :player_one, :player_two, :ui

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
  end

  def set_player_type(player_one, player_two)
    @player_one = player_one.upcase
    @player_two = player_two.upcase
    players = []
    players << @player_one
    players << @player_two

    players.each do |player|
      if player == "H"
        player = 'human'
      else
        player = 'ai'
      end
    end
  end

  def set_game_type
    if @player_one && @player_two == "H"
      @game_type ='human versus human'
    else
      @game_type = 'human versus ai'
    end
    @game_type
  end
end
