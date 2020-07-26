require './lib/knight.rb'
require './lib/gameboard.rb'

describe "Knight" do
  describe "#moves" do
    gameboard = Gameboard.new
    knight_one = Knight.new(gameboard, "white", [3, 7])
    knight_two = Knight.new(gameboard, "white", [7, 7])

    it "return correct knight" do
      gameboard.board[3][7] = knight_one
      expect(knight_one.moves([5, 6])).to eql(knight_one)
    end

    it "return false when no knight there" do
      expect(knight_one.moves([7, 0])).to eql(false)
    end

    context "when 2 knights" do
      it "return correct knight when same column" do
        gameboard.board[3][7] = knight_one
        gameboard.board[7][7] = knight_two
        expect(knight_one.moves([5, 6, 3])).to eql(knight_one)
        expect(knight_one.moves([5, 6, 7])).to eql(knight_two)
      end

      it "return correct knight when same row" do
        gameboard.board[7][5] = knight_one
        gameboard.board[7][3] = knight_two
        knight_one.position = [7, 5]
        knight_two.position = [7, 3]

        expect(knight_one.moves([5, 4, 5])).to eql(knight_one)
      end
    end
  end

  describe "#possible_moves" do
    gameboard = Gameboard.new
    knight = Knight.new(gameboard, "white", [0, 1])

    it "returns [[1, 2], [2, 1]] when [0, 0]" do
      moves = knight.possible_moves([0, 0])
      expect(moves).to eql([[1, 2], [2, 1]])
    end

    it "returns correct moves when [2, 5]" do
      moves = knight.possible_moves([2, 5])
      expected_moves = [[0, 4], [0, 6], [1, 3], [1, 7], [3, 3], [3, 7], 
                       [4, 4], [4, 6]]
      expect(moves).to eql(expected_moves)
    end
  end

  describe "#possible_knights" do
    gameboard = Gameboard.new
    knight_one = Knight.new(gameboard, "white", [0, 4])
    knight_two = Knight.new(gameboard, "white", [4, 6])

    it "return knight if knight in moves of [2, 5]" do
      gameboard.board[0][4] = knight_one
      moves = knight_one.possible_moves([2, 5])
      expect(knight_one.possible_knights(moves)).to eql([knight_one])
    end

    it "return 2 knights if two knight in moves of [2, 5]" do
      gameboard.board[0][4] = knight_one
      gameboard.board[4][6] = knight_two
      moves = knight_one.possible_moves([2, 5])
      expect(knight_one.possible_knights(moves)).to eql([knight_one, knight_two])
    end
  end
end

