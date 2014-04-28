require 'game'

class WebGameStore
  @@games = []

  def self.games
    return @@games
  end

  def self.games
    @@games
  end

  def self.store(game)
    @@games << self
  end

  def self.new_game(params = {})
    @game = Game.new(params)
  end

  def self.current_game
    @game
  end

  def self.game_state
    @game_state = GameState.new('X', Array.new(9))
  end

  def self.current_game_state
    @game_state
  end
end
