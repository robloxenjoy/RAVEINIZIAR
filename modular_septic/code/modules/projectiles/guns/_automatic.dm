/obj/item/gun/ballistic/automatic
	select = 3
	/// The sound effect for switching your gun back to semi-automatic
	var/fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_semi_vary = FALSE
	var/fireselector_semi_volume = 90
	/// The sound effect for switching your gun to burst fire
	var/fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_burst_vary = FALSE
	var/fireselector_burst_volume = 90
	/// The sound effect for switching your gun to full auto fire
	var/fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_auto_vary = FALSE
	var/fireselector_auto_volume = 90
	/// Size of the burst when burst firing
	var/burst_size_toggled
	var/fire_delay_toggled
	/// Size of the burst when auto firing
	var/burst_size_auto
	var/fire_delay_auto

/obj/item/gun/ballistic/automatic/Initialize(mapload)
	. = ..()
	if(isnull(burst_size_toggled))
		burst_size_toggled = initial(burst_size)
	if(isnull(fire_delay_toggled))
		fire_delay_toggled = initial(fire_delay)
	if(isnull(burst_size_auto))
		burst_size_auto = initial(burst_size)
	if(isnull(fire_delay_auto))
		fire_delay_auto = initial(fire_delay)

/obj/item/gun/ballistic/automatic/initialize_full_auto()
	if(!full_auto)
		return FALSE
	AddComponent(/datum/component/automatic_fire, fire_delay_auto)

/obj/item/gun/ballistic/automatic/burst_select()
	var/mob/living/carbon/human/user = usr
	var/datum/component/automatic_fire/full_auto = GetComponent(/datum/component/automatic_fire)
	if(full_auto)
		switch(select)
			// semi auto
			if(1)
				if(burst_size_toggled != initial(burst_size))
					select = 2
				else
					select = 3
			// burst fire
			if(2)
				select = 3
			// full auto
			if(3)
				select = 1
	else if(burst_size_toggled != initial(burst_size))
		select = !select
	// how did this happen?
	else
		return
	switch(select)
		if(1)
			burst_size = 1
			fire_delay = initial(fire_delay)
			to_chat(user, span_notice("I switch [src] to semi-automatic."))
			playsound(user, fireselector_semi, fireselector_semi_volume, fireselector_semi_vary)
		if(2)
			burst_size = burst_size_toggled
			fire_delay = fire_delay_toggled
			to_chat(user, span_notice("I switch [src] to [burst_size]-round burst."))
			playsound(user, fireselector_burst, fireselector_burst, fireselector_burst_vary)
		if(3)
			burst_size = burst_size_auto
			fire_delay = fire_delay_auto
			to_chat(user, span_notice("I switch [src] to automatic."))
			playsound(user, fireselector_semi, fireselector_auto_volume, fireselector_semi_vary)

	update_appearance()
	update_action_buttons()
