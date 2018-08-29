require_relative "cursor"
class HumanPlayer
  attr_reader :name
  
  def initialize(name)
    @name = name
    @cursor = Cursor.new([0,0],)
  end
  
  def make_move(something)
    curser.obj.get_input
    return pos
  end
end