require './lib/knight.rb'
require './lib/gameboard.rb'

describe "Knight" do
  describe "#moves" do
    gameboard = Gameboard.new
    knight = Knight.new(gameboard, "white", [0, 1])

    it "returns [[1, 2], [2, 1]] when [0, 0]" do
      moves = knight.moves([0, 0])
      expect(moves).to eql([[1, 2], [2, 1]])
    end

    it "returns correct moves when [2, 5]" do
      moves = knight.moves([2, 5])
      expected_moves = [[0, 4], [0, 6], [1, 3], [1, 7], [3, 3], [3, 7], 
                       [4, 4], [4, 6]]
      expect(moves).to eql(expected_moves)
    end
  end
end

