//Went to funkytown
/datum/mood_event/face_off
	description = span_necrosis("Holy shit, my face is gone!")
	mood_change = -5
	timeout = 0

//Turned into a brain
/datum/mood_event/freakofnature
	description = span_warning("Where's is my body?! What did they do to me?!")
	mood_change = -15
	timeout = 10 MINUTES

//Cringe filter
/datum/mood_event/cringe
	description = span_boldwarning("I tried to say something stupid.")
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/ultracringe
	description = span_boldwarning("I am fucking retarded!")
	mood_change = -8
	timeout = 15 MINUTES

//Pain mood
/datum/mood_event/painbad
	description = span_danger("I am feeling so much pain!")
	mood_change = -6
	timeout = 3 MINUTES

//Saw a badly injured crewmember
/datum/mood_event/saw_injured
	description = span_danger("I have seen terrible things!")
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
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/saw_dead/good
	description = span_dead("I saw a dying creature, so nice!")
	mood_change = 2
	timeout = 5 MINUTES

//Died
/datum/mood_event/died
	description = span_dead("<b>I saw the afterlife, and I don't like it!</b>")
	mood_change = -6
	timeout = 10 MINUTES

//Bad smell
/datum/mood_event/miasma
	description = span_warning("I smell something putrid!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/miasma/harsh
	description = span_danger("This rotten stench is unbearable!")
	mood_change = -6

/datum/mood_event/shit
	description = span_warning("I smell something shitty!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/shit/harsh
	description = span_danger("This shitty stench is awful!")
	mood_change = -6

/datum/mood_event/retarded
	description = span_warning("I smell something retarded!")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/retardedt/harsh
	description = span_danger("This retarded stench is awful!")
	mood_change = -4

//WORST smell
/datum/mood_event/incredible_gas
	description = span_infection("Smells like someone ripped ass!")
	mood_change = -4
	timeout = 1 MINUTES

/datum/mood_event/incredible_gas/harsh
	description = span_infection("Smells like rotten eggs and garbage!")
	mood_change = -8

/datum/mood_event/urinepoo_gas
	description = span_infection("Smells like someone pissed off and shitted off!")
	mood_change = -5
	timeout = 1 MINUTES

/datum/mood_event/urinepoo_gas/harsh
	description = span_infection("DIGUSTING! SMELLS FUCKING DISGUSTING!")
	mood_change = -9

/datum/mood_event/sleeptime_gas
	description = span_infection("Delicious pancakes, warm cozy smell.")
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/sleeptime_gas/harsh
	description = span_infection("So good. So good smell...")
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
	description = span_userdanger("There is a gun pointed at me!")
	mood_change = -4

//Embedded thing
/datum/mood_event/embedded
	mood_change = -4