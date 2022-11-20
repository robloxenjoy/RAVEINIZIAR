/atom/movable/liquid
	name = "liquid"
	desc = "It's a liquid, how incredibly observant you are."
	icon = 'modular_septic/icons/effects/liquids/liquid.dmi'
	icon_state = "liquid-0"
	base_icon_state = "liquid"
	color = "#DDDDFF"
	plane = FLOOR_PLANE
	layer = LIQUID_LAYER

	anchored = TRUE
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG

	//For being on fire
	light_range = 0
	light_power = 1
	light_color = LIGHT_COLOR_FIRE

	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_LIQUID)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_LIQUID)

	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	var/turf/my_turf
	var/liquid_height = 1
	var/only_big_diffs = 1
	var/has_cached_share = FALSE
	var/attrition = 0
	var/immutable = FALSE
	var/no_effects = FALSE
	var/fire_state = LIQUID_FIRE_STATE_NONE
	var/liquid_state = LIQUID_STATE_PUDDLE

	var/list/starting_mixture
	var/list/reagent_list = list()
	var/total_reagents = 0
	var/temperature = T20C

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/movable_entered,
		COMSIG_TURF_MOB_FALL = .proc/mob_fall,
	)

/atom/movable/liquid/Initialize(mapload)
	. = ..()
	if(!SSliquids)
		stack_trace("Liquid movable created with the liquids sybsystem not yet initialized at [loc]!")
		return INITIALIZE_HINT_QDEL
	if(isspaceturf(my_turf))
		return INITIALIZE_HINT_QDEL
	if(!immutable)
		my_turf = get_turf(loc)
		if(!istype(my_turf))
			stack_trace("Liquid movable created inside non-turf [my_turf]!")
			return INITIALIZE_HINT_QDEL
		if(my_turf.liquids)
			stack_trace("Redundant liquid movable created at [my_turf]!")
			return INITIALIZE_HINT_QDEL
		if(SEND_SIGNAL(my_turf, COMSIG_TURF_LIQUIDS_CREATION, src) & COMPONENT_NO_LIQUID_CREATION)
			return INITIALIZE_HINT_QDEL
		AddElement(/datum/element/connect_loc, loc_connections)
		AddComponent(/datum/component/footstep_changer, FOOTSTEP_WATER)
		SSliquids.add_active_turf(my_turf)

	if(length(starting_mixture))
		reagent_list = starting_mixture.Copy()
		total_reagents = 0
		for(var/key in reagent_list)
			total_reagents += reagent_list[key]
		calculate_height()
		set_color_from_reagents()
	update_liquid_vis()

	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)

/atom/movable/liquid/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	if(immutable)
		stack_trace("Something has force destroyed an immutable liquid movable at [my_turf].")
	RemoveElement(/datum/element/connect_loc, loc_connections)
	if(my_turf)
		UnregisterSignal(my_turf, list(COMSIG_ATOM_ENTERED, COMSIG_TURF_MOB_FALL))
		my_turf.liquids_group?.remove_from_group(my_turf)
		SSliquids.evaporation_queue -= my_turf
		SSliquids.processing_fire -= my_turf
		//Turf is added because it could invoke a change to neighboring liquids
		SSliquids.add_active_turf(my_turf)
		my_turf.liquids = null
		my_turf = null
	QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/atom/movable/liquid/forceMove(atom/destination, forced = FALSE)
	if(forced)
		return ..()
	return FALSE

/atom/movable/liquid/singularity_act()
	qdel(src)

/atom/movable/liquid/singularity_pull(obj/singularity/S, current_size)
	return

/atom/movable/liquid/ex_act(severity, target)
	//minecraft reference
	return

/atom/movable/liquid/fire_act(exposed_temperature, exposed_volume)
	if(!fire_state)
		if(check_fire(TRUE))
			SSliquids.processing_fire[my_turf] = TRUE
			return TRUE
	return FALSE

/atom/movable/liquid/onShuttleMove()
	return

/atom/movable/liquid/return_temperature()
	return temperature

/atom/movable/liquid/experience_pressure_difference(pressure_difference, direction, pressure_resistance_prob_delta)
	return

/atom/movable/liquid/has_gravity(turf/T)
	return FALSE

