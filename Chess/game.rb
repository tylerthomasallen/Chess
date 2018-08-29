require 'byebug'
require_relative 'board'
require_relative 'display'
require_relative 'humanplayer'
class Game
  attr_reader :display, :board, :player1, :player2


  def initialize(board)
    @board = board
    @display = Display.new(board)
    @player1 = "bob"
    @player2 = "jim"
  end

  def play

    until game_over?
      make_move
      switch_players
    end

    puts "Game Over!"
  end


  def make_move
    starting_pos = @display.move_cursor
    #
    # while starting_pos == nil
    #   starting_pos = @display.cursor.get_input
    #   #byebug
    # end


    ending_pos = @display.move_cursor
    @board.move_to(starting_pos, ending_pos)
  end

  def switch_players
    p "got here"
    sleep(1)
  end

  def game_over?
    king_count = 0
    @board.grid.each do |row|
      row.each do |obj|
        king_count += 1 if obj.instance_of?(King)
      end
    end

    king_count < 2 ? true : false
  end


end


if __FILE__ == $PROGRAM_NAME

  x = Board.new
  game = Game.new(x)
  game.play

end
