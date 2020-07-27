require "./lib/bishop.rb"
require "./lib/pawn.rb"
require "./lib/gameboard.rb"

describe "Bishop" do
  describe "#moves" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])

    context "bishop in diagonal" do
      it "return bishop in empty diagonals 5, 3" do
        gameboard.board = gameboard.create_board
        gameboard.board[5][3] = bishop 

        expect(bishop.moves([1, 7])).to eql(bishop)
        expect(bishop.moves([7, 5])).to eql(bishop)
        expect(bishop.moves([2, 0])).to eql(bishop)
        expect(bishop.moves([7, 1])).to eql(bishop)
      end

      it "return bishop in empty diagonals 1, 3" do
        gameboard.board = gameboard.create_board
        gameboard.board[1][3] = bishop 

        expect(bishop.moves([0, 2])).to eql(bishop)
        expect(bishop.moves([4, 6])).to eql(bishop)
        expect(bishop.moves([0, 4])).to eql(bishop)
        expect(bishop.moves([4, 0])).to eql(bishop)
      end

      it "return false when pieces before bishop 1, 3" do
        gameboard.board = gameboard.create_board
        gameboard.board[2][4] = bishop 

        gameboard.board[1][3] = pawn 
        gameboard.board[1][5] = pawn 
        gameboard.board[3][5] = pawn 
        gameboard.board[3][3] = pawn 

        expect(bishop.moves([0, 2])).to eql(false)
        expect(bishop.moves([4, 6])).to eql(false)
        expect(bishop.moves([0, 6])).to eql(false)
        expect(bishop.moves([4, 4])).to eql(false)
      end

      context "when bishop is a piece of another color" do
        gameboard = Gameboard.new
        pawn = Pawn.new(gameboard, "black", [2, 5])
        bishop = Bishop.new(gameboard, "white", [6, 1])

        it "return bishop when pawn at 2, 5" do
          gameboard.board[2][5] = pawn
          gameboard.board[6][1] = bishop
          expect(bishop.moves([2, 5])).to eql(bishop)
        end

        it "return bishop when pawn at 6, 1" do
          gameboard = Gameboard.new
          pawn = Pawn.new(gameboard, "black", [6, 1])
          bishop = Bishop.new(gameboard, "white", [1, 6])

          gameboard.board[6][1] = pawn
          gameboard.board[1][6] = bishop
          expect(bishop.moves([6, 1])).to eql(bishop)
        end
      end
    end

    context "double bishops" do
      it "return true" do
        gameboard = Gameboard.new
        bishop_1 = Bishop.new(gameboard, "white", [6, 0])
        bishop_2 = Bishop.new(gameboard, "white", [6, 2])
        gameboard.board[6][0] = bishop_1
        gameboard.board[6][2] = bishop_2

        expect(bishop_1.moves([7, 1, 0])).to eql(bishop_1)
        expect(bishop_1.moves([7, 1, 2])).to eql(bishop_2)
      end
    end
  end

  describe "#diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])

    context "bishop in top right diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][6] = bishop
        expect(bishop.diagonal(3, 3, "right", "top")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[5][5] = pawn
        expect(bishop.diagonal(3, 3, "right", "top")).to eql(false)
      end
    end

    context "bishop in top left diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][0] = bishop
        expect(bishop.diagonal(3, 3, "left", "top")).to eql(bishop)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard.board[5][3] = bishop
        expect(bishop.diagonal(1, 7, "left", "top")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[5][1] = pawn
        expect(bishop.diagonal(3, 3, "left", "top")).to eql(false)
      end
    end

    context "bishop in bottom right diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 0, 6" do
        gameboard.board[0][6] = bishop
        expect(bishop.diagonal(3, 3, "right", "bottom")).to eql(bishop)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard.board[1][7] = bishop
        expect(bishop.diagonal(5, 3, "right", "bottom")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[1][5] = pawn
        expect(bishop.diagonal(3, 3, "right", "bottom")).to eql(false)
      end
    end

    context "bishop in bottom left diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[0][0] = bishop
        expect(bishop.diagonal(3, 3, "left", "bottom")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[1][1] = pawn
        expect(bishop.diagonal(3, 3, "left", "bottom")).to eql(false)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard = Gameboard.new
        bishop = Bishop.new(gameboard, "white", [6, 6])
        pawn = Pawn.new(gameboard, "white", [5, 5])

        gameboard.board[1][7] = bishop
        expect(bishop.diagonal(5, 3, "left", "bottom")).to eql(false)
      end
    end
  end
end

