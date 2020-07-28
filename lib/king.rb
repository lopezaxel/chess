require './lib/piece.rb'

class King < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
    @initial_position = position
  end

  def moves(square)
    moves = king_moves(square)
    king = check_squares_if_king(moves)
  end

  def check_squares_if_king(squares)
    squares.each do |square|
      row = square[0]
      col = square[1]
      square = gameboard.board[row][col]

      return square if is_a_king?(square)
    end

    false
  end

  def king_moves(square)
    row = square[0]
    col = square[1]
    moves = []

    moves << [row + 1, col]
    moves << [row - 1, col]
    moves << [row, col + 1]
    moves << [row, col - 1]
    moves << [row + 1, col + 1]
    moves << [row + 1, col - 1]
    moves << [row - 1, col + 1]
    moves << [row - 1, col - 1]

    gameboard.delete_moves_outside_board(moves)
  end

  def attack_moves(square)

  end

  def is_a_king?(piece)
    piece.class == King
  end
end

