class Player
<<<<<<< HEAD
  attr_accessor :king, :king_in_check
=======
>>>>>>> 6f8a5737011eb708424eaba76bac4e5600e8e22c
  attr_reader :color

  def initialize(color)
    @color = color
<<<<<<< HEAD
    @king = nil
    @king_in_check = false
=======
>>>>>>> 6f8a5737011eb708424eaba76bac4e5600e8e22c
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

