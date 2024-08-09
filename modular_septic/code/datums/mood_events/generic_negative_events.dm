//Went to funkytown
/datum/mood_event/face_off
	description = span_necrosis("Fuck your mother, I HAVE NO FACE!")
	mood_change = -5
	timeout = 0

//Turned into a brain
/datum/mood_event/freakofnature
	description = span_warning("WHERE IS MY BODY?!")
	mood_change = -15
	timeout = 10 MINUTES

//Cringe filter
/datum/mood_event/cringe
	description = span_boldwarning("I'm such an idiot. I wanted to say something idiotic.")
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/ultracringe
	description = span_boldwarning("What the fuck am I?! I wanted to say something idiotic.")
	mood_change = -8
	timeout = 15 MINUTES

//Pain mood
/datum/mood_event/painbad
	description = span_danger("I feel a lot of pain!")
	mood_change = -6
	timeout = 3 MINUTES

//Saw a badly injured crewmember
/datum/mood_event/saw_injured
	description = span_danger("I've seen darkening things!")
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/saw_injured/lesser
	mood_change = -1
	timeout = 5 MINUTES

//Saw a crewmember die

/datum/mood_event/saw_dead
	description = span_dead("I saw a dying creature...")
	mood_change = -5
	timeout = 10 MINUTES

/datum/mood_event/saw_dead/lesser
	description = span_dead("Well I saw a creature dying.")
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/saw_dead/good
	description = span_dead("I saw a creature dying, cool!")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/saw_dead/friend
	description = span_dead("I saw a dying comrade...")
	mood_change = -5
	timeout = 10 MINUTES

//Died
/datum/mood_event/died
	description = span_dead("<b>I know what NOTHING is.</b>")
	mood_change = -6
	timeout = 10 MINUTES

//Bad smell
/datum/mood_event/miasma
	description = span_warning("Smells like retarded shit!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/miasma/harsh
	description = span_danger("Smells like fucked up shit!")
	mood_change = -6

/datum/mood_event/shit
	description = span_warning("Smells like shit!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/shit/harsh
	description = span_danger("Smells like shit! Fuck!")
	mood_change = -6

/datum/mood_event/retarded
	description = span_warning("Smells like some kind of crap!")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/retarded/harsh
	description = span_danger("Smells like some fucking shit!")
	mood_change = -4

//WORST smell
/datum/mood_event/incredible_gas
	description = span_infection("Smells dangerous!")
	mood_change = -4
	timeout = 1 MINUTES

/datum/mood_event/incredible_gas/harsh
	description = span_infection("Smells like crazy dangerous!")
	mood_change = -8

/datum/mood_event/urinepoo_gas
	description = span_infection("Smells like some kind of bullshit!")
	mood_change = -5
	timeout = 1 MINUTES

/datum/mood_event/urinepoo_gas/harsh
	description = span_infection("Smells like some fucking shit!")
	mood_change = -9

/datum/mood_event/sleeptime_gas
	description = span_infection("Пахнет уютненько.")
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/sleeptime_gas/harsh
	description = span_infection("Какой хороший запах...")
	mood_change = 2

/datum/mood_event/vilir
	description = span_infection("I AM PETTY! I FEEL COLOSSAL ATROCITY!")
	mood_change = -3
	timeout = 1 MINUTES

/datum/mood_event/vilir/harsh
	description = span_infection("THE FIRST CREATOR!!!!")
	mood_change = -6

//Ate shit
/datum/mood_event/creampie/shitface
	description = span_infection("My face is covered in shit.")
	mood_change = -2
	timeout = 10 MINUTES

//Gun pointed at us
/datum/mood_event/gunpoint
	description = span_userdanger("A gun is pointed at me...")
	mood_change = -4

//Embedded thing
/datum/mood_event/embedded
	description = span_userdanger("There's something stuck in me!")
	mood_change = -4
