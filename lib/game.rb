require './lib/gameboard'
require './lib/queen'
require './lib/rook'
require './lib/bishop'
require './lib/knight'
require './lib/pawn'
require './lib/king'

class Game
  attr_reader :player_1, :player_2, :gameboard

  def initialize(gameboard, player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @gameboard = gameboard
  end

  def fill_board
    gameboard.board.each_with_index do |row, row_idx|
      row.each_index do |col|
        piece = case row_idx
                when 0
                  fill_pieces_row(row_idx, col, "white")
                when 1
                  fill_pawn_row(row_idx, col, "white")
                when 6
                  fill_pawn_row(row_idx, col, "black")
                when 7
                  fill_pieces_row(row_idx, col, "black")
                end

        gameboard.board[row_idx][col] = piece
      end
    end
  end

  def fill_pawn_row(row, col, color)
    Pawn.new(gameboard, color, [row, col])
  end

  def fill_pieces_row(row, col, color)
    case col
    when 0, 7
      Rook.new(gameboard, color, [row, col])
    when 1, 6
      Knight.new(gameboard, color, [row, col])
    when 2, 5
      Bishop.new(gameboard, color, [row, col])
    when 3
      Queen.new(gameboard, color, [row, col])
    when 4
      King.new(gameboard, color, [row, col])
    end
  end

  def square_is_supported(square, color)
    queen = Queen.new(gameboard, color, [0, 0])
    rook = Rook.new(gameboard, color, [0, 0])
    bishop = Bishop.new(gameboard, color, [0, 0])
    knight = Knight.new(gameboard, color, [0, 0])
    pawn = Pawn.new(gameboard, color, [0, 0])
    king = King.new(gameboard, color, [0, 0])

    if queen.moves(square) || rook.moves(square) || bishop.moves(square) ||
      knight.moves(square) || king.moves(square) || pawn.support_moves(square)
      true
    else
      false
    end
  end
end

gameboard = Gameboard.new
game = Game.new(gameboard, 1, 1)

game.fill_board
puts game.gameboard.display_board

