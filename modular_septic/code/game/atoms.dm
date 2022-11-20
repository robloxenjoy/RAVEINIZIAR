/atom/Initialize(mapload, ...)
	. = ..()
	if(uses_integrity)
		if(islist(subarmor))
			subarmor = getSubarmor(arglist(subarmor))
		else if(!subarmor)
			subarmor = getSubarmor()
		else if(!istype(subarmor, /datum/subarmor))
			stack_trace("Invalid type [subarmor.type] found in .subarmor during /atom Initialize()")

/atom/set_smoothed_icon_state(new_junction)
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, new_junction, icon_state)
	. = smoothing_junction
	smoothing_junction = new_junction
	icon_state = "[base_icon_state]-[smoothing_junction]"

// Thrown stuff only bounced in no gravity for some reason, i have fixed this blunder!
/atom/hitby(atom/movable/thrown_atom, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	SEND_SIGNAL(src, COMSIG_ATOM_HITBY, thrown_atom, skipcatch, hitpush, blocked, throwingdatum)
	if(density)
		sound_hint()
		addtimer(CALLBACK(src, .proc/hitby_react, thrown_atom, throwingdatum.speed), 2)

/atom/hitby_react(atom/movable/thrown_atom, speed = 0)
	if(QDELETED(thrown_atom) || !isturf(thrown_atom.loc) || thrown_atom.anchored)
		return
	if(isitem(thrown_atom))
		var/obj/item/item = thrown_atom
		item.undo_messy()
		item.do_messy(duration = 4)
	step(thrown_atom, get_dir(src, thrown_atom))
	if(ismob(src) || ismob(thrown_atom))
		playsound(src, 'modular_septic/sound/effects/colision_bodyalt.ogg', 65, 0)
	else
		playsound(src, pick('modular_septic/sound/effects/colision1.ogg', 'modular_septic/sound/effects/colision2.ogg', 'modular_septic/sound/effects/colision3.ogg', 'modular_septic/sound/effects/colision4.ogg'), 65, 0)

/// Used to add or reduce germ level on an atom
/atom/proc/adjust_germ_level(add_germs, minimum_germs = 0, maximum_germs = GERM_LEVEL_MAXIMUM)
	germ_level = clamp(germ_level + add_germs, minimum_germs, maximum_germs)

/// Force set the germ level
/atom/proc/set_germ_level(germs)
	var/delta = (germs - germ_level)
	return adjust_germ_level(delta)

/// Ramming into walls (TODO: Turn into element!)
/atom/proc/on_rammed(mob/living/carbon/rammer)
	return FALSE

/// Returns a hitsound for when a projectile impacts us
/atom/proc/get_projectile_hitsound(obj/projectile/projectile)
	return projectile.hitsound

/// Attempts to open the hacking interface
/atom/proc/attempt_hacking_interaction(mob/user)
	if(!hacking)
		return WIRE_INTERACTION_FAIL
	if(!user.CanReach(src))
		return WIRE_INTERACTION_FAIL
	hacking.interact(user)
	return WIRE_INTERACTION_BLOCK

/**
 * Ok so this whole proc is about finding tiles that we could in theory be connected to, and blocking off that direction right?
 * It's not perfect, and it can make mistakes, but it does a pretty good job predicting a mapper's intentions
 */
/atom/proc/auto_align(connectables_typecache, lower_priority_typecache)
	if(manual_align)
		return
	if(!connectables_typecache)
		connectables_typecache = GLOB.default_connectables
	if(!lower_priority_typecache)
		lower_priority_typecache = GLOB.lower_priority_connectables

	var/list/dirs_usable = GLOB.cardinals.Copy()
	var/list/dirs_secondary_priority = GLOB.cardinals.Copy()
	for(var/dir_to_check in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src, dir_to_check)
		if(turf_to_check.density) //Dense turfs are connectable
			dirs_usable -= dir_to_check
			continue
		for(var/atom/movable/thing_to_check in turf_to_check)
			if(is_type_in_typecache(thing_to_check, connectables_typecache))
				dirs_usable -= dir_to_check //So are things in the default typecache
				break
			if(is_type_in_typecache(thing_to_check, lower_priority_typecache))
				dirs_secondary_priority -= dir_to_check //Assuming we find nothing else, note down the secondary priority stuff

	var/dirs_avalible = length(dirs_usable)
	//Only continue if we've got ourself either a corner or a side piece. Only side pieces really work well here, since corners aren't really something we can fudge handling for
	if(dirs_avalible <= 2 && dirs_avalible != 0)
		dir = dirs_usable[1] //Just take the first dir avalible
		return
	dirs_usable &= dirs_secondary_priority //Only consider dirs we both share
	dirs_avalible = length(dirs_usable)
	if(dirs_avalible <= 2 && dirs_avalible != 0)
		dir = dirs_usable[1] //Just take the first dir avalible
		return
