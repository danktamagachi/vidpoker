require './card'
require './dealer'
require './deck'
require './game'
require './hand'
require './rank'
require './suit'
require './session'

puts "\e[H\e[2J" # Clear screen via ANSI sequence

# Init key variables
s = Sesh.new(:pot=>1000)
extra_ct = 0
bet_per_hand = 0

# Set up the game
puts "How much do you want to bet per hand?"
bet_per_hand = gets.chomp.to_i || 5
puts "How many games at a time?"
extra_ct = gets.chomp.to_i - 1 || 0
puts "Starting Pot: $#{s.pot}"

while 1 == 1 # Main Loop
	g = Game.new(:extra_games_ct => extra_ct) # Create Game
	puts "Placing Bet of $#{(bet_per_hand + (bet_per_hand * extra_ct))}"
	s.place_bet(bet_per_hand)

	# First Round of Dealing
	puts "First Hand Dealt"
	g.deal_first_round
	g.print_hand

	# Hold Cards
	puts "What do you want to keep?"
	saved = gets.chomp.split().map { |e| (e.to_i - 1) }
	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	
	# Clone game X times after first deal, before second deal
	g.create_extra_games
	s.place_bet(bet_per_hand * extra_ct)

	puts "\e[H\e[2J" # Clear screen via ANSI sequence

	# Second Round of Dealing
	puts "Second Hand Dealt"
	g.deal_second_round(saved)
	g.print_hand

	# Check Winner
	s.collect_winnings(g.check_winner)

	# Finish Extra Games
	s.collect_winnings(g.finish_extra_games(saved))

	# Reset for Next Game
	puts "--------------------------------------"
	puts "\n\n\n\n\n\n\n\n"
	puts "Press Enter to Continue"
	gets.chomp
	puts "\e[H\e[2J" # Clear screen via ANSI sequence
	g = nil
	puts "Current Pot: $#{s.pot}"
end
