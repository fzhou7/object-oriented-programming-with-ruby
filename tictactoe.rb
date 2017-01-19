class Board
	attr_reader :turn, :players, :first_row, :second_row, :third_row, :complete

	def initialize
		@players = 0
		@first_row = [nil,nil,nil]
		@second_row = [nil,nil,nil]
		@third_row = [nil,nil,nil]
		@complete = [@first_row, @second_row, @third_row]

		@turn = Random.new.rand(2)
	end

	def draw
		puts "[#{@first_row.join('][')}]"
		puts "[#{@second_row.join('][')}]"
		puts "[#{@third_row.join('][')}]"
	end

	def is_full?
		@complete.all? do |row|
			row.all? { |space| space }
		end
	end

	def winner?
		case 
		when @first_row.all? && @first_row.uniq.length == 1
			true
		when @
			
		end

	end

end

class Player
	attr_reader :name, :id
	@@count = 0

	def initialize name
		@name = name
		@id = ""

		@@count+=1

	end

end

def mode
	puts "Please select a mode:
	'1': [SINGLE PLAYER]
	'2': [MULTIPLAYER]"
	gets.chomp
end

def game
	puts "Please enter a name for Player 1:"
	p1 = Player.new(gets.chomp)
	puts "Please enter a name for Player 2:"
	p2 = Player.new(gets.chomp)

end

def run
	puts "\n\n-----Welcome to Tic-Tac-Toe!-----\n"
	
	player_mode = mode

	case player_mode
	when '1'
		#initialize single-player game
		puts '1-Player'
		board = Board.new
		board.draw
	when '2'
		#initialize multi-player game
		puts '2-Player'
		board = Board.new
		board.draw
	else
		puts "Input not recognized."
		run
	end
end
run