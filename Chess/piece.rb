class Piece
  attr_accessor :pos
  attr_reader :color
  def initialize(color,pos)
    @color = color
    @pos = pos
  end
  
end

class Knight < Piece
end

class Pawn < Piece
end



class Bishop < Piece
end

class Rook < Piece
end

class King < Piece
end

class Queen < Piece
end


class NullPiece < Piece
end