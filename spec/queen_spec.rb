require './lib/queen.rb'
require './lib/gameboard.rb'

describe "Queen" do
  describe "#moves" do
    context "rook movement" do
      it "return queen with queen at top" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [6, 3])
        gameboard.board[6][3] = queen

        expect(queen.moves([2, 3])).to eql(queen)
      end

      it "return queen with queen at bottom" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [0, 3])
        gameboard.board[0][3] = queen

        expect(queen.moves([3, 3])).to eql(queen)
      end

      it "return queen with queen at left" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [5, 5])
        gameboard.board[5][5] = queen

        expect(queen.moves([5, 0])).to eql(queen)
      end

      it "return queen with queen at right" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [2, 1])
        gameboard.board[2][1] = queen

        expect(queen.moves([2, 7])).to eql(queen)
      end
    end

    context "bishop movement" do
      it "return queen in right diagonal" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [3, 3])
        gameboard.board[3][3] = queen

        expect(queen.moves([6, 6])).to eql(queen)
      end

      it "return queen in left diagonal" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [3, 3])
        gameboard.board[3][3] = queen

        expect(queen.moves([6, 0])).to eql(queen)
      end
    end

    context "attack moves" do
      it "return queen same row" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [7, 7])
        black_queen = Queen.new(gameboard, "black", [7, 3])
        gameboard.board[7][7] = queen
        gameboard.board[7][3] = black_queen

        expect(queen.moves([7, 3])).to eql(queen)
      end

      it "return queen same column" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [7, 7])
        black_queen = Queen.new(gameboard, "black", [1, 7])
        gameboard.board[7][7] = queen
        gameboard.board[1][7] = black_queen

        expect(queen.moves([1, 7])).to eql(queen)
      end

      it "return queen same diagonal" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [7, 7])
        black_queen = Queen.new(gameboard, "black", [4, 4])
        gameboard.board[7][7] = queen
        gameboard.board[4][4] = black_queen

        expect(queen.moves([4, 4])).to eql(queen)
      end
    end

    context "occupied squares" do
      it "return false if piece before row" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [6, 7])
        black_queen = Queen.new(gameboard, "black", [6, 5])
        gameboard.board[6][7] = queen
        gameboard.board[6][5] = black_queen

        expect(queen.moves([6, 1])).to eql(false)
      end

      it "return false if piece before column" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [0, 2])
        black_queen = Queen.new(gameboard, "black", [0, 4])
        gameboard.board[0][2] = queen
        gameboard.board[0][4] = black_queen

        expect(queen.moves([0, 7])).to eql(false)
      end

      it "return false if piece before diagonal" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [0, 2])
        black_queen = Queen.new(gameboard, "black", [2, 4])
        gameboard.board[0][2] = queen
        gameboard.board[2][4] = black_queen

        expect(queen.moves([4, 6])).to eql(false)
      end
    end

    context "two queens" do
      it "return correct queen in column" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [2, 0])
        queen_two = Queen.new(gameboard, "white", [2, 7])
        gameboard.board[2][0] = queen
        gameboard.board[2][7] = queen_two

        expect(queen.moves([2, 5, 0])).to eql(queen)
      end

      it "return correct queen in diagonal" do
        gameboard = Gameboard.new
        queen = Queen.new(gameboard, "white", [2, 0])
        queen_two = Queen.new(gameboard, "white", [7, 5])
        gameboard.board[2][0] = queen
        gameboard.board[7][5] = queen_two

        expect(queen.moves([7, 0, 0])).to eql(queen)
      end
    end
  end
end

