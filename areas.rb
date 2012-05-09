class Area
	attr_accessor :name, :description, :paths

	def initialize(name, description)
		@name = name
		@description = description
		@paths = {}
	end

	def go(direction)
		@paths[direction]
	end

	def add_paths(paths)
		@paths.update(paths)
	end
end

closet = Area.new("Closet",
%q{
You're in a small, dark room. You can feel a door in front of you.
})



hall_back = Area.new("Back of the Main Hallway",
%q{
You're in what looks to be the back of the main hallway.
It's very nice with its wooden walls and red carpeting.	

The hallway is really long and it looks like there's a door at the end,
and a few in between. But you'll have to walk to get to any of them.

Of course you could just go back to sleep in the closet.
})

you_die = Area.new("YOU DED",
%q{
	You just...die. Type "Retry" to try again
	})

closet.add_paths({
	'door' => hall_back,
	'die' => you_die
})

you_die.add_paths({
	'retry' => closet
	})



CURRENT = closet