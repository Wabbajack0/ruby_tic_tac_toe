class Board
  attr_accessor :player1, :player2
  require_relative "square"

  def initialize
    @board = [[], [], []]
    for i in 0..2
      for j in 0..2
        @board[i][j] = Square.new(0)
      end
    end
    puts "Add Player 1 name:"
    @player1 = gets.chomp.upcase
    puts "Add Player 2 name:"
    @player2 = gets.chomp.upcase
  end

  def play
    count = 0
    while win_check == 0 && count < 9
      print_board
      if count % 2 == 0
        i, j = ask_coordinates(@player1)
        @board[i][j].value = 1
      else
        i, j = ask_coordinates(@player2)
        @board[i][j].value = -1
      end
      count += 1
    end
    print_board
    if count == 9
      puts "draw"
    elsif count % 2 == 0
      puts "#{@player2} won"
    else
      puts "#{@player1} won"
    end
  end

  private

  def ask_coordinates(player)
      puts "#{player} pick a square"
      str = ""
      while !str.match?(/[1-3],[1-3]/)
        puts "Add x and y coordinates separated by a comma (no spaces)"
        str = gets.chomp
      end
      i = str[0].to_i - 1
      j = str[2].to_i - 1
      if @board[i][j].value != 0
        puts "This square has already been picked, pick another"
        i, j = ask_coordinates(player)
      end
      return i, j
  end

  def print_board
    puts "\n  1.   2.   3."
    for i in 0..2
      temp = []
      @board[i].each_with_index do |square,index|
        case square.value
        when 0 then temp[index] = " "
        when 1 then temp[index] = "X"
        when -1 then temp[index] = "O"
        end
      end
      puts "#{i+1}. " + temp.join(" | ")
    end
  end

  def win_check
    sum2 = 0
    sum3 = 0
    for i in 0..2
      sum1 = 0
      @board[i].each { |square| sum1 += square.value }
      sum2 += @board[i][i].value
      sum3 += @board[i][2-i].value
      if sum1 == 3 || sum2 == 3 || sum3 == 3
        return 1
      elsif sum1 == -3 || sum2 == -3 || sum3 == -3
        return -1
      end
    end
    return 0
  end
end
