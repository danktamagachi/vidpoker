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
