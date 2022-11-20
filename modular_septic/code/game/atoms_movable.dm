/atom/movable/Initialize(mapload)
	. = ..()
	if(isnull(min_throwforce))
		min_throwforce = throwforce
	// god has forced me to not put this in /atom/proc/Initialize()
	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon, frill_uses_icon_state, upper_frill_plane, upper_frill_layer, lower_frill_plane, lower_frill_layer)

/atom/movable/throw_at(atom/target, range, speed, mob/thrower, spin, diagonals_first, datum/callback/callback, force, gentle, quickstart)
	spin = FALSE
	return ..()

/atom/movable/can_zFall(turf/source, levels = 1, turf/target, direction)
	if(!direction)
		direction = DOWN
	if(!source)
		source = get_turf(src)
		if(!source)
			return FALSE
	if(!target)
		target = get_step_multiz(source, direction)
		if(!target)
			return FALSE
	return !(movement_type & FLYING) && !(movement_type & FLOATING) && has_gravity(source) && !throwing

/atom/movable/onZImpact(turf/T, levels)
	var/atom/highest = T
	for(var/atom/A as anything in T.contents)
		if(!A.density)
			continue
		if(isobj(A) || ismob(A))
			if(A.layer > highest.layer)
				highest = A
	return TRUE

/**
 * This returns the damage for one given thrown attack with this object, taking into account the base variation and
 * the strength driven variation.
 * Damage will never exceed max_throwforce and will never be below zero.
 *
 * Formulas:
 * Minimum damage = min_throwforce + (min_throwforce_strength * strength_value)
 * Maximum damage = throwforce + (throwforce_strength * strength_value)
 */
/atom/movable/proc/get_throwforce(mob/living/user, strength_value = ATTRIBUTE_MIDDLING)
	var/final_throwforce = rand(min_throwforce*10, throwforce*10)/10
	/// Fraggots are always considered to have absolutely 0 strength
	if(!user || !HAS_TRAIT(user, TRAIT_FRAGGOT))
		var/strength_multiplier = CEILING(rand(min_throwforce_strength*10, throwforce_strength*10)/10, DAMAGE_PRECISION)
		/**
		 * If the multiplier is negative, we instead punish the dude for each point of strength below ATTRIBUTE_MASTER
		 * You really shouldn't make this possible though as it makes understanding the throw damage of an item even more insane.
		 */
		if(strength_multiplier < 0)
			final_throwforce += (strength_value - ATTRIBUTE_MASTER) * strength_multiplier
		/// Otherwise, elementary multiplier stuff
		else
			final_throwforce += strength_value * strength_multiplier

	return clamp(FLOOR(final_throwforce, DAMAGE_PRECISION), 0, max_throwforce)
