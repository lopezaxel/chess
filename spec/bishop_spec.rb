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
        gameboard.board[1][3] = bishop 

        gameboard.board[0][2] = pawn 
        gameboard.board[0][4] = pawn 
        gameboard.board[3][5] = pawn 
        gameboard.board[3][1] = pawn 

        expect(bishop.moves([0, 2])).to eql(false)
        expect(bishop.moves([4, 6])).to eql(false)
        expect(bishop.moves([0, 4])).to eql(false)
        expect(bishop.moves([4, 0])).to eql(false)
      end
    end
  end

  describe "#top_diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])

    context "bishop in top right diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][6] = bishop
        expect(bishop.top_diagonal(3, 3, "right")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[5][5] = pawn
        expect(bishop.top_diagonal(3, 3, "right")).to eql(false)
      end
    end

    context "bishop in top left diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][0] = bishop
        expect(bishop.top_diagonal(3, 3, "left")).to eql(bishop)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard.board[5][3] = bishop
        expect(bishop.top_diagonal(1, 7, "left")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[5][1] = pawn
        expect(bishop.top_diagonal(3, 3, "left")).to eql(false)
      end
    end

  end

  describe "#bottom_diagonal" do
    context "bishop in bottom right diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 0, 6" do
        gameboard.board[0][6] = bishop
        expect(bishop.bottom_diagonal(3, 3, "right")).to eql(bishop)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard.board[1][7] = bishop
        expect(bishop.bottom_diagonal(5, 3, "right")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[1][5] = pawn
        expect(bishop.bottom_diagonal(3, 3, "right")).to eql(false)
      end
    end

    context "bishop in bottom left diagonal" do
      gameboard = Gameboard.new
      bishop = Bishop.new(gameboard, "white", [6, 6])
      pawn = Pawn.new(gameboard, "white", [5, 5])

      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[0][0] = bishop
        expect(bishop.bottom_diagonal(3, 3, "left")).to eql(bishop)
      end

      it "return false if piece same color before bishop" do
        gameboard.board[1][1] = pawn
        expect(bishop.bottom_diagonal(3, 3, "left")).to eql(false)
      end

      it "if empty diagonal return bishop in 1, 7" do
        gameboard = Gameboard.new
        gameboard.board[1][7] = bishop
        expect(bishop.bottom_diagonal(5, 3, "left")).to eql(false)
      end
    end
  end
end

