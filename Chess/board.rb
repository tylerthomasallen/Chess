require 'byebug'
require_relative 'piece'

class Board
  attr_accessor :grid
  
  def initialize
    @grid = create_starting_grid
    
  end
  
  def move_piece(start_pos,new_pos)
    starting_row, starting_col = start_pos
    new_row, new_col = new_pos
    start_piece = get_piece(starting_row,starting_col)
    raise "No pieces at given position, try again." if start_piece.is_a?(NullPiece)
    
    if valid_move?(start_piece,start_pos,new_pos)
      move_to(start_piece,new_pos)
    else
      raise ""
  end
  
  def move_to(piece,pos)
  end
  
  def [](pos)
    row,col = pos
    @grid[row][col]
  end
  
  def []=(pos, target)
    row, col = pos
    @grid[row][col] = target
  end
  
  
  
  private
  def create_starting_grid
    starting_grid = Array.new(8) { Array.new(8) }
    starting_grid.length.times do |row|
      if row == 1 || row == 6
        pawns_row = populate_pawns(starting_grid, row)
        starting_grid[row] = pawns_row
        next
      end
      
      if row == 0 || row == 7
        back_row = populate_back_row(starting_grid, row)
        starting_grid[row] = back_row
        next
      end

      starting_grid.length.times do |col|
        starting_grid[row][col] = NullPiece.new
      end
    end
    return starting_grid
  end
  
  def populate_pawns(grid, row)
    # debugger
    grid[row].map{ |cell| cell = Pawn.new }
  end
  
  def populate_back_row(grid, row)
    grid[row].length.times do |i|
      case i
      when 0, 7
        grid[row][i] = "Rook.new"
      when 1, 6
        grid[row][i] = "Knight.new"
      when 2, 5
        grid[row][i] = "Bishop.new"
      when 3
        grid[row][i] = "Queen.new"
      when 4
        grid[row][i] = "King.new"
      end
      
    end
    grid[row]
  end
    
  
end