require_relative 'piece.rb'

class Board
  def initialize(board = nil)
    @board ||= Array.new(8) { Array.new(8) }
  end
  
  def populate_board
    @board.length.times do |row|
      @board.length.times do |col|
        @board[row][col] = NullPiece.new
      end
    end
  end
end