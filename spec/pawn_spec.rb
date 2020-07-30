require './lib/gameboard.rb'

describe "Pawn" do
  describe "#moves" do
    gameboard = Gameboard.new
    pawn_one = Pawn.new(gameboard, "white", [2, 2])
    pawn_two = Pawn.new(gameboard, "white", [1, 2])
    pawn_black = Pawn.new(gameboard, "black", [2, 2])

    it "return pawn 1 square below if pawn same color below" do
      gameboard.board[2][2] = pawn_one
      expect(pawn_one.moves([3, 2])).to eql(pawn_one)

      gameboard.board[2][2] = pawn_black
      expect(pawn_black.moves([1, 2])).to eql(pawn_black)
    end

    it "return pawn 1 square below if pawn same color below" do
      gameboard.board[1][4] = pawn_one
      expect(pawn_one.moves([2, 4])).to eql(pawn_one)
    end

    context "2 squares below pawn same color" do
      it "return pawn if it hasn't moved" do
        gameboard.board[2][2] = " "
        gameboard.board[1][2] = pawn_two
        expect(pawn_one.moves([3, 2])).to eql(pawn_two)

        gameboard.board[6][7] = pawn_black
        expect(pawn_black.moves([4, 7])).to eql(pawn_black)
      end

      it "return false if pawn has moved" do
        gameboard.board[1][2].initial_position = [0, 0]
        expect(pawn_one.moves([3, 2])).to eql(false)

        gameboard.board[6][7].initial_position = [7, 7]
        expect(pawn_one.moves([4, 7])).to eql(false)
      end
    end
    
    it "return false if 1 square below no pawn" do
      gameboard.board[1][2] = " "
      gameboard.board[2][2] = " "
      expect(pawn_one.moves([3, 2])).to eql(false)

      gameboard.board[6][7] = " "
      gameboard.board[5][7] = " "
      expect(pawn_one.moves([4, 7])).to eql(false)
    end

    context "1 square below pawn other color" do
      it "return false" do
        gameboard.board[2][2] = pawn_black
        expect(pawn_one.moves([3, 2])).to eql(false)

        gameboard.board[5][7] = pawn_one
        expect(pawn_black.moves([4, 7])).to eql(false)
      end

      it "return false if 2 squares below pawn same color" do
        gameboard.board[2][2] = " "
        gameboard.board[1][2] = pawn_two
        expect(pawn_one.moves([3, 2])).to eql(false)

        gameboard.board[5][7] = " "
        gameboard.board[6][7] = pawn_two
        expect(pawn_one.moves([4, 7])).to eql(false)
      end
    end
  end

  describe "#attack_moves" do
    gameboard = Gameboard.new
    piece = Pawn.new(gameboard, "white", [4, 5])
    pawn = Pawn.new(gameboard, "black", [3, 4])

    context "pawn attacks piece" do
      it "return pawn" do
        gameboard.board[3][3] = piece
        gameboard.board[4][4] = pawn
        expect(pawn.attack_moves([4, 3, 3])).to eql(pawn)

        gameboard = Gameboard.new
        piece = Pawn.new(gameboard, "white", [5, 4])
        pawn = Pawn.new(gameboard, "black", [6, 5])
        gameboard.board[5][4] = piece
        gameboard.board[6][5] = pawn
        expect(pawn.attack_moves([5, 5, 4])).to eql(pawn)
      end

      it "return false if same color" do
        gameboard.board[6][6] = pawn
        gameboard.board[5][7] = pawn
        expect(pawn.attack_moves([1, 3, 2])).to eql(false)
      end

      it "return false if empty attacked square" do
        gameboard.board[2][4] = " "
        gameboard.board[1][3] = pawn
        expect(pawn.attack_moves([1, 3, 2])).to eql(false)
      end
    end
  end
end

