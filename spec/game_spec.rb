require './lib/game.rb'
require './lib/gameboard.rb'
require './lib/queen.rb'
require './lib/rook.rb'
require './lib/bishop.rb'
require './lib/knight.rb'
require './lib/pawn.rb'
require './lib/king.rb'

describe "Game" do
  describe "#square_is_supported" do
    context "when square is supported" do
      it "return true with a pawn" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Pawn.new(gameboard, "white", [1, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([2, 2], "white")).to eql(true)
      end

      it "return true with a knight" do
        gameboard = Gameboard.new
        gameboard.board[2][1] = Knight.new(gameboard, "white", [2, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([4, 2], "white")).to eql(true)
      end

      it "return true with a bishop" do
        gameboard = Gameboard.new
        gameboard.board[0][2] = Bishop.new(gameboard, "white", [0, 2])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([5, 7], "white")).to eql(true)
      end

      it "return true with a queen" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Queen.new(gameboard, "white", [1, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([7, 1], "white")).to eql(true)
      end

      it "return true with a rook" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Rook.new(gameboard, "white", [1, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([1, 7], "white")).to eql(true)
      end

      it "return true with a king" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = King.new(gameboard, "white", [1, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([2, 2], "white")).to eql(true)
      end

      it "return false when black pawn" do
        gameboard = Gameboard.new
        gameboard.board[6][1] = Pawn.new(gameboard, "black", [6, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([5, 2], "white")).to eql(false)
      end

      it "return false when black queen" do
        gameboard = Gameboard.new
        gameboard.board[6][1] = Queen.new(gameboard, "black", [6, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([5, 2], "white")).to eql(false)
      end
    end

    context "when square is not supported" do
      it "return false when pawn besides" do
        gameboard = Gameboard.new
        gameboard.board[1][1] = Pawn.new(gameboard, "white", [1, 1])
        game = Game.new(gameboard, 1, 1)

        expect(game.square_is_supported([1, 2], "white")).to eql(false)
      end
    end
  end

  describe "#convert_move" do
    context "when pawn" do
      it "return correct move when a pawn move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('e4')).to eql([3, 4])
      end

      it "return correct move when a pawn attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('fxg6')).to eql([5, 5, 6])
      end
    end

    context "when queen" do
      it "return correct move when move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Qa4')).to eql([3, 0])
      end

      it "return correct move when attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Qxb5')).to eql([4, 1])
      end
    end

    context "when rook" do
      it "return correct move when move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Re4')).to eql([3, 4])
      end

      it "return correct move when attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Rxg6')).to eql([5, 6])
      end

      it "return correct move when disambiguating attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Raxg6')).to eql([5, 6, 0])
      end
    end

    context "when knight" do
      it "return correct move when move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Ne4')).to eql([3, 4])
      end

      it "return correct move when attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Nxh4')).to eql([3, 7])
      end

      it "return correct move when disambiguating attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('N2xh4')).to eql([3, 7, 1])
      end

      it "return correct move when disambiguating move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Ncg4')).to eql([3, 6, 2])
      end
    end

    context "when bishop" do
      it "return correct move when move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Ba8')).to eql([7, 0])
      end

      it "return correct move when attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Bxc3')).to eql([2, 2])
      end

      it "return correct move when disambiguating move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Bbh8')).to eql([7, 7, 1])
      end
    end

    context "when king" do
      it "return correct move pawn move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Ke2')).to eql([1, 4])
      end

      it "return correct move when attack move" do
        game = Game.new(Gameboard.new, 1, 1)
        expect(game.convert_move('Kxd4')).to eql([3, 3])
      end
    end
  end

  context "#promotion" do
    it "return correct piece" do
      game = Game.new(Gameboard.new, 1, 1)
<<<<<<< HEAD
      game.gameboard.board[6][6] = Pawn.new(game.gameboard, "white", [6, 6])
=======
      game.gameboard.board[7][6] = Pawn.new(game.gameboard, "white", [7, 6])
>>>>>>> 6f8a5737011eb708424eaba76bac4e5600e8e22c
      expect(game.promotion([7, 6, "R"], "white").class).to eql(Rook)
    end
  end
end

