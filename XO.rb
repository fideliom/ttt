module StartTheGame

	def self.display_intro
	puts "*****************************************************************"	
	puts "* Welcome to the tic-tac-toe game!                              *"
	puts "* Of course you know all the rules                              *"
	puts "* So no need to list those.                                     *"
	puts "* To put your choice ('X' or 'O') on the board:                 *"
	puts "* Enter the line and column number that correspond to the spot. *"
	puts "* For example : line 1, column 2                                *"
	puts "* Fills the spot in the first line, second column.              *"
	puts "* Okay, let's start the game!                                   *"
	puts "* The 1st player gets X, and 2nd gets (you guessed it) O.       *"
	puts "*****************************************************************"
	end

	def self.get_name_of(str)
		print " =>Please enter the #{str}'s name: "
		gets.chomp.capitalize
	end


end

module RulesOfTheGame

	def get_number
		n = gets.chomp.to_i
		while (!(n.between?(1, 3)))
			puts " =>Please enter a number between 1 and 3:"
			n = gets.chomp.to_i
		end
		n
	end

	def addchoice(arr, choice, i, j)
			if (arr[i-1][j-1] == nil)
				arr[i-1][j-1] = choice
			else
				puts " =>That sopt is already taken!"
			end
	end

	def gameover?(arr) 
	i = 0
	j = 0
	while (i < arr.size)
		if ( (arr[i].all? do |ch| ( ch != nil && ch == :x) end) || (arr[i].all? do |ch| (ch != nil && ch == :o) end) ) 
			return true
		end
		if (arr[j][i] != nil && arr[j][i] == arr[j+1][i] && arr[j+1][i] == arr[j+2][i])
			return true
		end
	i += 1
	end  
	if (arr[j][j] != nil && arr[j][j] == arr[j+1][j+1] && arr[j+1][j+1] == arr[j+2][j+2])
			return true
		end
	if ( arr[j][j+2] != nil && arr[j][j+2] == arr[j+1][j+1] && arr[j+1][j+1] == arr[j+2][j])
		return true
	end
	if (arr.all? do |a| a.all? do |b| b != nil end end)
		return :no_win
	end
	false
	end

	def turn_of(player, m) 
		puts " =>It's #{player.name}'s turn:"
		print " =>#{player.name}, Please select the line number: "
		line = get_number
		print " =>Please select the column number: "
		column = get_number
		addchoice(@board, m, line, column)
	end

end

module BoardMethods
	def show_board(board)
	puts "_______"	
	board.each do |b|
		b.each do |s|
			if (s != nil)
			 	print "|#{s}"
			else
				print "| "
			end
		end
		puts "|"
	end
	puts "*******"
end
end

class XO

	attr_reader :player1, :player2
	attr_accessor :board
	def initialize(player1_name, player2_name)
		@player1 = Player.new(player1_name)
		@player2 = Player.new(player2_name)
		@board = [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
	end

	class Player
		attr_reader :name
		def initialize(name)
			@name = name
		end
	end

	include RulesOfTheGame
	include BoardMethods

end

StartTheGame::display_intro
player1 = StartTheGame.get_name_of('first player')
player2 = StartTheGame.get_name_of('second player')
xo = XO.new(player1, player2)
xo.show_board(xo.board)

while (true) 
	xo.turn_of(xo.player1, :x)
	xo.show_board(xo.board)
	if ( xo.gameover?(xo.board) == true ) 
		puts " =>Game Over!"
		puts " =>And the winner is : #{xo.player1.name}"
		break
	end
	if (xo.gameover?(xo.board) == :no_win)
		puts " =>Game over!"
		puts " =>No winners!"
		break
	end
	xo.turn_of(xo.player2, :o)
	xo.show_board(xo.board)
	if ( xo.gameover?(xo.board) == true ) 
		puts " =>Game Over!"
		puts " =>And the winner is : #{xo.player2.name}"
		break
	end
	if (xo.gameover?(xo.board) == :no_win)
		puts " => Game over!"
		puts " => No winners!"
		break
	end
end
