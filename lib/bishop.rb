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

    bishops << diagonal(row, col, "right", "top")
    bishops << diagonal(row, col, "left", "top")
    bishops << diagonal(row, col, "right", "bottom")
    bishops << diagonal(row, col, "left", "bottom")

    remove_falses(bishops)
  end

  def row_direction(row, direction)
    case direction
    when "top"
      (row..row + 8)
    when "bottom"
      (row - 8..row).to_a.reverse
    end
  end

  def column_direction(num, direction)
    case direction
    when "right"
      num += 1
    when "left"
      num -= 1
    end
  end

  def diagonal(row, col, col_dir, row_dir)
    row_direction(row, row_dir).each do |r|
      return false unless gameboard.inside_board?([r, col])

      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square) && [r, col] != [row, col]
        return false
      end

      col = column_direction(col, col_dir)
    end
  end

  def valid_bishop?(square)
    is_a_bishop?(square) && same_color?(square)
  end

  def is_a_bishop?(piece)
    piece.class == Bishop
  end
end

