require_relative 'areas'
require "sinatra"
require "erb"
require "sass"

module Textpunkweb

	use Rack::Session::Pool

	get '/' do
		p CURRENT
		session[:room] = CURRENT
		session[:defaults] = DEFAULTS
   		redirect("/game")
	end
	
	get '/game' do
		if !session[:room]
			redirect("/")	
		else
			erb :show_room, :locals => {:room => session[:room]}
		end			

	end

	post '/game' do

		action = params[:action].downcase

		session[:room].paths.each_key do |key|
			if action.include? key
				session[:room] = session[:room].go(key)
			end
		end

		session[:defaults].paths.each_key do |key|
				if action.include? key
				session[:room] = session[:defaults].go(key)
			end
		end

		erb :show_room, :locals => {:room => session[:room]}
		
	end

	get '/screen.css' do
  		scss :screen
  	end


end