class Hand
	attr_accessor :hand, :is_winner, :win_string, :payout_mult

	def initialize
		@hand = []
		@is_winner = 0
		@win_string = ""
		payout_mult = 0
	end

	def num_pairs
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.rank.rank] +=1
		end
		counts.select{|key,value| value == 2 }.count
	end

	def num_three_k
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.rank.rank] +=1
		end
		counts.select{|key,value| value == 3 }.count
	end

	def is_flush
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.suit.suit] +=1
		end
		if counts.select{|key,value| value == 5 }.count > 0
			1
		else
			0
		end
	end

	def is_full_house
		if num_pairs == 1 and num_three_k == 1 
			1
		else
			0
		end

	end

	def num_four_k
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.rank.rank] +=1
		end
		counts.select{|key,value| value == 4 }.count
	end


	def check_sum_match?(arr)
	  m = arr.min - 1
	  n = arr.max
	  sum1 = arr.inject{|sum, x| sum = sum + x}
	  sum2 = (n*(n+1) - m*(m+1))/2
	  sum1 == sum2
	end

	def is_straight
		arr = []
		@hand.each do |card|
			arr << Rank::RANKS[card.rank.rank]
		end

		if check_sum_match?(arr) || arr.sort == [1,10,11,12,13].sort
			1
		else
			0
		end
	end

	def is_pair_good?
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.rank.rank] +=1
		end
		# TODO: FIX ACE PAIRS
		pr = counts.select{|key,value| value == 2 }
		puts counts
		puts pr
		if [:jack, :queen, :king, :ace].include? pr.first[0] 
			true
		else
			false
		end
	end

	def is_royal_straight?
		arr = []
		@hand.each do |card|
			arr << Rank::RANKS[card.rank.rank]
		end

		if arr.sort == [1,10,11,12,13].sort
			true
		else
			false
		end
	end

	def check_win
		num_pairs = self.num_pairs
		num_three_k = self.num_three_k
		num_four_k = self.num_four_k
		is_flush = self.is_flush
		is_full_house = self.is_full_house
		is_straight = self.is_straight
		is_royal_straight = self.is_royal_straight?

		if(num_pairs == 0 && num_three_k == 0 and num_four_k == 0 && is_flush == 0 && is_full_house == 0 && is_straight ==0)
				@win_string = "No winner"
				@payout_mult = 0
				@is_winner = 0
			elsif (is_straight == 1 && is_flush == 1)
				if (is_royal_straight)
					@win_string = "Winner - Royal Flush!!!!"
					@payout_mult = 250
					@is_winner = 1
				else
					@win_string = 'Winner - Straight Flush'
					@payout_mult = 50
					@is_winner = 1
				end
			elsif (num_four_k == 1)
				@win_string = "Winner - 4 of a Kind"
				@payout_mult = 25
				@is_winner = 1
			elsif (num_pairs == 1 and num_three_k == 1 )
				@win_string = "Winner - Full House"
				@payout_mult = 9
				@is_winner = 1
			elsif (is_flush == 1)
				@win_string = "Winner - Flush"
				@payout_mult = 6
				@is_winner = 1
			elsif (is_straight == 1)
				@win_string = "Winner - Straight"
				@payout_mult = 4
				@is_winner = 1
			elsif (num_three_k == 1)
				@win_string = "Winner - 3 of a Kind"
				@payout_mult = 3
				@is_winner = 1
			elsif (num_pairs == 2)
				@win_string = "Winner - 2 Pair"
				@payout_mult = 2
				@is_winner = 1
			elsif (num_pairs == 1 )
				if self.is_pair_good?
					@win_string = "Winner - 1 Pair - Jacks or Better"
					@payout_mult = 1
					@is_winner = 1
				else
					@win_string = "No Winner"
					@payout_mult = 0
					@is_winner = 0
				end

		end

		puts win_string
		return payout_mult

	end
end
