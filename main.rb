require './card'
require './dealer'
require './deck'
require './game'
require './hand'
require './rank'
require './suit'

puts "\e[H\e[2J"
while 1 == 1
	g = Game.new
	g.deal_first_round
	puts "What do you want to keep?"
	saved = gets.chomp.split().map { |e| e.to_i  }
	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	g.deal_second_round(saved)
	g.check_winner
	puts "--------------------------------------"
	puts "\n\n\n\n\n\n\n\n"
	puts "Press Enter to Continue"
	gets
	puts "\e[H\e[2J"
	g = nil
end
