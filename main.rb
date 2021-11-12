require './card'
require './dealer'
require './deck'
require './game'
require './hand'
require './rank'
require './suit'

puts "\e[H\e[2J" # Clear screen via ANSI sequence

while 1 == 1 # Main Loop
	g = Game.new # Create Game
	
	# First Round of Dealing
	g.deal_first_round
	puts "First Hand Dealt"
	g.hand.hand.each_with_index do |card,idx|
		puts "Card #{idx}: #{card.to_s}"
	end

	# Hold Cards
	puts "What do you want to keep?"
	saved = gets.chomp.split().map { |e| e.to_i  }
	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	
	# Second Round of Dealing
	g.deal_second_round(saved)
	puts "Second Hand Dealt"
	g.hand.hand.each_with_index do |card,idx|
		puts "Card #{idx}: #{card.to_s}"
	end

	# Check Winner
	g.check_winner

	#Reset for Next Game
	puts "--------------------------------------"
	puts "\n\n\n\n\n\n\n\n"
	puts "Press Enter to Continue"
	gets
	puts "\e[H\e[2J" # Clear screen via ANSI sequence
	g = nil
end
