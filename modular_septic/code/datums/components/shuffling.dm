/datum/component/shuffling
	var/list/override_squeak_sounds

	var/squeak_chance = 100
	var/volume = 30

	/// We only squeak every step_delay steps
	var/steps = 0
	/// How many steps before squeaking
	var/step_delay = 2

	/// Extra-range for this component's sound
	var/sound_extra_range = -1
	/// when sounds start falling off for the squeak
	var/sound_falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE
	/// Sound exponent for squeak. Defaults to 10 as squeaking is loud and annoying enough.
	var/sound_falloff_exponent = 10

	/// Normal squeaking sounds when we have no override, associated with pick weight
	var/static/list/default_squeak_sounds = list(
		'sound/items/toysqueak1.ogg' = 1,
		'sound/items/toysqueak2.ogg' = 1,
		'sound/items/toysqueak3.ogg' = 1,
	)
	/// What we set connect_loc to if parent is a movable
	var/static/list/movable_connections = list(
		COMSIG_ATOM_ENTERED = .proc/play_squeak_entered,
		COMSIG_MOVABLE_MOVED = .proc/play_squeak_loc_moved,
	)

/datum/component/shuffling/Initialize(custom_sounds, volume_override, chance_override, step_delay_override, extrarange, falloff_exponent, fallof_distance)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_BLOB_ACT, COMSIG_ATOM_HULK_ATTACK, COMSIG_PARENT_ATTACKBY), PROC_REF(play_squeak))
	RegisterSignal(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT, COMSIG_PROJECTILE_BEFORE_FIRE), PROC_REF(play_squeak))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(play_squeak_moved))
	if(isitem(parent))
		RegisterSignal(parent, list(COMSIG_ITEM_ATTACK, COMSIG_ITEM_ATTACK_OBJ, COMSIG_ITEM_HIT_REACT), PROC_REF(play_squeak))
		if(istype(parent, /obj/item/clothing/shoes || /obj/item/clothing/suit))
			RegisterSignal(parent, COMSIG_SHOES_STEP_ACTION, PROC_REF(step_squeak))
	AddComponent(/datum/component/connect_loc_behalf, parent, movable_connections)

	override_squeak_sounds = custom_sounds
	if(chance_override)
		squeak_chance = chance_override
	if(volume_override)
		volume = volume_override
	if(isnum(step_delay_override))
		step_delay = step_delay_override
	if(isnum(extrarange))
		sound_extra_range = extrarange
	if(isnum(falloff_exponent))
		sound_falloff_exponent = falloff_exponent
	if(isnum(fallof_distance))
		sound_falloff_distance = fallof_distance

/datum/component/shuffling/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_BLOB_ACT, COMSIG_ATOM_HULK_ATTACK, COMSIG_PARENT_ATTACKBY))
	UnregisterSignal(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT, COMSIG_PROJECTILE_BEFORE_FIRE))
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	qdel(GetComponent(/datum/component/connect_loc_behalf))

/datum/component/shuffling/proc/play_squeak()
	SIGNAL_HANDLER

	if(!prob(squeak_chance))
		return
	var/atom/atom_parent = parent
	if(!override_squeak_sounds)
		playsound(atom_parent, pick_weight(default_squeak_sounds), volume, TRUE, sound_extra_range, sound_falloff_exponent, falloff_distance = sound_falloff_distance)
	else
		playsound(atom_parent, pick_weight(override_squeak_sounds), volume, TRUE, sound_extra_range, sound_falloff_exponent, falloff_distance = sound_falloff_distance)

/datum/component/shuffling/proc/step_squeak()
	SIGNAL_HANDLER

	steps++
	if(steps >= step_delay)
		play_squeak()
		steps = 0

/datum/component/shuffling/proc/play_squeak_moved(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	if((mover.movement_type & (FLYING|FLOATING)) || !mover.has_gravity())
		return
	step_squeak()

/datum/component/shuffling/proc/play_squeak_loc_moved(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	if((mover.movement_type & (FLYING|FLOATING)) || !mover.has_gravity())
		return
	if(isitem(parent))
		if(!isliving(mover))
			return
		var/mob/living/living_mover = mover
		if(living_mover.is_holding(parent))
			return
	step_squeak()

/datum/component/shuffling/proc/play_squeak_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(isitem(arrived))
		var/obj/item/arrived_item = arrived
		if(arrived_item.item_flags & ABSTRACT)
			return
	if(arrived.movement_type & (FLYING|FLOATING) || !arrived.has_gravity())
		return
	var/atom/current_parent = parent
	if(isturf(current_parent?.loc))
		play_squeak()