/atom/movable/liquid/proc/check_fire(hotspotted = FALSE)
	var/my_burn_power = get_burn_power(hotspotted)
	if(!my_burn_power)
		if(fire_state)
			//Set state to 0
			set_fire_state(LIQUID_FIRE_STATE_NONE)
		return FALSE
	//Calculate appropriate state
	var/new_state = LIQUID_FIRE_STATE_SMALL
	switch(my_burn_power)
		if(0 to 7)
			new_state = LIQUID_FIRE_STATE_SMALL
		if(7 to 8)
			new_state = LIQUID_FIRE_STATE_MILD
		if(8 to 9)
			new_state = LIQUID_FIRE_STATE_MEDIUM
		if(9 to 10)
			new_state = LIQUID_FIRE_STATE_HUGE
		if(10 to INFINITY)
			new_state = LIQUID_FIRE_STATE_INFERNO

	if(fire_state != new_state)
		set_fire_state(new_state)

	return TRUE

/atom/movable/liquid/proc/set_fire_state(new_state)
	fire_state = new_state
	switch(fire_state)
		if(LIQUID_FIRE_STATE_NONE)
			set_light_range(initial(light_range))
		if(LIQUID_FIRE_STATE_SMALL)
			set_light_range(LIGHT_RANGE_FIRE)
		if(LIQUID_FIRE_STATE_MILD)
			set_light_range(LIGHT_RANGE_FIRE)
		if(LIQUID_FIRE_STATE_MEDIUM)
			set_light_range(LIGHT_RANGE_FIRE)
		if(LIQUID_FIRE_STATE_HUGE)
			set_light_range(LIGHT_RANGE_FIRE)
		if(LIQUID_FIRE_STATE_INFERNO)
			set_light_range(LIGHT_RANGE_FIRE)
	update_light()
	update_liquid_vis()

/atom/movable/liquid/proc/get_burn_power(hotspotted = FALSE)
	//We are not on fire and werent ignited by a hotspot exposure, no fire pls
	if(!hotspotted && !fire_state)
		return FALSE
	var/total_burn_power = 0
	var/datum/reagent/reagent //Faster declaration
	for(var/reagent_type in reagent_list)
		reagent = reagent_type
		var/burn_power = initial(reagent.liquid_fire_power)
		if(burn_power)
			total_burn_power += burn_power * reagent_list[reagent_type]
	if(!total_burn_power)
		return FALSE
	//We get burn power per unit
	total_burn_power /= total_reagents
	if(total_burn_power <= REQUIRED_FIRE_POWER_PER_UNIT)
		return FALSE
	//Finally, we burn
	return total_burn_power

/atom/movable/liquid/proc/process_fire()
	if(!fire_state)
		SSliquids.processing_fire -= my_turf
	var/old_state = fire_state
	if(!check_fire())
		SSliquids.processing_fire -= my_turf
	//Try spreading
	//If an extinguisher made our fire smaller, dont spread, else it's too hard to put out
	if(fire_state == old_state)
		var/turf/adjacent_cell //faster declaration
		for(var/neighbor in my_turf.atmos_adjacent_turfs)
			adjacent_cell = neighbor
			if(adjacent_cell.liquids && !adjacent_cell.liquids.fire_state && adjacent_cell.liquids.check_fire(TRUE))
				SSliquids.processing_fire[adjacent_cell] = TRUE
	//Burn our resources
	var/burn_rate = 0 //Faster declaration
	var/datum/reagent/reagent //Faster declaration
	for(var/reagent_type in reagent_list)
		reagent = reagent_type
		burn_rate = initial(reagent.liquid_fire_burnrate)
		if(burn_rate)
			var/amt = reagent_list[reagent_type]
			if(burn_rate >= amt)
				reagent_list -= reagent_type
				total_reagents -= amt
			else
				reagent_list[reagent_type] -= burn_rate
				total_reagents -= burn_rate

	my_turf.hotspot_expose((T20C+50) + (50*fire_state), 125)
	var/atom/atom //faster declaration
	for(var/A in my_turf.contents)
		atom = A
		if(!QDELETED(atom))
			atom.fire_act((T20C+50) + (50*fire_state), 125)

	if(reagent_list.len == 0)
		qdel(src, TRUE)
	else
		has_cached_share = FALSE
		if(!my_turf.liquids_group)
			calculate_height()
			set_color_from_reagents()

