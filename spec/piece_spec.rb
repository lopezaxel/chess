require "./lib/gameboard.rb"
require "./lib/piece.rb"

describe "Piece" do
  describe "#disambiguation" do
    gameboard = Gameboard.new
    piece_one = Piece.new(gameboard, "black", [2, 7])
    piece_two = Piece.new(gameboard, "black", [6, 7])


    context "when 2 pieces" do
      it "return correct piece if same column" do
        piece = piece_one.disambiguation([piece_one, piece_two], 6)
        expect(piece).to be(piece_two)
      end

      it "return correct piece if same row" do
        piece_one.position = [4, 4]
        piece_two.position = [4, 6]
        piece = piece_one.disambiguation([piece_one, piece_two], 6)
        expect(piece).to be(piece_two)
      end
    end
  end
end

