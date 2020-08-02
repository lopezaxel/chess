require "./lib/piece.rb"

class Bishop < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def moves(move)
    bishops = diagonals(move)
    disambiguate(bishops, move) 
  end

  def diagonals(move)
    row = move[0]
    col = move[1]
    bishops = []

    bishops << diagonal(row, col, "top_right")
    bishops << diagonal(row, col, "top_left")
    bishops << diagonal(row, col, "bottom_right")
    bishops << diagonal(row, col, "bottom_left")

    remove_falses(bishops)
  end

  def legal_moves
    row = position[0]
    col = position[1]
    legal_moves = []

    legal_moves << legal_diagonal(row, col, "top_right")
    legal_moves << legal_diagonal(row, col, "top_left")
    legal_moves << legal_diagonal(row, col, "bottom_right")
    legal_moves << legal_diagonal(row, col, "bottom_left")

    legal_moves.flatten(1).uniq
  end

  def diagonal(row, col, direction)
    row_direction(row, direction).each do |r|
      return false unless gameboard.inside_board?([r, col])

      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square) && [r, col] != [row, col]
        return false
      end

      col = column_direction(col, direction)
    end
  end

  def legal_diagonal(row, col, direction)
    moves = []

    row_direction(row, direction).each do |r|
      next if [r, col] == [row, col] 
      next unless gameboard.inside_board?([r, col])

      col = column_direction(col, direction)

      square = gameboard.board[r][col]

      if is_empty?(square) 
        moves << [r, col]
      elsif !same_color?(square)
        moves << [r, col]
        break
      else
        break
      end
    end

    moves
  end

  def row_direction(row, direction)
    case direction
    when "top_left", "top_right"
      (row..row + 8)
    when "bottom_left", "bottom_right"
      (row - 8..row).to_a.reverse
    end
  end

  def column_direction(num, direction)
    case direction
    when "bottom_right", "top_right"
      num += 1
    when "bottom_left", "top_left"
      num -= 1
    end
  end

  def valid_bishop?(square)
    is_a_bishop?(square) && same_color?(square)
  end

  def is_a_bishop?(piece)
    piece.class == Bishop
  end
end

