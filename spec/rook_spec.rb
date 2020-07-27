require "./lib/rook.rb"
require "./lib/gameboard.rb"

describe "Rook" do
  describe "#valid_move" do
    context "movement" do
      it "return true with rook at top" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [6, 3])
        gameboard.board[6][3] = rook

        expect(rook.valid_move([2, 3])).to eql(rook)
      end

      it "return true with rook at bottom" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [0, 3])
        gameboard.board[0][3] = rook

        expect(rook.valid_move([3, 3])).to eql(rook)
      end

      it "return true with rook at left" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [5, 5])
        gameboard.board[5][5] = rook

        expect(rook.valid_move([5, 0])).to eql(rook)
      end

      it "return true with rook at right" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [2, 1])
        gameboard.board[2][1] = rook

        expect(rook.valid_move([2, 7])).to eql(rook)
      end
    end

    context "attack moves" do
      it "return true same row" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [7, 7])
        black_rook = Rook.new(gameboard, "black", [7, 3])
        gameboard.board[7][7] = rook
        gameboard.board[7][3] = black_rook

        expect(rook.valid_move([7, 3])).to eql(rook)
      end

      it "return true same column" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [7, 7])
        black_rook = Rook.new(gameboard, "black", [1, 7])
        gameboard.board[7][7] = rook
        gameboard.board[1][7] = black_rook

        expect(rook.valid_move([1, 7])).to eql(rook)
      end
    end

    context "occupied squares" do
      it "return false if piece before row" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [6, 7])
        black_rook = Rook.new(gameboard, "black", [6, 5])
        gameboard.board[6][7] = rook
        gameboard.board[6][5] = black_rook

        expect(rook.valid_move([6, 1])).to eql(false)
      end

      it "return false if piece before column" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [0, 2])
        black_rook = Rook.new(gameboard, "black", [0, 4])
        gameboard.board[0][2] = rook
        gameboard.board[0][4] = black_rook

        expect(rook.valid_move([0, 7])).to eql(false)
      end
    end

    context "two rooks" do
      it "return correct rook" do
        gameboard = Gameboard.new
        rook = Rook.new(gameboard, "white", [2, 0])
        rook_two = Rook.new(gameboard, "white", [2, 7])
        gameboard.board[2][0] = rook
        gameboard.board[2][7] = rook_two

        expect(rook.valid_move([2, 5, 0])).to eql(rook)
      end
    end
  end
end

