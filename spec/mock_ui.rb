class MockUI
  attr_accessor :asked_for_move,
                :baord,
                :displayed_computer_message,
                :displayed_updated_board,
                :invalid_message_sent,
                :moves,
                :provided_move,
                :provided_opponent_type,
                :showed_human_message, 
                :stored_moves
                
  def initialize
    @stored_moves = []
  end

  def welcome_message
    @showed_welcome_message
  end

  def game_piece
    "test"
  end

  def move
    "test"
  end

  def human_wins_message
    @showed_human_message = true
  end

  def computer_wins_message
    @displayed_computer_message = true
  end

  def ask_for_move
    @asked_for_move = true
  end

  def gets_move
    @provided_move = true
    @stored_moves.shift
  end

  def gets_opponent_type
    @provided_opponent_type = true
  end

  def invalid_move_message
    @invalid_message_sent = true
  end

  def display_grid(board)
    @displayed_updated_board = true
  end
end