require "./lib/piece.rb"

class Pawn < Piece
  attr_reader :direction
  attr_accessor :initial_position

  def initialize(gameboard, color, position)
    super(gameboard, color, position)
    @initial_position = position
    @direction = pick_direction
  end

  def moves(move)
    if move.length == 2
      pawn_moves(move)
    elsif move.include?("=") && move.length == 4
      promotion(move)
    else
      attack_moves(move)
    end
  end

  def legal_moves
    row = position[0]
    col = position[1]
    legal_moves = []

    square_above = gameboard.board[row - direction][col]
    two_squares_above = gameboard.board[row - direction * 2][col]
    diagonal_left = gameboard.board[row - direction][col - 1]
    diagonal_right = gameboard.board[row - direction][col + 1]
  
    if is_empty?(square_above)
      legal_moves << [row - direction, col]
    end

    if is_empty?(square_above) && is_empty?(two_squares_above) && hasnt_moved?
      legal_moves << [row - direction * 2, col]
    end

    if !same_color?(diagonal_left) && !is_empty?(diagonal_left)
      legal_moves << [row - direction, col - 1]
    end

    if !same_color?(diagonal_right) && !is_empty?(diagonal_right)
      legal_moves << [row - direction, col + 1] 
    end

    legal_moves
  end

  def pawn_moves(square)
    return false unless square_empty?(square)

    row = square[0]
    col = square[1]

    piece_one = gameboard.board[row + direction][col]
    piece_two = gameboard.board[row + direction * 2][col]

    check_moves(piece_one, piece_two)
  end

  def check_moves(piece_one, piece_two)
    if is_a_pawn?(piece_one) && same_color?(piece_one)
      piece_one
    elsif is_empty?(piece_one) && is_a_pawn?(piece_two) &&
    same_color?(piece_two) && hasnt_moved?(piece_two)
      piece_two
    else
      false
    end
  end

  def attack_moves(move)
    pawn_col = move[0]
    piece_row = move[1]
    piece_col = move[2]

    piece = gameboard.board[piece_row][piece_col]
    pawn = gameboard.board[piece_row + direction][pawn_col]

    if is_a_pawn?(pawn) && same_color?(pawn)
      pawn
    else
      false
    end
  end

  def support_moves(square)
    row = square[0]
    col = square[1]
  
    if attack_moves([col + 1, row, col]) || attack_moves([col - 1, row, col])
      true
    else
      false
    end
  end

  def pick_direction
    if white?
      -1
    elsif black?
      1
    end
  end

  def hasnt_moved?(pawn = self)
    pawn.initial_position == pawn.position
  end

  def is_a_pawn?(piece)
    piece.class == Pawn
  end
end

