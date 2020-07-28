require './lib/king.rb'
require './lib/gameboard.rb'

describe "King" do
  describe "#king_moves" do
    it "can move in horizontal" do
      gameboard = Gameboard.new
      king = King.new(gameboard, "white", [0, 4])
      gameboard.board[0][4] = king

      expect(king.moves([0, 5])).to eql(king)
    end

    it "can move in vertical" do
      gameboard = Gameboard.new
      king = King.new(gameboard, "white", [0, 4])
      gameboard.board[0][4] = king

      expect(king.moves([1, 4])).to eql(king)
    end

    it "can move in diagonal" do
      gameboard = Gameboard.new
      king = King.new(gameboard, "white", [0, 4])
      gameboard.board[0][4] = king

      expect(king.moves([1, 5])).to eql(king)
    end
  end
end

