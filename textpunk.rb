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

		action = params[:action]

		session[:room].paths.each_key do |key|
			if action.include? key
				session[:room] = session[:room].go(action)
			end
		end

		redirect("/game")
		
	end

	get '/screen.css' do
  		scss :screen
  	end


end