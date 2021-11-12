class Card
	attr_reader :suit, :rank
	def initialize(args)
		@suit = args[:suit]
		@rank = args[:rank]
	end

	def == other
		rank == other.rank && suit == other.suit
	end

	def to_s
		rank.to_s + suit.to_s
	end
end

