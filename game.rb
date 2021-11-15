class Game
	attr_accessor :game, :dealer, :hand
	
	def initialize
		@dealer = Dealer.new
		@hand = Hand.new
	end

	def deal_first_round
		@hand.hand = @dealer.deal(5)
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

		#puts "Number of Pairs: #{@hand.num_pairs}"
		#puts "Number of 3 of a Kind: #{@hand.num_three_k}"
		#puts "Number of 4 of a Kind: #{@hand.num_four_k}"
		#puts "Is flush: #{@hand.is_flush}"
		#puts "Is full house: #{@hand.is_full_house}"
		#puts "Is straight: #{@hand.is_straight}"

		if(num_pairs == 0 && num_three_k == 0 and num_four_k == 0 && is_flush == 0 && is_full_house == 0)
			puts "No winner"
		elsif (is_straight == 1 && is_flush == 1)
			puts "Winner - Straight Flush"
		elsif (num_four_k == 1)
			puts "Winner - 4 of a Kind"
		elsif (num_pairs == 1 and num_three_k == 1 )
			puts "Winner - Full House"
		elsif (is_flush == 1)
			puts "Winner - Flush"
		elsif (is_straight == 1)
			puts "Winner - Straight"
		elsif (num_three_k == 1)
			puts "Winner - 3 of a Kind"
		elsif (num_pairs == 2)
			puts "Winner - 2 Pair"
		elsif (num_pairs == 1 )
			if @hand.is_pair_good == true 
				puts "Winner - 1 Pair - Jacks or Better"
			else
				puts "No Winner"
			end
		end
	end
end

