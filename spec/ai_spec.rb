require 'ai'
require 'board'
require 'game_rules'

describe AI do
  let (:game_rules) {GameRules.new}
  let (:board)      {Board.new}

  before :each do
    @ai = AI.new(game_rules)
  end

  context 'minimax score for possible moves' do
    it 'scores a loss when there are only two moves left correctly' do
    end 

    it 'scores a tie in two moves correctly' do
    end
  end
end