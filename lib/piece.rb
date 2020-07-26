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

  def disambiguation(pieces, diff)
    row_or_col = pick_difference(pieces)
    pieces.each do |piece|
      return piece if piece.position[row_or_col] == diff
    end
  end

  def pick_difference(pieces)
    piece_1 = pieces[0]
    piece_2 = pieces[1]

    columns_are_equal = piece_1.position[1] == piece_2.position[1] 
    columns_are_equal ? 0 : 1
  end

  def disambiguate(pieces, move)
    if pieces.length > 1
      disambiguation(pieces, move.last)
    elsif pieces.length == 1
      pieces.first
    else
      false
    end
  end
end

