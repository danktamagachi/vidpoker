class Suit
    SUITS = {:clubs => 1, :diamonds => 2, :spades => 3, :hearts => 4}
    attr_accessor :suit
    def initialize suit
        @suit = SUITS.key(suit)
    end
    
    def == other
        suit == other.suit
    end

    def to_s
    	case suit
    	when :clubs
    		"♣"
    	when :hearts
    		"♥"
    	when :spades
    		"♠"
    	when :diamonds
    		"♦"
    	end
    end

end

class Rank
    RANKS = {:ace => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :jack => 11, :queen => 12, :king =>13}
    attr_accessor :rank
    def initialize rank
        @rank = RANKS.key(rank)
    end
    
    def == other
        rank == other.rank
    end

    def to_s
    	case rank
    	when :ace
    		"A"
    	when :two
    		"2"
    	when :three
    		"3"
    	when :four
    		"4"
    	when :five
    		"5"
    	when :six
    		"6"
    	when :seven
    		"7"
    	when :eight
    		"8"
    	when :nine
    		"9"
    	when :ten
    		"10"
    	when :jack
    		"J"
    	when :queen
    		"Q"
    	when :king
    		"K"
    	end
    end
end

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


class Deck
	attr_accessor :deck

	def initialize
		@deck = []
		Rank::RANKS.each do |rank|
			Suit::SUITS.each do |suit|
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

class Dealer
	attr_accessor :deck

	def initialize
		@deck = Deck.new
		#@deck.shuffle
	end

	def deal(n)
		dealt = []
		n.times do |n|
			dealt << @deck.pop
		end
		dealt
	end
end

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
			arr << card.rank.
		end
	end	
end


class Game
	attr_accessor :game, :dealer, :hand
	
	def initialize
		@dealer = Dealer.new
		@hand = Hand.new
	end

	def deal_first_round
		@hand.hand = @dealer.deal(5)
		puts "First Hand Dealt"
		@hand.hand.each_with_index do |card,idx|
			puts "Card #{idx}: #{card.to_s}"
		end
	end
	
	def ask_what_to_save
		puts "What do you want to keep?"
		@saved = gets.chomp.split().map { |e| e.to_i  }
		@saved.count > 5 ? saved = [0,1,2,3,4]  : @saved
	end

	def deal_second_round
		if @saved 
			ct = @saved.count
			temp_hand = []
			@hand.hand.each_with_index do |card,idx|
				temp_hand << card if @saved.include? idx
			end
			num_to_deal = 5-temp_hand.count
			num_to_deal.times do |n|
				temp_hand << @dealer.deal(1).first
			end		
		else
			temp_hand = @dealer.deal(5)
		end

		@hand.hand = temp_hand

		puts "Second Hand Dealt"
		@hand.hand.each_with_index do |card,idx|
			puts "Card #{idx}: #{card.to_s}"
		end
	
	end


	def check_winner
		num_pairs = @hand.num_pairs
		num_three_k = @hand.num_three_k
		num_four_k = @hand.num_four_k
		is_flush = @hand.is_flush
		is_full_house = @hand.is_full_house

		puts "Number of Pairs: #{@hand.num_pairs}"
		puts "Number of 3 of a Kind: #{@hand.num_three_k}"
		puts "Number of 4 of a Kind: #{@hand.num_four_k}"
		puts "Is flush: #{@hand.is_flush}"
		puts "Is full house: #{@hand.is_full_house}"

		if(num_pairs == 0 && num_three_k == 0 and num_four_k == 0 && is_flush == 0 && is_full_house == 0)
			puts "No winner"
		else
			puts "Winner"
		end
	end
end


g = Game.new
g.deal_first_round
g.ask_what_to_save
g.deal_second_round
g.check_winner

