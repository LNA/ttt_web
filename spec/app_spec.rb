require 'spec_helper'

describe App do
  def app
    @app ||= App
  end

  context 'the home page' do
    it 'loads home page' do
      get '/' 
      last_response.should be_ok
    end

    it 'sets the game piece after player one piece is set' do 
      player_one_game_piece = 'X'
      post '/'
      expect(player_two_piece).to eq 'O'
    end

    it 'loads the play page after the start button is hit' do 
      post '/'
      last_response.should be_ok 
    end
  end

  context 'play' do
    it 'displays the ttt board' do
      get '/play'
      last_response.should be_ok
    end
  end
end
