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

defaults = Area.new("defaults"," ") 
# this room should never show - it's only here
# to provide default actions that are always availible

textpunk = Area.new("Textpunk",
%q{
	<p>You've been knocked out maybe?</p>

	<p>Who knows...</p>

	<p>You stand up.</p>

	<p>Type "Begin" to get started</p>
})

closet = Area.new("Closet",
%q{
	<p>
	You're in a small, dark room.
	</p>

	<p>
		You can't really see anything, but you can feel a door in front of you.
	</p>
})

sleep = Area.new("Sleep",
"<p>Quite the gamer, arent you?</p><p>Type \"Retry\" to try again.</p>"
)

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
	There are four doors nearby. They all have nice signs: "Crew Only", "Ballroom", "Guest Quarters", and "Leisure". 
	</p>

	<p>
	There's also the closet door at the back of the hall. You'll have to walk to get there.
	</p>

})

crew_room = Area.new("Crew Only", 
	%q{
		<p>
			There are several people in here all wearing uniforms. One of them spots you.
		</p>

		<p>
			"Hey! Who are you?" You don't get time to answer before a couple of the guys grab you and start dragging you torwards a big important-looking door at the other side of the room.
		</p>

		<p>
			You're not sure what to do...It looks like they're taking to you to the person in charge. You could fight and try to get away, or you could submit and see where they're taking you.
		</p>

})

ballroom = Area.new("The Ballroom", 
%q{
	<p>
		You could have a party in here. There's a bar and tables are scattered around the edges of the room. It's empty as far as people go though.
	</p>

	<p>
		There are 2 doors. One from where you came and another "Crew Only" door that probably leads to the same room as the one in the Main Hallway.
	</p>
})

bridge = Area.new("The Bridge", "COMING SOON")


you_die = Area.new("Oops",
%q{
<p>
Turns out, that just got you killed. Type "Retry" to try again
</p>
	})

defaults.add_paths({
	'//die' => you_die,
	'//retry' => closet,
})

textpunk.add_paths({
	'begin' => closet,
	})

closet.add_paths({
	'door' => hall_back,
	'sleep' => sleep,
})

sleep.add_paths({
	'retry' => textpunk,
	})

hall_back.add_paths({
	'closet' => closet,
	'back' => closet,
	'walk' => hall_front,
	})

hall_front.add_paths({
	'walk' => hall_back,
	'crew' => crew_room,
	'ballroom' => ballroom,

})

crew_room.add_paths({
	'fight' => you_die,
	'go' => bridge,
	'submit' => bridge,
	'see' => bridge,
})

ballroom.add_paths({
	'crew' => crew_room,
	'hall' => hall_front,
	'back' => hall_front,

})

you_die.add_paths({
	'retry' => closet,
	})



CURRENT = textpunk
DEFAULTS = defaults