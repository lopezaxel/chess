class Piece
  attr_reader :gameboard, :color
  attr_accessor :position

  def initialize(gameboard, color, position)
    @gameboard = gameboard
    @color = color
    @position = position
  end

  def same_color?(pawn)
    pawn.color == color
  end

  def is_empty?(string)
    string == " "
  end

  def square_empty?(square)
    row = square[0]
    col = square[1]
    gameboard.board[row][col] == " "
  end

  def white?
    color == "white"
  end

  def black?
    color == "black"
  end
end

