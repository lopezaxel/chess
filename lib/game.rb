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

  def convert_pawn_move_to_number(move)
    if is_a_pawn_move?(move) 
      file = column_to_number(move[0]) - 1
      rank = move[1]

      [rank, file]
    elsif is_a_pawn_attack_move?(move) 
      file_1 = column_to_number(move[0]) - 1
      file_2 = column_to_number(move[2]) - 1 
      rank = move[3] - 1

      [file_1, rank, file_2]
    # elsif is_a_promotion_move?(move)
      # promote
    end
  end

  def is_a_promotion_move?(move)
    is_a_file?(move[0]) && is_a_rank?(move[1]) && is_an_equals?(move[2]) && 
      ['N', 'B', 'R', 'Q'].include?(move[3])
  end

  def is_a_pawn_move?(move)
    move.size == 2 && is_a_file?(move[0]) && is_a_rank?(move[1])
  end

  def is_a_pawn_attack_move?(move)
    is_a_file?(move[0]) && is_a_x?(move[1]) && is_a_pawn_move?(move[2..3])
  end

  def is_a_piece?(letter)
    ['N', 'K', 'Q', 'R', 'B'].include?(letter)
  end

  def is_a_file?(letter)
    ('a'..'h').include?(letter)
  end

  def is_a_rank?(letter)
    (1..8).include?(letter)
  end

  def column_to_number(column)
    column.ord - 96
  end

  def is_a_x?(letter)
    letter == 'x'
  end

  def is_an_equals?(letter)
    letter == '='
  end
end

gameboard = Gameboard.new
game = Game.new(gameboard, 1, 1)

game.fill_board
puts game.gameboard.display_board

