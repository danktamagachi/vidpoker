class Game
	attr_accessor :dealer, :hand, :extra_games
	
	def initialize(**args)
		@dealer = Dealer.new
		@hand = Hand.new
		@extra_games = []
		@extra_games_ct = args[:extra_games_ct] || 0
	end

	def create_extra_games
		@extra_games_ct.times do |i|
			@extra_games << Marshal.load(Marshal.dump(self))
		end
	end

	def finish_extra_games(saved)
		winnings = 0
		if @extra_games_ct > 0 then 
			@extra_games.each_with_index do |game, idx| 
				game.dealer.deck.shuffle
				game.deal_second_round(saved)
				puts "\n\nGame #{idx + 2}"
			
				game.print_hand
				winnings = winnings + game.check_winner
			end
		end

		winnings 
	end 


	def deal_first_round
		@hand.hand = @dealer.deal(5)
	end
	
	def print_hand
		@hand.hand.each_with_index do |card,idx|
			puts "Card #{(idx + 1)}: #{card.to_s}"
		end
	end

	def deal_second_round(saved)
		if saved 
			ct = saved.count
			temp_hand = []
			@hand.hand.each_with_index do |card,idx|
				temp_hand << card if saved.include? idx
			end
			num_to_deal = 5-temp_hand.count
			num_to_deal.times do |n|
				temp_hand << @dealer.deal(1).first
			end		
		else
			temp_hand = @dealer.deal(5)
		end
		@hand.hand = temp_hand
	end


	def check_winner
		num_pairs = @hand.num_pairs
		num_three_k = @hand.num_three_k
		num_four_k = @hand.num_four_k
		is_flush = @hand.is_flush
		is_full_house = @hand.is_full_house
		is_straight = @hand.is_straight
		is_royal_straight = @hand.is_royal_straight

		#puts "Number of Pairs: #{@hand.num_pairs}"
		#puts "Number of 3 of a Kind: #{@hand.num_three_k}"
		#puts "Number of 4 of a Kind: #{@hand.num_four_k}"
		#puts "Is flush: #{@hand.is_flush}"
		#puts "Is full house: #{@hand.is_full_house}"
		#puts "Is straight: #{@hand.is_straight}"

		if(num_pairs == 0 && num_three_k == 0 and num_four_k == 0 && is_flush == 0 && is_full_house == 0 && is_straight ==0)
			puts "No winner"
			return 0
		elsif (is_straight == 1 && is_flush == 1)
			if (is_royal_straight)
				puts "Winner - Royal Flush!!!!"
				return 250
			else
				puts 'Winner - Straight Flush'
				return 50
			end
		elsif (num_four_k == 1)
			puts "Winner - 4 of a Kind"
			return 25
		elsif (num_pairs == 1 and num_three_k == 1 )
			puts "Winner - Full House"
			return 9
		elsif (is_flush == 1)
			puts "Winner - Flush"
			return 6
		elsif (is_straight == 1)
			puts "Winner - Straight"
			return 4
		elsif (num_three_k == 1)
			puts "Winner - 3 of a Kind"
			return 3
		elsif (num_pairs == 2)
			puts "Winner - 2 Pair"
			return 2
		elsif (num_pairs == 1 )
			if @hand.is_pair_good == true 
				puts "Winner - 1 Pair - Jacks or Better"
				return 1
			else
				puts "No Winner"
				return 0
			end
		end
	end
end

