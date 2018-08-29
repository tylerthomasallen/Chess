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

  def move_cursor
    do_loop = true
    while do_loop
      system("clear")
      render
      val = @cursor.get_input
      return val unless val.nil?
      do_loop = false if val != nil
    end
    return val
  end

  def render
    @board.grid.each_with_index do |row,i|
      row.each_with_index do |obj,j|
        if (i+j).odd?
          if @cursor.cursor_pos == [i,j]
            print "     #{obj.symbol}     ".colorize(:color => :light_blue, :background => :red)
          else
            print "     #{obj.symbol}     ".colorize(:background => :magenta)
          end
        else
          if @cursor.cursor_pos == [i,j]
            print "     #{obj.symbol}     ".colorize(:color => :light_blue, :background => :red)
          else
            print "     #{obj.symbol}     ".colorize(:background => :white)
          end
        end

      end
      puts ''
    end

  end
end
