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
=begin
		puts "[#{@first_row.join('][')}]"
		puts "[#{@second_row.join('][')}]"
		puts "[#{@third_row.join('][')}]"
=end
		puts "[#{@complete[0].join('][')}]"
		puts "[#{@complete[1].join('][')}]"
		puts "[#{@complete[2].join('][')}]"
	end

	def move (marker, row, column)
		@complete[row][column] = marker
	end

	def is_full?
		@complete.all? do |row|
			row.all? { |space| space }
		end
	end

	def winner?
		if @complete.find { |row| row.uniq.length == 1 if row[0] }
			a = @complete.find { |row| row.uniq.length == 1 if row[0] }
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

	def id_coin_flip
		case Random.new.rand(2)
		when 0
			@id = "X"
		when 1
			@id = "O"
		end
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

	puts "'1': Choose own markers
	or
	'2': Coin flip (X/O)?"

	case gets.chomp
	when '1'
		puts "Assign a marker for #{p1.name}:"
		p1.id = gets.chomp
		puts "Assign a marker for #{p2.name}:"
		p2.id = gets.chomp
	when '2'
		puts "Who flips the coin?
		'1': Player 1
		'2': Player 2"

	end

end

def run
	puts "\n\n-----Welcome to Tic-Tac-Toe!-----\n"
	
	player_mode = mode

	case player_mode
	when '1'
		#initialize single-player game
		puts
		puts '-----1-Player-----'
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