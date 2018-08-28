require 'byebug'
require_relative 'piece'

class Board
  attr_accessor :grid
  attr_reader :start_piece
  
  def initialize
    @grid = create_starting_grid
  end

  def move_to(start_pos, end_pos)
    valid_move?(start_pos, end_pos)
    @grid[end_pos[0]][end_pos[1]] = start_piece
    @grid[start_pos[0]][start_pos[1]] = NullPiece.instance
    
  end
  
  private
  
  def valid_move?(start_pos, ending_pos)
    starting_row, starting_col = start_pos
    new_row, new_col =  ending_pos
    @start_piece = @grid[starting_row][starting_col]
    
    raise "No pieces at given position, try again." if start_piece.is_a?(NullPiece)
    
    possible_moves = start_piece.possible_moves(start_pos)
    unless possible_moves.include?( ending_pos) && ((0..7).to_a.include?(new_row) && (0..7).to_a.include?(new_col))
      raise 'Invalid movement'
    end
    
    if start_piece.instance_of?(Pawn)
      valid_pawn_play?(start_pos, ending_pos)
    end
    
    path = get_path(start_pos, ending_pos)
    path[0...-1].each do |pos|
      raise "Obstructed path" unless @grid[pos[0]][pos[1]].instance_of?(NullPiece)
    end
    last_pos = @grid[path.last[0]][path.last[1]]
    
    if last_pos.instance_of?(NullPiece)
      "You moved! #{@start_piece} to #{ending_pos}"
    elsif last_pos.color != start_piece.color
      "You took a piece at #{ending_pos}"
    else
      raise "You are attempting to take your own piece"
    end
  end
  
  
  def get_base_move(start_pos, ending_pos)
    x_dif = ending_pos[0] - start_pos[0]
    y_dif = ending_pos[1] - start_pos[1]

    start_piece = @grid[start_pos[0]][start_pos[1]]
    if start_piece.instance_of?(Pawn)
      base_moves = pawn_base_moves(start_piece)
    else 
      base_moves = start_piece.base_moves
    end
    
    correct_move = base_moves.sort_by do |move|
      (move[0]- x_dif).abs  + (move[1] - y_dif).abs
    end
    correct_move.first
  end
  
  def get_path(start_pos,ending_pos)
    path = []
    base_move = get_base_move(start_pos,ending_pos)
    first_move = [base_move[0] + start_pos[0], base_move[1] + start_pos[1]]
    path << first_move
    until path.last == ending_pos
      path << [path.last[0] + base_move[0], path.last[1] + base_move[1]]
    end
    path
  end
  
  
  def pawn_base_moves(start_piece)
    base_moves = start_piece.base_moves

    if base_moves.any? {|move| move.include?(2) || move.include?(-2)}
      start_piece.base_moves = base_moves.reject {|move| move.include?(2) || move.include?(-2)}
      start_piece.moves = start_piece.base_moves
    end
    base_moves
  end
  
  def valid_pawn_play?(start_pos, ending_pos)
    end_piece = @grid[ending_pos[0]][ending_pos[1]]
    if start_pos[0] != ending_pos[0] && start_pos[1] != ending_pos[1]
      raise 'No piece to take!' if end_piece.instance_of?(NullPiece)
      raise "Can't take your own piece!" if end_piece.color == @start_piece.color
    end
  end
  
  def populate_pawns(grid, row, color)
    grid[row].map{ |cell| cell = Pawn.new(color) }
  end
  
  def populate_back_row(grid, row, color)
    grid[row].length.times do |i|
      case i
      when 0, 7
        grid[row][i] = Rook.new(color)
      when 1, 6
        grid[row][i] = Knight.new(color)
      when 2, 5
        grid[row][i] = Bishop.new(color)
      when 3
        grid[row][i] = Queen.new(color)
      when 4
        grid[row][i] = King.new(color)
      end
      
    end
    grid[row]
  end
  
  def create_starting_grid
    starting_grid = Array.new(8) { Array.new(8) }
    starting_grid.length.times do |row|
      if row == 1
        pawns_row = populate_pawns(starting_grid, row, color = "green")
        starting_grid[row] = pawns_row
        next
      elsif row == 6
        pawns_row = populate_pawns(starting_grid, row, color = "red")
        starting_grid[row] = pawns_row
        next
      end
      
      if row == 0 
        back_row = populate_back_row(starting_grid, row, color = "green")
        starting_grid[row] = back_row
        next
      elsif row == 7
        back_row = populate_back_row(starting_grid, row, color = "red")
        starting_grid[row] = back_row
        next
      end

      starting_grid.length.times do |col|
        starting_grid[row][col] = NullPiece.instance
      end
    end
    return starting_grid
  end
end