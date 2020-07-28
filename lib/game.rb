require './lib/gameboard.rb'
require './lib/queen.rb'
require './lib/rook.rb'
require './lib/bishop.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/king.rb'

class Game
  attr_reader :player_1, :player_2, :gameboard

  def initialize(player_1, player_2, gameboard)
    @player_1 = player_1
    @player_2 = player_2
    @gameboard = gameboard
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

