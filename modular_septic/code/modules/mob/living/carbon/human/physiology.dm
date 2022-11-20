/datum/physiology
	var/datum/subarmor/subarmor // internal armor datum
	var/thirst_mod = 1 //% of thirst rate taken per tick.
	var/arousal_mod = 1 //% of arousal rate taken per tick

/datum/physiology/New()
	. = ..()
	subarmor = new
