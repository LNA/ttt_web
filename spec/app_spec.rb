require 'spec_helper'

describe App do

  let (:player_one_piece) {"X"}
  let (:player_two_piece) {"O"}
  let (:params) {{:player_one_piece => 'X', 
                  :player_two_piece => 'O'}}

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
      Game.should_receive(:new)
      post "/new_game/#{player_one_piece}/#{player_two_piece}" 
    end
  end

  context '#save' do
    it 'saves a game in the records with the id' do
      datastore.save(game)

      datastore.game.should == true
    end

  context 'move'
  it 'makes a move' do
    put '/move/:space/:piece' 

    last_response.should be_ok
    end
  end
end
