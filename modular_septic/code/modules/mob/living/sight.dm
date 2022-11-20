/// Proc to modify the value of num_hands and hook behavior associated to this event.
/mob/living/proc/set_num_eyes(new_value)
	if(num_eyes == new_value)
		return
	. = num_eyes
	num_eyes = new_value

/// Proc to modify the value of usable_hands and hook behavior associated to this event.
/mob/living/proc/set_usable_eyes(new_value)
	if(usable_eyes == new_value)
		return
	. = usable_eyes
	usable_eyes = new_value
