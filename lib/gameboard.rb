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
  attr_reader :gameboard, :color, :position
  attr_accessor :initial_position

  def initialize(gameboard, color, position)
    @gameboard = gameboard
    @color = color
    @initial_position = position
    @position = initial_position
  end

  def moves(square)
    return false unless square_empty?(square)

    row = square[0]
    col = square[1]

    piece_one = gameboard.board[row - 1][col]
    piece_two = gameboard.board[row - 2][col]

    check_moves(piece_one, piece_two)
  end

  def check_moves(piece_one, piece_two)
    if is_a_pawn?(piece_one) && same_color?(piece_one)
      piece_one
    elsif empty_string?(piece_one) && is_a_pawn?(piece_two) &&
    same_color?(piece_two) && hasnt_moved?(piece_two)
      piece_two
    else
      false
    end
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

  def empty_string?(string)
    string == " "
  end

  def square_empty?(square)
    row = square[0]
    col = square[1]
    gameboard.board[row][col] == " "
  end
end

gameboard = Gameboard.new
pawn = Pawn.new(gameboard, "white", [1, 1])
pawn2 = Pawn.new(gameboard, "black", [1, 1])

