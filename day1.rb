
puts 'Lets play a game: Guess the number 0 - 100'

correctNumber = rand(100).to_i
guess = -1

until guess.to_i == correctNumber
	puts "Guess a number"
	guess = gets
	puts 'higher' if guess.to_i < correctNumber
	puts 'lower' if guess.to_i > correctNumber
end

puts 'winner winner chicken dinner'


