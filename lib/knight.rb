require "./lib/piece.rb"

class Knight < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def moves(move)
    moves = possible_moves(move) 
    knights = possible_knights(moves)

    if knights.length > 1
      pick_knight(knights, move.last)
    elsif knights.length == 1
      knights.first
    else
      false
    end
  end

  def possible_moves(move)
    moves = []
    row = move[0]
    col = move[1]

    moves << [row + 1, col + 2]
    moves << [row + 1, col - 2]
    moves << [row - 1, col + 2]
    moves << [row - 1, col - 2]
    moves << [row + 2, col + 1]
    moves << [row + 2, col - 1]
    moves << [row - 2, col + 1]
    moves << [row - 2, col - 1]

    moves.sort.keep_if { |m| gameboard.inside_board?(m) }
  end

  def possible_knights(moves)
    knights = []

    moves.each do |move|
      square = gameboard.board[move[0]][move[1]]

      knights << square if is_a_knight?(square) && same_color?(square)
    end

    knights
  end

  def pick_knight(knights, dif)
    row_or_col = disambiguate(knights)
    knights.each do |knight|
      return knight if knight.position[row_or_col] == dif
    end
  end

  def disambiguate(positions)
    knight_1 = positions[0]
    knight_2 = positions[1]

    knight_1.position[1] == knight_2.position[1] ? 0 : 1
  end

  def is_a_knight?(piece)
    piece.class == Knight
  end
end

require "./lib/gameboard.rb";gameboard = Gameboard.new
knight = Knight.new(gameboard, "white", [3, 7])

