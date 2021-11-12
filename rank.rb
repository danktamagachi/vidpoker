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

