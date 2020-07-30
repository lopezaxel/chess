require './lib/gameboard'
require './lib/player'
require './lib/queen'
require './lib/rook'
require './lib/bishop'
require './lib/knight'
require './lib/pawn'
require './lib/king'

class Game
  attr_reader :player_1, :player_2, :gameboard
  attr_accessor :checkmate

  def initialize(gameboard, player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @gameboard = gameboard
    @checkmate = false
  end

  def start_game
    fill_board
    puts gameboard.display_board

    until checkmate
      player_turn(player_1)
      player_turn(player_2)
    end
  end

  def player_turn(player)
    player_move = player.input
    move = convert_move(player_move)

    if is_move_a_pawn?(player_move)
      pawn = Pawn.new(gameboard, player.color, [0, 0])
      if is_a_promotion_move?(player_move)
        piece = promotion(move, player.color)
        move.pop
      else          
        pawn.moves(move)
      end
    elsif is_move_a_knight?(player_move)
      knight = Knight.new(gameboard, player.color, [0, 0])
      piece = knight.moves(move)
    elsif is_move_a_bishop?(player_move)
      bishop = Bishop.new(gameboard, player.color, [0, 0])
      piece = bishop.moves(move)
    elsif is_move_a_rook?(player_move)
      rook = Rook.new(gameboard, player.color, [0, 0])
      piece = rook.moves(move)
    elsif is_move_a_queen?(player_move)
      queen = Queen.new(gameboard, player.color, [0, 0])
      piece = queen.moves(move)
    elsif is_move_a_king?(player_move)
      king = King.new(gameboard, player.color, [0, 0])
      piece = king.moves(move)
    end

    write_move(piece, move[-2..-1])
    change_piece_position(piece, move[-2..-1])

    puts gameboard.display_board
  end

  def write_move(piece, square)
    p piece.class, square
    row = square[0]
    col = square[1]
    piece_row = piece.position[0]
    piece_col = piece.position[1]

    equal = [row,col] == [piece_row,piece_col]

    gameboard.board[row][col] = piece
    gameboard.board[piece_row][piece_col] = " " unless equal
  end

  def change_piece_position(piece, square)
    piece.position = square
  end

  def fill_board
    gameboard.board.each_with_index do |row, row_idx|
      row.each_index do |col|
        piece = case row_idx
                when 0
                  fill_pieces_row(row_idx, col, "white")
                when 1
                  fill_pawn_row(row_idx, col, "white")
                when 6
                  fill_pawn_row(row_idx, col, "black")
                when 7
                  fill_pieces_row(row_idx, col, "black")
                else
                  " "
                end

        gameboard.board[row_idx][col] = piece
      end
    end
  end

  def fill_pawn_row(row, col, color)
    Pawn.new(gameboard, color, [row, col])
  end

  def fill_pieces_row(row, col, color)
    case col
    when 0, 7
      Rook.new(gameboard, color, [row, col])
    when 1, 6
      Knight.new(gameboard, color, [row, col])
    when 2, 5
      Bishop.new(gameboard, color, [row, col])
    when 3
      Queen.new(gameboard, color, [row, col])
    when 4
      King.new(gameboard, color, [row, col])
    end
  end

  def square_is_supported(square, color)
    queen = Queen.new(gameboard, color, [0, 0])
    rook = Rook.new(gameboard, color, [0, 0])
    bishop = Bishop.new(gameboard, color, [0, 0])
    knight = Knight.new(gameboard, color, [0, 0])
    pawn = Pawn.new(gameboard, color, [0, 0])
    king = King.new(gameboard, color, [0, 0])

    if queen.moves(square) || rook.moves(square) || bishop.moves(square) ||
      knight.moves(square) || king.moves(square) || pawn.support_moves(square)
      true
    else
      false
    end
  end
  
  def convert_move(move)
    if is_a_file?(move[0])
      convert_pawn_move(move)
    elsif is_a_disambiguating_move?(move)
      final_move = convert_pawn_move(move[-2..-1])
      final_move << convert_rank_or_file(move[1])
    elsif is_a_piece?(move[0])
      convert_pawn_move(move[-2..-1])
    end
  end

  def convert_rank_or_file(letter)
    if is_a_rank?(letter)
      rank_to_number(letter)
    elsif is_a_file?(letter)
      file_to_number(letter)
    end
  end

  def convert_pawn_move(move)
    if is_a_pawn_attack_move?(move) 
      file_1 = file_to_number(move[0])
      file_2 = file_to_number(move[2])
      rank = rank_to_number(move[3])

      [file_1, rank, file_2]
    elsif is_a_promotion_move?(move)
      file = file_to_number(move[0])
      rank = rank_to_number(move[1])
      piece_letter = move[3]

      [rank, file, piece_letter]
    else#if is_a_pawn_move?(move)
      file = file_to_number(move[0])
      rank = rank_to_number(move[1])

      [rank, file]
    end
  end

  def promotion(move, color)
    row = move[0]
    col = move[1]
    piece_letter = move[2]
    square = gameboard.board[row][col]

    return false unless square.is_a?(Pawn)

    if color == "white" && row == gameboard.board_size || 
        color == "black" && row == 0
      return promote(piece_letter, color)
    else
      false
    end
  end

  def promote(letter, color)
    case letter
    when "Q"
      Queen.new(gameboard, color, [0, 0])
    when "R"
      Rook.new(gameboard, color, [0, 0])
    when "B"
      Bishop.new(gameboard, color, [0, 0])
    when "N"
      Knight.new(gameboard, color, [0, 0])
    end
  end


  def rank_to_number(rank)
    rank.to_i - 1
  end

  def file_to_number(file)
    file.ord - 97
  end

  def is_a_disambiguating_move?(move)
    is_a_special_piece?(move[0]) && move.size >= 4 && 
      (is_a_file?(move[1]) || is_a_rank?(move[1]))
  end

  def is_a_promotion_move?(move)
    is_a_pawn_move?(move[0..1]) && is_an_equals?(move[2]) &&
      is_a_special_piece?(move[3])
  end

  def is_a_pawn_move?(move)
    is_a_file?(move[0]) && is_a_rank?(move[1])
  end

  def is_a_pawn_attack_move?(move)
    is_a_file?(move[0]) && is_a_x?(move[1]) && is_a_pawn_move?(move[2..3])
  end

  def is_a_special_piece?(letter)
    ['N', 'Q', 'R', 'B'].include?(letter)
  end

  def is_a_piece?(letter)
    ['N', 'K', 'Q', 'R', 'B'].include?(letter)
  end

  def is_a_file?(letter)
    ('a'..'h').include?(letter)
  end

  def is_a_rank?(letter)
    ('1'..'8').include?(letter)
  end

  def is_a_x?(letter)
    letter == 'x'
  end

  def is_an_equals?(letter)
    letter == '='
  end

  def is_move_a_knight?(move)
    move[0] == 'N'
  end

  def is_move_a_bishop?(move)
    move[0] == 'B'
  end

  def is_move_a_rook?(move)
    move[0] == 'R'
  end

  def is_move_a_queen?(move)
    move[0] == 'Q'
  end

  def is_move_a_king?(move)
    move[0] == 'K'
  end

  def is_move_a_pawn?(move)
    is_a_file?(move[0])    
  end
end

gameboard = Gameboard.new
player_1 = Player.new('white')
player_2 = Player.new('black')
game = Game.new(gameboard, player_1, player_2)

game.start_game

