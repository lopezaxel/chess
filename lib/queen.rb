require './lib/piece.rb'
require './lib/rook.rb'
require './lib/bishop.rb'

class Queen < Piece
  attr_accessor :rook, :bishop

  def initialize(gameboard, color, position)
    super(gameboard, color, position)
    @rook = Rook.new(gameboard, color, position)
    @bishop = Bishop.new(gameboard, color, position)
  end

  def moves(move)
    queens = queen_moves(move)
    disambiguate(queens, move) 
  end

  def queen_moves(move)
    row = move[0]
    col = move[1]
    queens = []

    return [] if valid_queen?(gameboard.board[row][col])

    queens << rook_moves(row, col, "top")
    queens << rook_moves(row, col, "bottom")
    queens << rook_moves(row, col, "right")
    queens << rook_moves(row, col, "left")

    queens << bishop_moves(row, col, "top_right")
    queens << bishop_moves(row, col, "top_left")
    queens << bishop_moves(row, col, "bottom_right")
    queens << bishop_moves(row, col, "bottom_left")

    remove_falses(queens)
  end

  def legal_moves
    row = position[0]
    col = position[1]
    legal_moves = []

    legal_moves << rook.legal_moves
    legal_moves << bishop.legal_moves

    legal_moves.flatten(1).uniq
  end

  def rook_moves(row, col, direction)
    rook.choose_direction(row, col, direction).each do |i|
      return false unless gameboard.inside_board?([i, col])

      move = rook.pick_square(direction, row, col, i)
      square = gameboard.board[move[0]][move[1]]

      if valid_queen?(square)
        return square
      elsif !is_empty?(square) && not_initial_square(row, col, i)
        return false
      end
    end
  end

  def bishop_moves(row, col, direction)
    bishop.row_direction(row, direction).each do |r|
      return false unless gameboard.inside_board?([r, col])

      square = gameboard.board[r][col]

      if valid_queen?(square)
        return square
      elsif !is_empty?(square) && not_initial_square(row, col, r)
        return false
      end

      col = bishop.column_direction(col, direction)
    end
  end

  def is_a_queen?(piece)
    piece.class == Queen
  end

  def valid_queen?(piece)
    is_a_queen?(piece) && same_color?(piece)
  end
end

