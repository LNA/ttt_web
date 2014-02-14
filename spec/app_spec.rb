require 'spec_helper'

describe App do

  let (:player_one_piece) {"X"}
  let (:player_two_piece) {"O"}
  let (:params) {{:player_one_piece => 'X', 
                  :player_two_piece => 'O',
                  :player_one_type => "Human",
                  :player_two_type => "Human"}}

  let (:datastore) {WebGameRepository.new}
  let (:game) {Game.new(params)}



  def app
    @app ||= App
  end

  context 'the home page' do
    it 'loads home page' do
      get '/' 
      last_response.should be_ok
    end
  end

  context 'play' do
    it 'displays the ttt board' do
      MockGame = Struct.new(:player_one_type, :player_two_type, :player_one_piece, :player_two_piece)
      mock_game = MockGame.new("Human", "Human", "X", "O")

      MockGameState = Struct.new(:board)
      mock_state = MockGameState.new((1..9).to_a)

      get '/play', {}, 'rack.session' => { :game => mock_game, :game_state => mock_state }

      last_response.should be_ok
    end
  end
end
