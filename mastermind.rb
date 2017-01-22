class Hash
	def sample(n)
		Hash[to_a.sample(n)]
	end
end

class Player
	attr_accessor :name
	def initialize name
		@name = name
	end
end

def input_error
	puts "Error: Input Not Recognized"
end

class Combination
	attr_accessor :first, :second, :third, :fourth, :combo
	@@colors = {
		1 => "RED",
		2 => "ORANGE",
		3 => "YELLOW",
		4 => "GREEN",
		5 => "BLUE",
		6 => "PURPLE",
		7 => "WHITE",
		8 => "BLACK"
	}

	def initialize
		@first = ""
		@second = ""
		@third = ""
		@fourth = ""
		@combo = []
	end

	def show
		puts @combo.join(" | ")
	end

	def set(input, spot)
		if input.to_i > 0 && input.to_i <= 8
			case spot
			when 0
				@first = @@colors[input.to_i]
				@combo[spot] = @@colors[input.to_i]
			when 1
				@second = @@colors[input.to_i]
				@combo[spot] = @@colors[input.to_i]
			when 2
				@third = @@colors[input.to_i]
				@combo[spot] = @@colors[input.to_i]
			when 3
				@fourth = @@colors[input.to_i]
				@combo[spot] = @@colors[input.to_i]
			else
				input_error
				set(input, spot)
			end
		elsif input.is_a? String
			if @@colors.any? { |key, value| value == input.upcase}
				@first = input.upcase
				@combo[spot] = input.upcase
			end
		else
			input_error
			set(input, spot)
		end
	end

	def set_random
		@combo = @@colors.sample(4).values

		@first = @combo[0]
		@second = @combo[1]
		@third = @combo[2]
		@fourth = @combo[3]
	end

end

class Guess < Combination
	attr_accessor :correct_colors, :correct_positions
	@@guesses = 0

	def initialize
		super
		@@guesses += 1
		@correct_colors = 0
		@correct_positions = 0
	end

	def show_details
		puts "#{@combo.join(' | ')} #{@correct_positions} correct positions and #{@correct_colors} correct colors."
	end

	def check(combination)
		check_position(combination)
		check_only_colors(combination)
	end

	def check_only_colors(combination)
		for i in (0...@combo.length)
			if @combo[i] != combination.combo[i]
				@correct_colors += 1 if @combo.any? { |k| combination.combo[i] == k }
			end
		end
	end

	def check_position(combination)
		correct_positions = 0
		for i in (0...@combo.length)
			if @combo[i] == combination.combo[i]
				@correct_positions += 1
			end
		end
	end
end

class CPUComb < Combination
	def initialize
		set_random
	end
end


def show_options
	puts "1 => RED | 2 => ORANGE | 3 => YELLOW | 4 => GREEN"
	puts "-------------------------------------------------"
	puts "5 => BLUE | 6 => PURPLE | 7 => WHITE | 8 => BLACK"
end

def victory (&cpu_combination)
	puts "\nCongratulations, you won!"
	yield
	puts "\nPlay again?(y/n)"
	case gets.chomp
	when 'y'
		run
	when 'n'
		exit
	else
		input_error
		victory
	end
end

def single_player
	puts "\n-----Single Player!-----"
	puts
	cpu = CPUComb.new
	puts "Computer combo generated!" if cpu

	guesses = []
	while guesses.size <= 12
		guesses.each do |i|
			i.show_details
			if i.correct_positions == 4
				victory do
					puts "\nCPU Combination: "
					cpu.show
				end
			end
		end
		puts "Guesses: #{guesses.size}\tGuesses left: #{12-guesses.size}"
		puts "\nEnter a combination:\n"
		show_options
		guess = Guess.new
		for i in (0...4) do
			guess.set(gets.chomp, i)
		end
		guess.check(cpu)
		guesses << guess
	end
end

def multiplayer(p1,p2)
	puts "\nWho would like to set the code? ('1': P1 | '2': P2)"
	case gets.chomp
	when '1'
		code_holder = p1
	when '2'
		code_holder = p2
	else
		input_error
	end

	puts code_holder.name
end

def run
	puts "\n-----Welcome to Mastermind!-----\n"
	puts "\t'1': Single Player
	\tor
	'2': Multi-Player"
	case gets.chomp
	when '1'
		single_player
	when '2'
		puts "\n-----Multi-Player!-----"
		puts "\nEnter a name for Player 1:"
		p1 = Player.new(gets.chomp)
		puts "Enter a name for Player 2:"
		p2 = Player.new(gets.chomp)

		multi_player(p1,p2)
	else
		input_error
		run
	end
	
end

run