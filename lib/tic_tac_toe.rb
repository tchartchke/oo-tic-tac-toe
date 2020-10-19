class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8],
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n#{"-"*11}\n #{board[3]} | #{board[4]} | #{board[5]} \n#{"-"*11}\n #{board[6]} | #{board[7]} | #{board[8]} \n"
  end

  def input_to_index(input)
    input = input.to_i - 1
  end

  def move(index, token = "X")
    self.board[index] = token
  end

  def position_taken?(index)
    self.board[index] == " " ? false : true
  end

  def valid_move?(index)
    index.between?(0,9) && !position_taken?(index)
  end

  def turn_count
    9 - self.board.select {|item| item == " "}.size
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Enter location to make move: "
    input = gets.strip
    index = input_to_index(input)
    while !valid_move?(index)
      puts "Invalid move. Please try again: "
      input = gets.strip
      index = input_to_index(input)
    end
    move(index, current_player)
    display_board
  end

  def won?
    WIN_COMBINATIONS.each do |combo|

      first_pos = self.board[combo[0]]
      second_pos = self.board[combo[1]]
      third_pos = self.board[combo[2]]

      return combo if (first_pos == second_pos && first_pos == third_pos && first_pos != " ")
    end
    return false
  end

  def draw?
    full? && !won?
  end

  def full?
    !self.board.include?(" ")
  end

  def over?
    draw? || won?
  end

  def winner
    return nil if !won?
    turn_count.odd? ? "X" : "O"
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end