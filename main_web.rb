require './card'
require './dealer'
require './deck'
require './game'
require './hand'
require './rank'
require './suit'
require './session'

require 'sinatra'

 
# Init key variables
enable :sessions

get '/start' do 
	session[:sesh] = Sesh.new(:pot=>1000)
	session[:extra_ct] = 0 
	session[:bet_per_hand] = 1
	"Starting Pot: $" + session[:sesh].pot.to_s
end

get '/first-round' do 
	session[:current_game] = Game.new(:extra_games_ct => session[:extra_ct])
	session[:sesh].place_bet(session[:bet_per_hand])
	session[:current_game].deal_first_round
	session[:current_game].hand.to_s
end

get '/second-round' do 

	saved = request["saved"] || [1]
	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	session[:current_game].create_extra_games
	session[:sesh].place_bet(session[:bet_per_hand] * session[:extra_ct])
	
	session[:current_game].deal_second_round(saved)
	session[:sesh].collect_winnings(session[:current_game].check_winner)
	session[:sesh].collect_winnings(session[:current_game].finish_extra_games(saved))
	session[:current_game] = nil
	"Ending Pot: $" + session[:sesh].pot.to_s
end