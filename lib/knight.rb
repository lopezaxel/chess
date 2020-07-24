require "./lib/piece.rb"

class Knight < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def moves(move)
    possible_moves = []
    row = move[0]
    col = move[1]

    possible_moves << [row + 1, col + 2]
    possible_moves << [row + 1, col - 2]
    possible_moves << [row - 1, col + 2]
    possible_moves << [row - 1, col - 2]
    possible_moves << [row + 2, col + 1]
    possible_moves << [row + 2, col - 1]
    possible_moves << [row - 2, col + 1]
    possible_moves << [row - 2, col - 1]

    possible_moves.sort.keep_if { |m| gameboard.inside_board?(m) }
  end

  def is_a_knight?(piece)
    piece.class == Knight
  end
end

