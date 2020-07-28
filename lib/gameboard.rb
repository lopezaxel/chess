require "./lib/pawn.rb"

class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(8) { Array.new(8, " ") }
  end

  def board_size
    board.size - 1
  end

  def inside_board?(move)
    row = move[0]
    col = move[1]

    return if row.nil? || col.nil?

    row >= 0 && row <= board_size && col >= 0 && col <= board_size
  end

  def delete_moves_outside_board(moves)
    moves.keep_if { |move| inside_board?(move) }.sort
  end
end

