require_relative 'board'
require_relative 'cursor'
require 'byebug'
require 'colorize'

class Display
  attr_reader :board, :cursor
  
  def initialize(board)
    @cursor = Cursor.new([0,0],board)
    @board = board
  end
  
  def something
    temporary_loop = true
    until temporary_loop == false
      system("clear")
      render
      @cursor.get_input
    end
  end
  
  def render
    @board.grid.each_with_index do |row,i|
      row.each_with_index do |obj,j|
        if @cursor.cursor_pos == [i,j]
          print "#{obj.symbol}".colorize(:color => :light_blue, :background => :red)
        else
          print "#{obj.symbol}"
        end
        
      end
      puts ''
    end
    
  end
end
  

if __FILE__ == $PROGRAM_NAME
  x = Board.new
  y = Display.new(x)
  y.something
end
  