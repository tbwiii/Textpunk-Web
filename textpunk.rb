require_relative 'areas'
require "sinatra"
require "erb"
require "sass"

module Textpunkweb

	get '/' do
   		redirect("/game")
	end

	get '/game' do
		erb :show_room, :locals => {:room => CURRENT}			

	end

	post '/game' do

		action = params[:action]

		CURRENT.paths.each_key do |key|
			if action.include? key
				CURRENT = CURRENT.go(action)
			end
		end

		redirect("/game")
		
	end

	get '/screen.css' do
  		scss :screen
  	end


end