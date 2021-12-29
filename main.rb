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
	
	#Variables for multiple hands
	extra_games_ct = 2
	extra_games = []

	# First Round of Dealing
	g.deal_first_round
	puts "First Hand Dealt"
	g.hand.hand.each_with_index do |card,idx|
		puts "Card #{(idx + 1)}: #{card.to_s}"
	end

	# Hold Cards
	puts "What do you want to keep?"
	saved = gets.chomp.split().map { |e| (e.to_i - 1) }
	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	
	# Clone game after first deal, before second deal
	extra_games_ct.times do |i|
		extra_games << Marshal.load(Marshal.dump(g))
	end

	puts "\e[H\e[2J" # Clear screen via ANSI sequence

	# Second Round of Dealing
	g.deal_second_round(saved)
	puts "Second Hand Dealt"
	g.hand.hand.each_with_index do |card,idx|
		puts "Card #{(idx + 1)}: #{card.to_s}"
	end

	# Check Winner
	g.check_winner

	# Second Round of Dealing for Extra Games, Unless no Extra Games
	extra_games.each_with_index do |game, idx| 
		game.dealer.deck.shuffle
		game.deal_second_round(saved)
		puts "\n\nGame #{idx + 2}"
		
		game.hand.hand.each_with_index do |card,idx|
			puts "Card #{(idx + 1)}: #{card.to_s}"
		end
		game.check_winner
	end unless extra_games == []




	# Reset for Next Game
	puts "--------------------------------------"
	puts "\n\n\n\n\n\n\n\n"
	puts "Press Enter to Continue"
	gets
	puts "\e[H\e[2J" # Clear screen via ANSI sequence
	g = nil
end
