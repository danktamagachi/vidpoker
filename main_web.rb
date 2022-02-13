require './card'
require './dealer'
require './deck'
require './game'
require './hand'
require './rank'
require './suit'
require './session'

require 'sinatra'
require 'json'

 #enable :sessions
use Rack::Session::Pool

get '/start' do 
	session[:sesh] = Sesh.new(:pot=>1000)
	session[:extra_ct] = 0 
	session[:bet_per_hand] = 1
	
	erb :index, :locals => {:sesh=>session[:sesh], :round=>0}
end

get '/first-round' do 
	session[:current_game] = nil
	session[:extra_ct]=params[:extra_ct].to_i if params[:extra_ct]
	session[:bet_per_hand]=params[:bet_per_hand].to_i if params[:bet_per_hand]	

	session[:current_game] = Game.new(:extra_games_ct => session[:extra_ct])
	
	session[:sesh].place_bet(session[:bet_per_hand] + (session[:bet_per_hand] * session[:extra_ct]))
	session[:current_game].deal_first_round
	
	erb :index, :locals => {:sesh=>session[:sesh], :current_game=>session[:current_game], :round=>1}
end

get '/second-round' do 
	if params.key?('held') 
		saved = JSON.parse(params[:held])
	else
		saved = []
	end

	saved.count > 5 ? saved = [0,1,2,3,4]  : saved
	
	session[:current_game].create_extra_games
	session[:current_game].deal_second_round(saved)
		
	session[:sesh].collect_winnings(session[:current_game].check_winner * session[:bet_per_hand]) 
	session[:sesh].collect_winnings(session[:current_game].finish_extra_games(saved,session[:bet_per_hand]))

	erb :index, :locals => {:sesh=>session[:sesh], :current_game=>session[:current_game], :round=>2}
end
