require "./lib/piece.rb"
require 'pry'

class Bishop < Piece
  def initialize(gameboard, color, position)
    super(gameboard, color, position)
  end

  def is_a_bishop?(piece)
    piece.class == Bishop
  end

  def moves(move)
    bishops = diagonals(move)
    disambiguate(bishops, move)
  end

  def diagonals(move)
    row = move[0]
    col = move[1]
    bishops = []

    bishops << top_diagonal(row, col, "right")
    bishops << top_diagonal(row, col, "left")
    bishops << bottom_diagonal(row, col, "right")
    bishops << bottom_diagonal(row, col, "left")

    bishops.keep_if { |b| b != false }
  end

  def top_diagonal(row, col, direction)
    row.upto(row + 8) do |r|
      return false unless gameboard.inside_board?([r, col])

      square = gameboard.board[r][col]

      if is_a_bishop?(square) && same_color?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      case direction
      when "left"
        col -= 1
      when "right"
        col += 1
      end
    end
  end

  def bottom_diagonal(row, col, direction)
    row.downto(row - 8) do |r|
      return false unless gameboard.inside_board?([r, col])

      square = gameboard.board[r][col]

      if valid_bishop?(square)
        return square
      elsif !is_empty?(square)
        return false
      end

      case direction
      when "right"
        col += 1
      when "left"
        col -= 1
      end
    end
  end

  def valid_bishop?(square)
    is_a_bishop?(square) && same_color?(square)
  end
end

