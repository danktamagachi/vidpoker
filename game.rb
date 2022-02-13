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

	def finish_extra_games(saved,bet_per_hand)
		winnings = 0

		if @extra_games_ct > 0 then 
			@extra_games.each_with_index do |game, idx| 
				game.dealer.deck.shuffle
				game.deal_second_round(saved)
				winnings = winnings + (game.check_winner * bet_per_hand)
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

	def print_hand_web
		resp = ""
		@hand.hand.each_with_index do |card,idx|
			resp = resp + "Card #{(idx + 1)}: #{card.to_s}<br>"
		end
		resp
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
		@hand.check_win
	end
end

