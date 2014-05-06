$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'

require 'app'
require 'ai'
require 'board'
require 'game_rules'
require 'rack/test'
require 'ui'
require 'web_game'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