/atom/movable/liquid/proc/process_evaporation()
	if(immutable)
		SSliquids.evaporation_queue -= my_turf
		return
	//We're in a group. dont try and evaporate
	if(my_turf.liquids_group)
		SSliquids.evaporation_queue -= my_turf
		return
	if(liquid_state != LIQUID_STATE_PUDDLE)
		SSliquids.evaporation_queue -= my_turf
		return
	//See if any of our reagents evaporates
	var/any_change = FALSE
	var/datum/reagent/reagent //Faster declaration
	for(var/reagent_type in reagent_list)
		//We evaporate - bye bye
		reagent = reagent_type
		var/evaporation_rate = initial(reagent.liquid_evaporation_rate)
		if(evaporation_rate)
			var/evaporated = min(evaporation_rate, reagent_list[reagent_type])
			total_reagents -= evaporated
			reagent_list[reagent_type] -= evaporated
			if(reagent_list[reagent_type] <= 0)
				reagent_list -= reagent_type
			any_change = TRUE
	if(!any_change)
		SSliquids.evaporation_queue -= my_turf
		return
	//No total reagents. Commit death
	if(!length(reagent_list))
		qdel(src, TRUE)
	//Reagents still left - Recalculte height and color
	else
		has_cached_share = FALSE
		calculate_height()
		set_color_from_reagents()

/atom/movable/liquid/proc/set_new_liquid_state(new_state)
	liquid_state = new_state
	cut_overlays()
	if(no_effects)
		return
	var/image/stage_overlay = image('modular_septic/icons/effects/liquids/liquid_overlays.dmi', src, "stage[liquid_state-1]_bottom")
	stage_overlay.plane = GAME_PLANE_UPPER
	stage_overlay.layer = ABOVE_MOB_LAYER
	var/image/stage_underlay = image('modular_septic/icons/effects/liquids/liquid_overlays.dmi', src, "stage[liquid_state-1]_top")
	stage_underlay.plane = GAME_PLANE
	stage_underlay.layer = BELOW_MOB_LAYER
	add_overlay(stage_overlay)
	add_overlay(stage_underlay)

/atom/movable/liquid/proc/update_liquid_vis()
	if(no_effects)
		return
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/liquids/liquid_overlays.dmi', "shine", layer+0.01, plane, add_appearance_flags = RESET_COLOR|RESET_ALPHA)
	//Add a fire overlay too
	switch(fire_state)
		if(LIQUID_FIRE_STATE_SMALL, LIQUID_FIRE_STATE_MILD)
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/liquids/liquid_overlays.dmi', "fire_small", LIQUID_FIRE_LAYER, GAME_PLANE_BLOOM)
		if(LIQUID_FIRE_STATE_MEDIUM)
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/liquids/liquid_overlays.dmi', "fire_medium", LARGE_LIQUID_FIRE_LAYER, GAME_PLANE_UPPER_BLOOM)
		if(LIQUID_FIRE_STATE_HUGE, LIQUID_FIRE_STATE_INFERNO)
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/liquids/liquid_overlays.dmi', "fire_big", LARGEST_LIQUID_FIRE_LAYER, GAME_PLANE_UPPER_BLOOM)

//Deletes reagents without doing any sort of interaction
/atom/movable/liquid/proc/delete_reagents_flat(flat_amount)
	if(flat_amount >= total_reagents)
		qdel(src, TRUE)
		return
	var/fraction = flat_amount/total_reagents
	for(var/reagent_type in reagent_list)
		var/amount = fraction * reagent_list[reagent_type]
		reagent_list[reagent_type] -= amount
		total_reagents -= amount
	has_cached_share = FALSE
	if(!my_turf.liquids_group)
		calculate_height()

//Takes a flat of our reagents and returns it, possibly qdeling our liquids
/atom/movable/liquid/proc/take_reagents_flat(flat_amount)
	if(immutable)
		return simulate_reagents_flat(flat_amount)
	var/datum/reagents/temporary_holder = new(10000)
	if(flat_amount >= total_reagents)
		temporary_holder.add_reagent_list(reagent_list)
		qdel(src, TRUE)
	else
		var/fraction = flat_amount/total_reagents
		var/passed_list = list()
		for(var/reagent_type in reagent_list)
			var/amount = fraction * reagent_list[reagent_type]
			reagent_list[reagent_type] -= amount
			total_reagents -= amount
			passed_list[reagent_type] = amount
		temporary_holder.add_reagent_list(passed_list)
		has_cached_share = FALSE
	temporary_holder.chem_temp = temperature
	return temporary_holder

//Returns a reagents holder with all the reagents with a higher volume than the threshold
/atom/movable/liquid/proc/simulate_reagents_threshold(amount_threshold)
	var/datum/reagents/temporary_holder = new(10000)
	var/passed_list = list()
	for(var/reagent_type in reagent_list)
		var/amount = reagent_list[reagent_type]
		if(amount_threshold && amount < amount_threshold)
			continue
		passed_list[reagent_type] = amount
	temporary_holder.add_reagent_list(passed_list)
	temporary_holder.chem_temp = temperature
	return temporary_holder

