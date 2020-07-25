require "./lib/bishop.rb"
require "./lib/pawn.rb"
require "./lib/gameboard.rb"

describe "Bishop" do
  describe "#top_right_diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])
    black_bishop = Bishop.new(gameboard, "black", [5, 5])


    context "bishop in diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][6] = bishop
        expect(bishop.top_right_diagonal(3, 3)).to eql(bishop)
      end

      it "return false if piece before bishop" do
        gameboard.board[5][5] = pawn
        expect(bishop.top_right_diagonal(3, 3)).to eql(false)

        gameboard.board[5][5] = black_bishop
        expect(bishop.top_right_diagonal(3, 3)).to eql(false)
      end
    end
  end

  describe "#top_left_diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])


    context "bishop in diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[6][0] = bishop
        expect(bishop.top_left_diagonal(3, 3)).to eql(bishop)
      end

      it "return false if piece before bishop" do
        gameboard.board[5][1] = pawn
        expect(bishop.top_left_diagonal(3, 3)).to eql(false)
      end
    end
  end

  describe "#bottom_right_diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])


    context "bishop in diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[0][6] = bishop
        expect(bishop.bottom_right_diagonal(3, 3)).to eql(bishop)
      end

      it "return false if piece before bishop" do
        gameboard.board[1][5] = pawn
        expect(bishop.bottom_right_diagonal(3, 3)).to eql(false)
      end
    end
  end

  describe "#bottom_left_diagonal" do
    gameboard = Gameboard.new
    bishop = Bishop.new(gameboard, "white", [6, 6])
    pawn = Pawn.new(gameboard, "white", [5, 5])


    context "bishop in diagonal" do
      it "if empty diagonal return bishop in 6, 6" do
        gameboard.board[0][0] = bishop
        expect(bishop.bottom_left_diagonal(3, 3)).to eql(bishop)
      end

      it "return false if piece before bishop" do
        gameboard.board[1][1] = pawn
        expect(bishop.bottom_left_diagonal(3, 3)).to eql(false)
      end
    end
  end
end
