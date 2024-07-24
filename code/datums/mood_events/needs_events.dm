//nutrition
/datum/mood_event/fat
	description = "<span class='warning'><B>I'm so fat...</B></span>\n" //muh fatshaming
	mood_change = -6

/datum/mood_event/wellfed
	description = "<span class='nicegreen'>Was well fed!</span>\n"
	mood_change = 8

/datum/mood_event/fed
	description = "<span class='nicegreen'>Was fed.</span>\n"
	mood_change = 5

/datum/mood_event/hungry
	description = "<span class='warning'>Would like to eat something.</span>\n"
	mood_change = -6

/datum/mood_event/starving
	description = "<span class='boldwarning'>Give me food!</span>\n"
	mood_change = -10

//charge
/datum/mood_event/supercharged
	description = "<span class='boldwarning'>I can't possibly keep all this power inside, I need to release some quick!</span>\n"
	mood_change = -10

/datum/mood_event/overcharged
	description = "<span class='warning'>I feel dangerously overcharged, perhaps I should release some power.</span>\n"
	mood_change = -4

/datum/mood_event/charged
	description = "<span class='nicegreen'>I feel the power in my veins!</span>\n"
	mood_change = 6

/datum/mood_event/lowpower
	description = "<span class='warning'>My power is running low, I should go charge up somewhere.</span>\n"
	mood_change = -6

/datum/mood_event/decharged
	description = "<span class='boldwarning'>I'm in desperate need of some electricity!</span>\n"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "<span class='warning'>I saw something disgusting.</span>\n"
	mood_change = -4

/datum/mood_event/verygross
	description = "<span class='warning'>I think I'm going to puke...</span>\n"
	mood_change = -6

/datum/mood_event/disgusted
	description = "<span class='boldwarning'>Fuck, this is disgusting...</span>\n"
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "<span class='warning'>I smelled something terrible.</span>\n"
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "<span class='warning'>This smell is fucked up!</span>\n"
	mood_change = -12

//Generic needs events
/datum/mood_event/favorite_food
	description = "<span class='nicegreen'>I really enjoyed eating this.</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/gross_food
	description = "<span class='warning'>I really don't like this food.</span>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/disgusting_food
	description = "<span class='warning'>This food was disgusting!</span>\n"
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/breakfast
	description = "<span class='nicegreen'>Nothing like a hearty breakfast to start the shift.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/nice_shower
	description = "<span class='nicegreen'>I washed myself thoroughly.</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/fresh_laundry
	description = "<span class='nicegreen'>There's nothing like the feeling of a freshly laundered jumpsuit.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES
