require "./lib/piece.rb"

class Bishop < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def is_a_bishop?(piece)
    piece.class == Bishop
  end

  def diagonals(square)
    row = square[0]
    col = square[1]
    bishops = []

    bishops << top_right_diagonal(row, col)
    bishops << top_left_diagonal(row, col)
    bishops << bottom_right_diagonal(row, col)
    bishops << bottom_left_diagonal(row, col)

    bishops.keep_if { |b| b != false }

    bishops
  end

  def top_right_diagonal(row, col)
    row.upto(row + 8) do |r|
      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      col += 1
    end
  end

  def top_left_diagonal(row, col)
    row.upto(row + 8) do |r|
      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      col -= 1
    end
  end

  def bottom_right_diagonal(row, col)
    row.downto(row - 8) do |r|
      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      col += 1
    end
  end

  def bottom_left_diagonal(row, col)
    row.downto(row - 8) do |r|
      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      col -= 1
    end
  end
end

