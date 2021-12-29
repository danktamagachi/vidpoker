class Session
	attr_accessor :pot

	def initialize(**args)
		@pot = args[:pot] || 1000 
	end

	def place_bet(amt)
		@pot = @pot - amt
	end

	def collect_winnings(amt)
		@pot = @pot + amt
	end
end
