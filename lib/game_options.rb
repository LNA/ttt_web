class GameOptions
  attr_accessor  :game_type, :player_one, :player_two, :ui

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
  end

  def set_player_options
    set_player_one_type
    set_player_two_type
    set_game_type
  end

  def set_player_one_type 
    if @player_one.upcase == "H"
      @player_one = 'human'
    else
      @player_one =  'ai'
    end
  end

  def set_player_two_type 
    if @player_two.upcase == "H"
      @player_two = 'human'
    else
      @player_two =  'ai'
    end
  end

  def set_game_type
    if @player_one && @player_two == 'human'
      @game_type = 'human versus human'
    else
      @game_type = 'human versus ai'
    end
  end
end