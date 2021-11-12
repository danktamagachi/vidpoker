class Dealer
	attr_accessor :deck

	def initialize
		@deck = Deck.new
		@deck.shuffle
	end

	def deal(n)
		dealt = []
		n.times do |n|
			dealt << @deck.pop
		end
		dealt
	end
end
