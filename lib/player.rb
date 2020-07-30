class Player
  attr_reader :color

  def initialize(color)
    @color = color
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

