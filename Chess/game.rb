require 'byebug'
require_relative 'board'
require_relative 'display'
require_relative 'humanplayer'
class Game
  attr_reader :display, :board, :player1, :player2

  def initialize(board, p1, p2)
    @board = board
    @display = Display.new(board)
    @player1 = p1
    @player2 = p2
    @current_player = @player1
  end

  def play
    p "#{@player1.name}, start the game!"
    sleep(1)
    until game_over?
      make_move
      switch_players
    end

    puts "Game Over!"
    sleep(3)
  end

  def make_move
    starting_pos = @display.move_cursor
    ending_pos = @display.move_cursor
    @board.move_to(starting_pos, ending_pos)
  end

  def switch_players
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    p "It's now #{@current_player.name}'s turn! Please move the #{@current_player.color} pieces."
    sleep(2)
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
  p "What is player one's name?:"
  p1_name = gets.chomp
  p "What is player two's name?:"
  p2_name = gets.chomp


  p1 = HumanPlayer.new(p1_name, 'White')
  p2 = HumanPlayer.new(p2_name, 'Black')

  p "#{p1_name} is assigned to White pieces"
  p "#{p2_name} is assigned to Black pieces"
  sleep(1)

  x = Board.new
  game = Game.new(x, p1, p2)
  game.play

end
