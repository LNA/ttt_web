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
      get '/play'
      last_response.should be_ok
    end

    it 'starts a new game' do 
     
      post "/new_game", params
    end
  end

  context 'move' do
    it 'makes a move' do

    end
  end
end