//Returns a flat of our reagents without any effects on the liquids
/atom/movable/liquid/proc/simulate_reagents_flat(flat_amount)
	var/datum/reagents/temporary_holder = new(10000)
	if(flat_amount >= total_reagents)
		temporary_holder.add_reagent_list(reagent_list)
	else
		var/fraction = flat_amount/total_reagents
		var/passed_list = list()
		for(var/reagent_type in reagent_list)
			var/amount = fraction * reagent_list[reagent_type]
			passed_list[reagent_type] = amount
		temporary_holder.add_reagent_list(passed_list)
	temporary_holder.chem_temp = temperature
	return temporary_holder

/atom/movable/liquid/proc/set_color_from_reagents()
	color = mix_color_from_reagent_list(reagent_list)
	return color

/atom/movable/liquid/proc/calculate_height()
	var/new_height = total_reagents/LIQUID_HEIGHT_DIVISOR
	set_height(new_height)
	var/determined_new_state
	//We add the turf height if it's possible to state calculations
	new_height =  CEILING(new_height, 1)
	switch(new_height)
		if(0 to LIQUID_ANKLES_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_PUDDLE
		if(LIQUID_ANKLES_LEVEL_HEIGHT to LIQUID_WAIST_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_ANKLES
		if(LIQUID_WAIST_LEVEL_HEIGHT to LIQUID_SHOULDERS_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_WAIST
		if(LIQUID_SHOULDERS_LEVEL_HEIGHT to LIQUID_FULLTILE_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_SHOULDERS
		if(LIQUID_FULLTILE_LEVEL_HEIGHT to INFINITY)
			determined_new_state = LIQUID_STATE_FULLTILE
	if(determined_new_state != liquid_state)
		set_new_liquid_state(determined_new_state)

/atom/movable/liquid/proc/set_height(new_height)
	var/prev_height = liquid_height
	liquid_height = new_height
	if(immutable)
		return
	if(abs(liquid_height - prev_height) >= WATER_HEIGHT_DIFFERENCE_SPLASH)
		//Splash
		if(prob(WATER_HEIGHT_DIFFERENCE_SPLASH))
			var/sound_to_play = "modular_septic/sound/liquids/wade[rand(1,4)].ogg"
			playsound(my_turf, sound_to_play, 60, 0)
		var/obj/splashy = new /obj/effect/temp_visual/liquid_splash(my_turf)
		splashy.color = color
		if(liquid_height >= LIQUID_WAIST_LEVEL_HEIGHT)
			//Push things into some direction, like space wind
			var/turf/dest_turf
			var/last_height = liquid_height
			var/turf/adjacent_cell //faster declaration
			for(var/neighbor in my_turf.atmos_adjacent_turfs)
				adjacent_cell = neighbor
				//Automatic winner
				if(!adjacent_cell.liquids)
					dest_turf = adjacent_cell
					break
				else if(adjacent_cell.liquids.liquid_height < last_height)
					dest_turf = adjacent_cell
					last_height = adjacent_cell.liquids.liquid_height
			if(dest_turf)
				var/direction = get_dir(my_turf, dest_turf)
				var/atom/movable/movable
				for(var/thing in my_turf)
					movable = thing
					if(movable.anchored || movable.pulledby || isdead(movable) || iscameramob(movable) || isliquid(movable) || (movable.move_resist > move_force))
						continue
					else if((dest_turf.z != my_turf.z) && !movable.can_zTravel(dest_turf, direction))
						continue
					if(ismob(movable))
						var/mob/mob_movable = movable
						if(mob_movable.buckled)
							continue
					if(iscarbon(movable))
						var/mob/living/carbon/carbon = movable
						if(!(carbon.shoes?.clothing_flags & NOSLIP))
							carbon.Move(dest_turf, direction)
							if(prob(60) && carbon.body_position != LYING_DOWN)
								to_chat(carbon, span_userdanger("The current knocks me down!"))
								carbon.CombatKnockdown(25, 5 SECONDS, 5 SECONDS)
					else
						movable.Move(dest_turf, direction)
						if(isitem(movable))
							var/obj/item/messy = movable
							messy.do_messy(duration = 4)
	return liquid_height

/atom/movable/liquid/proc/movable_entered(datum/source, atom/movable/movable)
	SIGNAL_HANDLER

	var/turf/source_turf = source
	if(isdead(movable) || iscameramob(movable))
		return //ghosts, camera eyes, etc - don't make water splashy splashy
	if(liquid_state >= LIQUID_STATE_ANKLES)
		if(prob(30))
			var/sound_to_play = "modular_septic/sound/liquids/wade[rand(1,4)].ogg"
			playsound(source_turf, sound_to_play, 50, 0)
		var/mob/living/living_movable = movable
		if(istype(living_movable))
			living_movable.apply_status_effect(/datum/status_effect/liquids_affected)
	else if(isliving(movable))
		var/mob/living/living_movable = movable
		if(prob(5) && !(living_movable.movement_type & FLYING | FLOATING))
			living_movable.slip(3 SECONDS, source_turf, NO_SLIP_WHEN_WALKING, 2 SECONDS)
	if(fire_state)
		movable.fire_act((T20C+50) + (50*fire_state), 125)

/atom/movable/liquid/proc/mob_fall(datum/source, mob/fell)
	var/turf/source_turf = source
	if(liquid_state >= LIQUID_STATE_ANKLES && source_turf.has_gravity(source_turf))
		playsound(source_turf, "modular_septic/sound/liquids/splash[rand(1, 2)].ogg", 50, 0)
		if(iscarbon(fell))
			var/mob/living/carbon/carbon = fell
			if(carbon.wear_mask && carbon.wear_mask.flags_cover & MASKCOVERSMOUTH)
				to_chat(carbon, span_userdanger("I fall in the liquid!"))
			else
				var/datum/reagents/temporary_holder = take_reagents_flat(CHOKE_REAGENTS_INGEST_ON_FALL_AMOUNT)
				temporary_holder.trans_to(carbon, temporary_holder.total_volume, methods = INGEST)
				qdel(temporary_holder)
				carbon.losebreath += 2
				carbon.agony_gargle()
				to_chat(carbon, span_userdanger("I fall in and swallow some liquid!"))
		else
			to_chat(fell, span_userdanger("I fall in the liquid!"))

//Exposes my_turf with simulated reagents
/atom/movable/liquid/proc/expose_my_turf()
	var/datum/reagents/temporary_holder = simulate_reagents_threshold(LIQUID_REAGENT_THRESHOLD_TURF_EXPOSURE)
	temporary_holder.expose(my_turf, TOUCH, temporary_holder.total_volume)
	qdel(temporary_holder)

/atom/movable/liquid/proc/change_to_new_turf(turf/new_turf)
	if(new_turf.liquids)
		stack_trace("Liquids tried to change to turf [new_turf], that already has liquids on it!")
		return FALSE

	UnregisterSignal(my_turf, list(COMSIG_ATOM_ENTERED, COMSIG_TURF_MOB_FALL))
	if(SSliquids.active_turfs[my_turf])
		SSliquids.active_turfs -= my_turf
		SSliquids.active_turfs[new_turf] = TRUE
	if(SSliquids.evaporation_queue[my_turf])
		SSliquids.evaporation_queue -= my_turf
		SSliquids.evaporation_queue[new_turf] = TRUE
	if(SSliquids.processing_fire[my_turf])
		SSliquids.processing_fire -= my_turf
		SSliquids.processing_fire[new_turf] = TRUE
	my_turf.liquids = null
	my_turf = new_turf
	new_turf.liquids = src
	loc = new_turf
	RegisterSignal(my_turf, COMSIG_ATOM_ENTERED, .proc/movable_entered)
	RegisterSignal(my_turf, COMSIG_TURF_MOB_FALL, .proc/mob_fall)

//STRICTLY FOR IMMUTABLE USE
/atom/movable/liquid/proc/add_turf(turf/added_turf)
	added_turf.liquids = src
	added_turf.vis_contents += src
	SSliquids.active_immutables[added_turf] = TRUE
	RegisterSignal(added_turf, COMSIG_ATOM_ENTERED, .proc/movable_entered)
	RegisterSignal(added_turf, COMSIG_TURF_MOB_FALL, .proc/mob_fall)

/atom/movable/liquid/proc/remove_turf(turf/removed_turf)
	SSliquids.active_immutables -= removed_turf
	removed_turf.liquids = null
	removed_turf.vis_contents -= src
	UnregisterSignal(removed_turf, list(COMSIG_ATOM_ENTERED, COMSIG_TURF_MOB_FALL))
