/datum/component/bloodysoles
	bloody_shoes = list(BLOOD_STATE_HUMAN = 0, \
					BLOOD_STATE_XENO = 0, \
					BLOOD_STATE_OIL = 0, \
					BLOOD_STATE_SHIT = 0, \
					BLOOD_STATE_CUM = 0, \
					BLOOD_STATE_FEMCUM = 0, \
					BLOOD_STATE_NOT_BLOODY = 0)

/datum/component/bloodysoles/share_blood(obj/effect/decal/cleanable/pool)
	last_blood_state = pool.blood_state

	// Share the blood between our boots and the blood pool
	var/total_bloodiness = pool.bloodiness + bloody_shoes[last_blood_state]

	// We can however be limited by how much blood we can hold
	var/new_our_bloodiness = min(BLOOD_ITEM_MAX, total_bloodiness / 2)

	bloody_shoes[last_blood_state] = new_our_bloodiness
	pool.bloodiness = total_bloodiness - new_our_bloodiness // Give the pool the remaining blood incase we were limited

	if(HAS_TRAIT(parent_atom, TRAIT_LIGHT_STEP)) //the character is agile enough to don't mess their clothing and hands just from one blood splatter at floor
		return TRUE

	if(last_blood_state == BLOOD_STATE_SHIT)
		parent_atom.add_shit_DNA(pool.return_shit_DNA())
	else if(last_blood_state == BLOOD_STATE_CUM)
		parent_atom.add_cum_DNA(pool.return_cum_DNA())
	else if(last_blood_state == BLOOD_STATE_FEMCUM)
		parent_atom.add_femcum_DNA(pool.return_femcum_DNA())
	else
		parent_atom.add_blood_DNA(pool.return_blood_DNA())
	update_icon()

/datum/component/bloodysoles/on_moved(datum/source, OldLoc, Dir, Forced)
	if(bloody_shoes[last_blood_state] == 0)
		return
	if(QDELETED(wielder) || is_obscured())
		return
	if(wielder.body_position == LYING_DOWN || !wielder.has_gravity(wielder.loc))
		return

	var/half_our_blood = bloody_shoes[last_blood_state] / 2

	// Add footprints in old loc if we have enough cream
	var/footprint_type = /obj/effect/decal/cleanable/blood/footprints
	switch(last_blood_state)
		if(BLOOD_STATE_SHIT)
			footprint_type = /obj/effect/decal/cleanable/blood/footprints/shit
		if(BLOOD_STATE_CUM)
			footprint_type = /obj/effect/decal/cleanable/blood/footprints/cum
		if(BLOOD_STATE_FEMCUM)
			footprint_type = /obj/effect/decal/cleanable/blood/footprints/femcum
	if(half_our_blood >= BLOOD_FOOTPRINTS_MIN)
		var/turf/oldLocTurf = get_turf(OldLoc)
		var/obj/effect/decal/cleanable/blood/footprints/oldLocFP = find_pool_by_blood_state(oldLocTurf, footprint_type)
		if(oldLocFP)
			// Footprints found in the tile we left, add us to it
			add_parent_to_footprint(oldLocFP)
			if (!(oldLocFP.exited_dirs & wielder.dir))
				oldLocFP.exited_dirs |= wielder.dir
				oldLocFP.update_appearance()
		else if(find_pool_by_blood_state(oldLocTurf))
			// No footprints in the tile we left, but there was some other blood pool there. Add exit footprints on it
			bloody_shoes[last_blood_state] -= half_our_blood
			update_icon()

			oldLocFP = new footprint_type(oldLocTurf)
			if(!QDELETED(oldLocFP)) ///prints merged
				oldLocFP.blood_state = last_blood_state
				oldLocFP.exited_dirs |= wielder.dir
				add_parent_to_footprint(oldLocFP)
				oldLocFP.bloodiness = half_our_blood
				switch(last_blood_state)
					if(BLOOD_STATE_SHIT)
						oldLocFP.add_shit_DNA(parent_atom.return_shit_DNA())
					if(BLOOD_STATE_CUM)
						oldLocFP.add_cum_DNA(parent_atom.return_cum_DNA())
					if(BLOOD_STATE_FEMCUM)
						oldLocFP.add_femcum_DNA(parent_atom.return_femcum_DNA())
					else
						oldLocFP.add_blood_DNA(parent_atom.return_blood_DNA())
				oldLocFP.update_appearance()

			half_our_blood = bloody_shoes[last_blood_state] / 2

	// If we picked up the blood on this tick in on_step_blood, don't make footprints at the same place
	if(last_pickup && last_pickup == world.time)
		return

	// Create new footprints
	if(half_our_blood >= BLOOD_FOOTPRINTS_MIN)
		bloody_shoes[last_blood_state] -= half_our_blood
		update_icon()

		var/obj/effect/decal/cleanable/blood/footprints/FP = new footprint_type(get_turf(parent_atom))
		if(!QDELETED(FP)) ///prints merged
			FP.blood_state = last_blood_state
			FP.entered_dirs |= wielder.dir
			add_parent_to_footprint(FP)
			FP.bloodiness = half_our_blood
			switch(last_blood_state)
				if(BLOOD_STATE_SHIT)
					FP.add_shit_DNA(parent_atom.return_shit_DNA())
				if(BLOOD_STATE_CUM)
					FP.add_cum_DNA(parent_atom.return_cum_DNA())
				if(BLOOD_STATE_FEMCUM)
					FP.add_femcum_DNA(parent_atom.return_femcum_DNA())
				else
					FP.add_blood_DNA(parent_atom.return_blood_DNA())
			FP.update_appearance()

