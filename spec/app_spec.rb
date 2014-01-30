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
  end

  context 'play' do
    it 'displays the ttt board' do
      post '/play'
      last_response.should be_ok
    end

    # it 'creates a new game object' do
    #   Game.should_receive(:new)
    # end
  end
end
