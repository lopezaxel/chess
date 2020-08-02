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
    set_players_king(player_1, player_2)
    puts gameboard.display_board

    until checkmate
      player_turn(player_1)
      break if checkmate
      player_turn(player_2)
    end
  end

  def player_turn(player)
    loop do
      king_is_in_check(player)
      if player.king_in_check
        check_if_checkmate(player)
        break if checkmate
      end

      player_move = player.input
      move = convert_move(player_move)

      piece = check_valid_move(move, player_move, player.color)

      next if piece == false 

      before_piece = gameboard.board[move[-2]][move[-1]]
      before_position = piece.position

      write_move(piece, move[-2..-1])
      change_piece_position(piece, move[-2..-1])

      king_is_in_check(player)
      if player.king_in_check
        undo_move(piece, before_piece, before_position, move[-2..-1])
        next
      end

      puts gameboard.display_board

      break
    end
  end

  def check_if_checkmate(player)
    pieces = player_pieces(player)
    no_moves = true

    pieces.each do |piece|
      legal_moves(piece).each do |move|
        next unless gameboard.inside_board?(move)

        before_piece = gameboard.board[move[0]][move[1]]
        before_position = piece.position

        write_move(piece, move)
        change_piece_position(piece, move) 

        king_is_in_check(player)
        unless player.king_in_check
          no_moves = false
        end

        undo_move(piece, before_piece, before_position, move)
      end
    end

    self.checkmate = true if no_moves
  end

  def legal_moves(piece)
    legal_moves = piece.legal_moves
    if piece.class == King
      legal_moves.delete_if do |square|
        square_is_supported(square, piece.contrary_color)
      end
    end

    legal_moves
  end

  def player_pieces(player)
    pieces = []

    gameboard.board.each do |row|
      row.each do |square|
        next unless !square.is_a?(String) && square.color == player.color

        pieces << square 
      end
    end

    pieces
  end

  def undo_move(piece, before_piece, before_position, move)
    #require 'pry';binding.pry if gameboard.board[3][4].class == Knight
    write_move(before_piece, move)
    change_piece_position(piece, before_position)
    write_move(piece, before_position)
  end

  def write_move(piece, square)
    row = square[0]
    col = square[1]
    gameboard.board[row][col] = piece

    return if piece.is_a?(String) || piece.is_a?(Array) || piece.nil? ||
      piece.position == square

    piece_row = piece.position[0]
    piece_col = piece.position[1]
    gameboard.board[piece_row][piece_col] = " "
  end

  def king_is_in_check(player)
    enemy_color = enemy_color(player.color)
    player_king = player.king.position
    if square_is_supported(player_king, enemy_color)
      player.king_in_check = true
    else
      player.king_in_check = false
    end
  end

  def give_king_to_player(player)
    king = case player.color
           when "white"
             gameboard.board[0][4]
           when "black"
             gameboard.board[7][4]
           end
    player.king = king
  end

  def set_players_king(player_1, player_2)
    give_king_to_player(player_1)
    give_king_to_player(player_2)
  end

  def check_valid_move(move, player_move, color)
    if is_move_a_pawn?(player_move)
      piece = Pawn.new(gameboard, color, [0, 0])
      if is_a_promotion_move?(player_move)
        piece = promotion(move, color)
        move.pop

        return piece
      end
    elsif is_move_a_knight?(player_move)
      piece = Knight.new(gameboard, color, [0, 0])
    elsif is_move_a_bishop?(player_move)
      piece = Bishop.new(gameboard, color, [0, 0])
    elsif is_move_a_rook?(player_move)
      piece = Rook.new(gameboard, color, [0, 0])
    elsif is_move_a_queen?(player_move)
      piece = Queen.new(gameboard, color, [0, 0])
    elsif is_move_a_king?(player_move)
      piece = King.new(gameboard, color, [0, 0])
    else
      return false
    end

    piece.moves(move)
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
    else
      file = file_to_number(move[0])
      rank = rank_to_number(move[1])

      [rank, file]
    end
  end

  def promotion(move, color)
    p = Pawn.new(gameboard, color, [0, 0])

    row = move[0]
    col = move[1]
    piece_letter = move[2]

    return false unless gameboard.board[row+p.direction][col].class == Pawn

    if color == "white" && row == 7 || color == "black" && row == 0
      promote(piece_letter, color, [row + p.direction, col])
    else
      false
    end
  end

  def promote(letter, color, position)
    case letter
    when "Q"
      Queen.new(gameboard, color, position)
    when "R"
      Rook.new(gameboard, color, position)
    when "B"
      Bishop.new(gameboard, color, position)
    when "N"
      Knight.new(gameboard, color, position)
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

  def enemy_color(color)
    if color == "white"
      "black"
    else
      "white"
    end
  end
end

gameboard = Gameboard.new
player_1 = Player.new('white')
player_2 = Player.new('black')
game = Game.new(gameboard, player_1, player_2)

game.start_game