/datum/component/bloodysoles/on_clean(datum/source, clean_types)
	if(!(clean_types & CLEAN_TYPE_BLOOD) || last_blood_state == BLOOD_STATE_NOT_BLOODY)
		return NONE

	bloody_shoes = list(BLOOD_STATE_HUMAN = 0, \
					BLOOD_STATE_XENO = 0, \
					BLOOD_STATE_OIL = 0, \
					BLOOD_STATE_SHIT = 0, \
					BLOOD_STATE_CUM = 0, \
					BLOOD_STATE_FEMCUM = 0, \
					BLOOD_STATE_NOT_BLOODY = 0)
	last_blood_state = BLOOD_STATE_NOT_BLOODY
	update_icon()
	return COMPONENT_CLEANED

/datum/component/bloodysoles/feet
	var/static/mutable_appearance/shitty_feet
	var/static/mutable_appearance/cummy_feet
	var/static/mutable_appearance/femcummy_feet

/datum/component/bloodysoles/feet/Initialize()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	parent_atom = parent
	wielder = parent

	if(!bloody_feet)
		bloody_feet = mutable_appearance('modular_septic/icons/effects/blood.dmi', "shoeblood", SHOES_LAYER)
	if(!shitty_feet)
		shitty_feet = mutable_appearance('modular_septic/icons/effects/blood.dmi', "shoeshit", SHOES_LAYER)
		shitty_feet.color = COLOR_BROWN_SHIT
	if(!cummy_feet)
		cummy_feet = mutable_appearance('modular_septic/icons/effects/cum.dmi', "shoecum", SHOES_LAYER)
		cummy_feet.color = COLOR_WHITE_CUM
	if(!femcummy_feet)
		femcummy_feet = mutable_appearance('modular_septic/icons/effects/femcum.dmi', "shoefemcum", SHOES_LAYER)
		femcummy_feet.color = COLOR_WHITE_FEMCUM

	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, .proc/on_clean)
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/on_moved)
	RegisterSignal(parent, COMSIG_STEP_ON_BLOOD, .proc/on_step_blood)
	RegisterSignal(parent, COMSIG_CARBON_UNEQUIP_SHOECOVER, .proc/unequip_shoecover)
	RegisterSignal(parent, COMSIG_CARBON_EQUIP_SHOECOVER, .proc/equip_shoecover)

/datum/component/bloodysoles/feet/update_icon()
	if(ishuman(wielder))
		var/mob/living/carbon/human/human = wielder
		if(NOBLOODOVERLAY in human.dna.species.species_traits)
			return
		switch(last_blood_state)
			if(BLOOD_STATE_HUMAN)
				if(bloody_shoes[BLOOD_STATE_HUMAN] > 0 && !is_obscured())
					human.remove_overlay(SHOES_LAYER)
					human.overlays_standing[SHOES_LAYER] = bloody_feet
					human.apply_overlay(SHOES_LAYER)
				else
					human.update_inv_shoes()
			if(BLOOD_STATE_SHIT)
				if(bloody_shoes[BLOOD_STATE_SHIT] > 0 && !is_obscured())
					human.remove_overlay(SHOES_LAYER)
					human.overlays_standing[SHOES_LAYER] = shitty_feet
					human.apply_overlay(SHOES_LAYER)
				else
					human.update_inv_shoes()
			if(BLOOD_STATE_CUM)
				if(bloody_shoes[BLOOD_STATE_CUM] > 0 && !is_obscured())
					human.remove_overlay(SHOES_LAYER)
					human.overlays_standing[SHOES_LAYER] = cummy_feet
					human.apply_overlay(SHOES_LAYER)
				else
					human.update_inv_shoes()
			if(BLOOD_STATE_FEMCUM)
				if(bloody_shoes[BLOOD_STATE_FEMCUM] > 0 && !is_obscured())
					human.remove_overlay(SHOES_LAYER)
					human.overlays_standing[SHOES_LAYER] = femcummy_feet
					human.apply_overlay(SHOES_LAYER)
				else
					human.update_inv_shoes()
			else
				human.update_inv_shoes()
