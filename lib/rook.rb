require "./lib/piece.rb"

class Rook < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def moves(move)
    rooks = rook_moves(move)
    disambiguate(rooks, move) 
  end

  def rook_moves(move)
    row = move[0]
    col = move[1]
    rooks = []

    rooks << check_direction(row, col, "top")
    rooks << check_direction(row, col, "bottom")
    rooks << check_direction(row, col, "right")
    rooks << check_direction(row, col, "left")

    remove_falses(rooks)
  end

  def legal_moves
    row = position[0]
    col = position[1]
    legal_moves = []

    legal_moves << legal_rook_moves(row, col, "top")
    legal_moves << legal_rook_moves(row, col, "bottom")
    legal_moves << legal_rook_moves(row, col, "right")
    legal_moves << legal_rook_moves(row, col, "left")

    legal_moves.flatten(1).uniq
  end

  def legal_rook_moves(row, col, direction)
    moves = []

    choose_direction(row, col, direction).each do |i|
      next unless gameboard.inside_board?([i, col])

      move = pick_square(direction, row, col, i)
      square = gameboard.board[move[0]][move[1]]

      if is_empty?(square)
        moves << move
      elsif same_color?(square)
        break
      else
        moves << move
        break
      end
    end

    moves
  end

  def check_direction(row, col, direction)
    choose_direction(row, col, direction).each do |i|
      return false unless gameboard.inside_board?([i, col])

      move = pick_square(direction, row, col, i)
      square = gameboard.board[move[0]][move[1]]

      if is_a_rook?(square) && same_color?(square)
        return square
      elsif !is_empty?(square) && not_initial_square(row, col, i)
        return false
      end
    end
  end

  def pick_square(direction, row, col, i)
    return if gameboard.board.nil? || row.nil? || col.nil? || i.nil?
    case direction
      when "top", "bottom"
        [i, col]
      when "right", "left"
        [row, i]
      end
  end

  def choose_direction(row, col, direction)
    case direction
    when "top"
      (row..row + 8) 
    when "bottom"
      (row - 8..row).to_a.reverse
    when "right"
      (col..col + 8)
    when "left"
      (col - 8..col).to_a.reverse
    end
  end

  def is_a_rook?(piece)
    piece.class == Rook
  end
end

