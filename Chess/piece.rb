require 'singleton'

class Piece
  attr_accessor :pos
  attr_reader :color
  def initialize(color)
    @color = color
    #@pos = pos
  end
  
  def possible_moves(pos)
    possible_moves = []
    @moves.each do |ele|
      possible_moves << [ele[0] + pos[0], ele[1] + pos[1]]
    end
    possible_moves
  end
  
end

class Knight < Piece
  attr_reader :moves
  def initialize(color)
    super
    @moves = [[1,2],[1,-2]]
  end
end

class Pawn < Piece
end



class Bishop < Piece
end

class Rook < Piece
  attr_reader :moves, :base_moves
  def initialize(color)
    super
    @moves = generate_moves
    @base_moves = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
  
  def generate_moves
    up = []
    down = []
    left = []
    right = []
    
    i = 0
    while i < 7
      up << [i+1,0]
      down << [-(i+1),0]
      left << [0,-(i+1)]
      right << [0,i+1]
      i+=1
    end
    up + down + left + right
  end

end

class King < Piece
end

class Queen < Piece
end


class NullPiece < Piece
  include Singleton
  def initialize
  end
end