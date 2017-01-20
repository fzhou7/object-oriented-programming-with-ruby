class Board
	attr_reader :complete

	def initialize
		@complete = [[nil,nil,nil],[nil,nil,nil,],[nil,nil,nil]]
		@example_board = [[nil,nil,nil],[nil,nil,nil,],[nil,nil,nil]]
		@turns = 0
	end

	def draw array
		(0..2).each { |i| puts "[#{array[i].join('][')}]" }
	end

	def draw_board
		draw(@complete)
	end

	def turn(player_name, player_id)
		@turns += 1
		draw_board

		puts "\n#{player_name}'s turn:"

		draw_example

		action = gets.chomp.to_i

		move(player_id, action-1)
		
		puts
		puts "---------------"
	end

	def draw_example
		#replicate board
		i=1

		#replace all nil values with 1..9
		for j in (0..2)
			for k in (0..2)
				!@complete[j][k] ? @example_board[j][k] = i : @example_board[j][k] = @complete[j][k]
				i+=1
			end
		end
		draw(@example_board)
	end

	def move (marker, input)
		if input <= 2
			@complete[0][(input % 3)] = marker
		elsif input >= 3 && input <= 5
			@complete[1][(input % 3)] = marker
		elsif input >= 6 && input <= 8
			@complete[2][(input % 3)] = marker
		else
			puts "Error: Input not recognized"
		end
	end

	def is_full?
		@complete.all? do |row|
			row.all? { |space| space }
		end
	end

	def winner?
		if @complete.find { |row| row.uniq.length == 1 if row[0] }
			a = @complete.find { |row| row.uniq.length == 1 if row[0] }
			true
		elsif @complete[0][0] == @complete[1][1] && @complete[1][1] == @complete[2][2]
			true if @complete[1][1]
		elsif @complete[0][2] == @complete[1][1] && @complete[1][1] == @complete[2][0]
			true if @complete[1][1]
		elsif @complete[0][0] == @complete[1][0] && @complete[1][0] == @complete[2][0]
			true if @complete[0][0]
		elsif @complete[0][1] == @complete[1][1] && @complete[1][1] == @complete[2][1]
			true if @complete [0][1]
		elsif @complete[0][2] == @complete[1][2] && @complete[1][2] == @complete[2][2]
			true if @complete [0][2]
		else
			false
		end
	end

	def victory (player_name)
		puts "#{player_name.name} wins!"
		play_again?
	end
end

class Player
	attr_accessor :name, :id
	@@count = 0
	@@players = []

	def initialize name
		@name = name
		@id = ""

		@@count+=1

	end

	def id_coin_flip
		Random.new.rand(2) == 0 ? result = 'heads' : result = 'tails'

		result == 'heads' ? @id = 'O' : @id = 'X'
		puts "Coin flip:\n...\n...\n#{result}!"

	end

	def id_assign(player_1)
		case player_1.id
		when 'O'
			@id = 'X'
		else
			@id = 'O'
		end
	end

end

def mode
	puts "\tPlease select a mode:
	'1': [SINGLE PLAYER]
	'2': [MULTIPLAYER]"
	gets.chomp
end

def play_again?
	puts "Play again?(y/n)"
	case gets.chomp
	when 'y'
		run
	when 'n'
		exit
	else
		puts "Error: I don't recognize that command."
		play_again?
	end
end

def tie
	puts "It's a tie!"
	play_again?
end


def multiplayer
	players = []
	puts "Please enter a name for Player 1:"
	p1 = Player.new(gets.chomp)
	puts "Please enter a name for Player 2:"
	p2 = Player.new(gets.chomp)

	puts "\t'1': Choose own markers
	\tor
	'2': Coin flip (X/O)?"

	case gets.chomp
	when '1'
		puts "Assign a marker for #{p1.name}:"
		p1.id = gets.chomp
		puts "Assign a marker for #{p2.name}:"
		p2.id = gets.chomp

		players = [p1, p2]
	when '2'
		p1.id_coin_flip
		p2.id_assign(p1)
		p1.id == 'O' ? players = [p1, p2] : players = [p2, p1]
	end

	board = Board.new

	loop do
		players.each do |player|
			board.turn(player.name, player.id)
			if board.winner?
				board.draw_board
				board.victory(player)
				play_again?
			elsif board.is_full? && !board.winner?
				tie
			end
		end
	end

end

def run
	puts "\n\n-----Welcome to Tic-Tac-Toe!-----\n"
	
	player_mode = mode

	case player_mode
	when '1'
		#initialize single-player game
		puts
		puts '------1-Player-----'
		board = Board.new

		multiplayer
	when '2'
		#initialize multi-player game
		puts "-----2-Player-----"

		multiplayer
	else
		puts "Input not recognized."
		run
	end
end
run