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
<p>
You're in a small, dark room. You can feel a door in front of you.
</p>
})



hall_back = Area.new("Back of the Main Hallway",
%q{
<p>
You're in what looks to be the back of the main hallway.
It's very nice with its wooden walls and red carpeting.
</p>	

<p>
The hallway is really long and it looks like there's a door at the end,
and a few in between. But you'll have to walk to get to any of them.
</p>


<p>
Of course you could just go back to sleep in the closet.
</p>
})

hall_front = Area.new("Front of the Main Hallway",
%q{
	<p>
		You're at the front end of the hallway.
	</p>

	<p>
	There are four doors. They all have nice signs: "Crew Only", "Ballroom", "Guest Quarters", and "Leisure". 
	</p>

	<p>
	There's also the closet door at the back of the hall. You'll have to walk to get there.
	</p>

	})

you_die = Area.new("YOU DED",
%q{
<p>
You just...die. Type "Retry" to try again
</p>
	})

closet.add_paths({
	'door' => hall_back,
	'die' => you_die
})

hall_back.add_paths({
	'closet' => closet,
	'back' => closet,
	'walk' => hall_front
	})

you_die.add_paths({
	'retry' => closet
	})



CURRENT = closet