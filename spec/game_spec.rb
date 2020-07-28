require './lib/game.rb'
require './lib/gameboard.rb'
require './lib/queen.rb'
require './lib/rook.rb'
require './lib/bishop.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/king.rb'

describe "Game" do
  describe "square_is_supported" do
    context "when square is supported" do
      it "return true with a pawn" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Pawn.new(gameboard, "white", [1, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([2, 2], "white")).to eql(true)
      end

      it "return true with a knight" do
        gameboard = Gameboard.new
        gameboard.board[2][1] = Knight.new(gameboard, "white", [2, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([4, 2], "white")).to eql(true)
      end

      it "return true with a bishop" do
        gameboard = Gameboard.new
        gameboard.board[0][2] = Bishop.new(gameboard, "white", [0, 2])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([5, 7], "white")).to eql(true)
      end

      it "return true with a queen" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Queen.new(gameboard, "white", [1, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([7, 1], "white")).to eql(true)
      end

      it "return true with a rook" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Rook.new(gameboard, "white", [1, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([1, 7], "white")).to eql(true)
      end

      it "return true with a king" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = King.new(gameboard, "white", [1, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([2, 2], "white")).to eql(true)
      end

      it "return false when black pawn" do
        gameboard = Gameboard.new
        gameboard.board[6][1] = Pawn.new(gameboard, "black", [6, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([5, 2], "white")).to eql(false)
      end

      it "return false when black queen" do
        gameboard = Gameboard.new
        gameboard.board[6][1] = Queen.new(gameboard, "black", [6, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([5, 2], "white")).to eql(false)
      end
    end

    context "when square is not supported" do
      it "return false when pawn besides" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Pawn.new(gameboard, "white", [1, 1])
        game = Game.new(1, 1, gameboard)

        expect(game.square_is_supported([1, 2], "white")).to eql(false)
      end
    end
  end
end
