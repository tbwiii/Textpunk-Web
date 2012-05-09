require_relative 'areas'
require "sinatra"
require "erb"
require "sass"

module Textpunkweb

	use Rack::Session::Pool

	get '/' do
		p CURRENT
		session[:room] = CURRENT
   		redirect("/game")
	end
	
	get '/game' do
		erb :show_room, :locals => {:room => session[:room]}			

	end

	post '/game' do

		action = params[:action].downcase

		session[:room].paths.each_key do |key|
			if action.include? key
				session[:room] = session[:room].go(key)
			
			elsif action.include? 'die'
				session[:room] = session[:room].go('die')
			end
		end

		erb :show_room, :locals => {:room => session[:room]}
		
	end

	get '/screen.css' do
  		scss :screen
  	end


end