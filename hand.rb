class Hand
	attr_accessor :hand

	def initialize
		@hand = []
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
		if check_sum_match?(arr)
			1
		else
			0
		end
	end

	def is_pair_good
		counts = Hash.new 0
		@hand.each do |card|
			counts[card.rank.rank] +=1
		end
		pr = counts.select{|key,value| value == 2 }
		if [:jack, :queen, :king, :ace].include? pr.first[0] 
			true
		else
			false
		end

	end



end
