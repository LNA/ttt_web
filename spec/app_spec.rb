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
