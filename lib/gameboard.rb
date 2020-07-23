class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(8) { Array.new(8, " ") }
  end
end

class Pawn
  attr_reader :gameboard, :color, :position, :initial_position

  def initialize(gameboard, color, position)
    @gameboard = gameboard
    @color = color
    @initial_position = position
    @position = initial_position
  end

  def hasnt_moved?(pawn)
    pawn.initial_position == pawn.position
  end

  def same_color?(pawn)
    pawn.color == color
  end

  def is_a_pawn?(piece)
    piece.class == Pawn
  end

  def square_empty?(square)
    row = square[0]
    column = square[1]
    gameboard.board[row][column] == " "
  end
end

gameboard = Gameboard.new
pawn = Pawn.new(gameboard, "white", [1, 1])
pawn2 = Pawn.new(gameboard, "black", [1, 1])

