$: << File.expand_path(File.dirname(__FILE__))
require 'game'
game = Game.new
game.generate_tree
game.run