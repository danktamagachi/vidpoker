class Deck
	attr_accessor :deck

	def initialize
		@deck = []
		Suit::SUITS.each do |suit|
			Rank::RANKS.each do |rank|
				@deck << Card.new(:rank => Rank.new(rank[1]), :suit => Suit.new(suit[1]))
			end

		end
	end

	def count
		@deck.count
	end

	def shuffle
		@deck.shuffle!
	end

	def to_s
		@deck.each do |card|
			puts card.to_s
		end
	end

	def pop
		@deck.pop
	end
end

