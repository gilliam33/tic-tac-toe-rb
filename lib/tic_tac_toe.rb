require "pry"
def play(board)
  #  binding.pry
    until over?(board)  
   #     binding.pry
        turn(board)   
    end
     
end

def turn(board)

    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(board, index)
        move(board, index, "X")
        display_board(board)
    else 
        turn(board)
    end
end
WIN_COMBINATIONS = [
  
    [0,1,2], #Top_Row_Win
    [3,4,5], #Middle_Across_Win
    [0,3,6], #Left_Down_Win 
    [2,5,8], #Left_Down_Win
    [6,7,8], #Bottom_Row_Win
    [0,4,8], #Right_Diagonal_Win
    [1,4,7], #Middle_Down_Win
    [2,4,6] #Middle_Down_Left
  ]


def won?(board)
    WIN_COMBINATIONS.each do |combination|
      p1 = board[combination[0]]
      p2 = board[combination[1]]
      p3 = board[combination[2]]
      
      if position_taken?(board, combination[0]) && p1 == p2 && p2 == p3
        return combination
      end
    end
    false
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end


def turn_count(board)
    count = 0
    board.each {|i| if i.casecmp?("x") || i.casecmp?("o")
        count += 1
    end
    }
    count
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
  
def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, current_player)
    board[index] = current_player
end

def position_taken?(board, location)
    board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

def full?(board)
    board.each do |index|
      if index != " "  
       true
      else
        return false
      end
    end
end

def draw?(board) 
    full?(board) && !won?(board)
end
  
def over?(board)
    won?(board) || draw?(board)
end
  
def winner(board)
    if over?(board) 
      combination = won?(board)
      board[combination.first]
    else
      nil 
    end
end
  
