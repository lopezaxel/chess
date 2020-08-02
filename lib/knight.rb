require "./lib/piece.rb"

class Knight < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def moves(move)
    moves = possible_moves(move) 
    knights = possible_knights(moves)
    disambiguate(knights, move) 
  end

  def legal_moves
    moves = possible_moves(position)
    legal_moves = []

    moves.each do |move|
      row = move[0]
      col = move[1]
      square = gameboard.board[row][col]

      if is_empty?(square)
        legal_moves << [row, col]
      elsif same_color?(square)
        next
      else
        legal_moves << [row, col]
        next
      end
    end

    legal_moves
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

    gameboard.delete_moves_outside_board(moves)
  end

  def possible_knights(moves)
    knights = []

    moves.each do |move|
      square = gameboard.board[move[0]][move[1]]
      knights << square if is_a_knight?(square) && same_color?(square)
    end

    knights
  end

  def is_a_knight?(piece)
    piece.class == Knight
  end
end

require "./lib/gameboard.rb";gameboard = Gameboard.new
knight = Knight.new(gameboard, "white", [3, 7])

