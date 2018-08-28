require 'singleton'

class Piece
  attr_accessor :pos, :base_moves, :moves
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def possible_moves(pos)
    possible_moves = []
    @moves.each do |ele|
      possible_moves << [ele[0] + pos[0], ele[1] + pos[1]]
    end
    possible_moves
  end
  
  def generate_moves
    []
  end
  
  
  # def inspect
  #   puts "#{self.color} #{self.class.name}"
  # end
  
end

class Knight < Piece
  def initialize(color)
    super
    @moves = [[1,2],[1,-2],[2,-1],[2,1],[-1,2],[-1,-2],[-2,1],[-2,-1]]
    @base_moves = moves
  end
  
  def symbol
    if @color == 'green'
      "♘"	
    else
      "♞"
    end
  end
end

class Pawn < Piece
  def initialize(color)
    super
    if @color == 'green'
      @base_moves = [[0, 1], [1, 0], [1,1], [2, 0], [1, -1]]
    else
      @base_moves = [[0, -1], [-1, 0],[-1,-1], [-1,1], [-2, 0]]      
    end
    @moves = @base_moves
  end
  
  def symbol
    if @color == 'green'
      "♙"	
    else
      "♟"
    end
  end
end



class Bishop < Piece
  def initialize(color)
    super
    @moves = generate_moves
    @base_moves = [[1,1],[-1,-1],[1,-1],[-1,1]]
  end
  
  def generate_moves
    up_left, down_left, up_right, down_right = [], [], [], []
    
    i = 0
    while i < 7
      up_left << [i+1,-(i+1)]
      down_left << [-(i+1),-(i+1)]
      up_right << [i+1,i+1]
      down_right << [-(i+1),i+1]
      i+=1
    end
    up_left + down_left + up_right + down_right
  end
  
  def symbol
    if @color == 'green'
      "♗"
    else
      "♝"
    end
  end
  
end

class Rook < Piece
  def initialize(color)
    super
    @moves = generate_moves
    @base_moves = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
  
  def generate_moves
    up, down, left, right = [], [], [], []
    
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
  
  def symbol
    if @color == 'green'
      "♖"
    else
      "♜"
    end
  end

end

class King < Piece
  def initialize(color)
    super
    @base_moves = [[0, 1], [0, -1], [1, 0], [-1, 0],
                  [1,1],[-1,-1],[1,-1],[-1,1]]
    @moves = @base_moves
  end
  
  def symbol
    if @color == 'green'
      "♔"
    else
      "♚"
    end
  end
end

class Queen < Piece
  def initialize(color)
    super
    @moves = generate_moves
    @base_moves = [[0, 1], [0, -1], [1, 0], [-1, 0],
                  [1,1],[-1,-1],[1,-1],[-1,1]]
  end
  
  def generate_moves
    up, down, left, right = [], [], [], []
    up_left, down_left, up_right, down_right = [], [], [], []
    
    i = 0
    while i < 7
      up_left << [i+1,-(i+1)]
      down_left << [-(i+1),-(i+1)]
      up_right << [i+1,i+1]
      down_right << [-(i+1),i+1]
      up << [i+1,0]
      down << [-(i+1),0]
      left << [0,-(i+1)]
      right << [0,i+1]
      i+=1
    end
    up + down + left + right + up_left + down_left + up_right + down_right
  end
  def symbol
    if @color == 'green'
      "♕"	
    else
      "♛"
    end
  end
  
  
end


class NullPiece < Piece
  include Singleton
  def initialize
  end
  def symbol
    " "
  end
end