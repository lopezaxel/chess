class Player
  attr_accessor :king, :king_in_check
  attr_reader :color

  def initialize(color)
    @color = color
    @king = nil
    @king_in_check = false
  end

  def contrary_color
    if color == 'white'
      'black'
    else
      'white'
    end
  end

  def input
    gets.chomp
  end
end

