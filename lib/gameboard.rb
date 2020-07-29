require "./lib/pawn.rb"

class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def convert_board
    chessboard = create_board

    board.each_with_index do |row, r_idx|
      row.each_index do |col|
        square = board[r_idx][col]

        next if square.is_a?(String) || square.nil?

        piece_name = square.class.to_s.to_sym
        chessboard[r_idx][col] = pick_piece(piece_name, square.color)
      end
    end

    chessboard
  end

  def pick_piece(piece, color)
    case color
    when "white"
      white_pieces_characters[piece]
    when "black"
      black_pieces_characters[piece]
    end
  end

  def white_pieces_characters
    {
      Queen: "\u2655".encode("utf-8"),
      Rook: "\u2656".encode("utf-8"),
      Bishop: "\u2657".encode("utf-8"),
      Knight: "\u2658".encode("utf-8"),
      Pawn: "\u2659".encode("utf-8"),
      King: "\u2654".encode("utf-8")
    }
  end

  def black_pieces_characters
    {
      Queen: "\u265B".encode("utf-8"),
      Rook: "\u265C".encode("utf-8"),
      Bishop: "\u265D".encode("utf-8"),
      Knight: "\u265E".encode("utf-8"),
      Pawn: "\u265F".encode("utf-8"),
      King: "\u265A".encode("utf-8")
    }
    
  end
 
  def display_board
    graphic_board = ""

    convert_board.each do |row|
      graphic_board += "|#{row.join("|")}|\n"
    end

    graphic_board
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

