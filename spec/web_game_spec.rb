require 'spec_helper'

describe 'WebGame' do 
  let (:params) {{:player_one_piece => 'X', 
                  :player_two_piece => 'O'}}
  let (:web_game) {WebGame.new(params)}
  let (:game) {web_game.new_game}
end