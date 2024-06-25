/datum/component/guard
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/turf/target
	var/obj/item/weapon
	var/target_overlay

/datum/component/guard/Destroy(force, silent)
	remove_target_overlay()
	if(weapon)
		weapon.guard_ready = FALSE
	return ..()

/datum/component/guard/Initialize(turf/target, obj/item/weapon)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/guarder = parent
	src.target = target
	src.weapon = weapon

	weapon.guard_ready = TRUE
	RegisterSignal(weapon, list(COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED), PROC_REF(cancel))

	guarder.visible_message(span_danger("<b>[guarder]</b> готовится сторожить!"), \
		span_danger("Я готовлю атаку!"), ignored_mobs = target)
	apply_target_overlay()

	guarder.apply_status_effect(STATUS_EFFECT_HOLDUP, guarder)

	if(get_dist(guarder, target) > 1)
		cancel()
	if(get_dist(guarder, weapon) > 0)
		cancel()
	if(!weapon.guard_ready)
		cancel()

/datum/component/guard/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(check_deescalate))
	RegisterSignal(parent, COMSIG_ATOM_ENTERED, PROC_REF(hitchungus))
	RegisterSignal(parent, list(COMSIG_LIVING_START_PULL, COMSIG_MOVABLE_BUMP), PROC_REF(check_bump))

/datum/component/guard/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(parent, COMSIG_ATOM_ENTERED)
	UnregisterSignal(parent, list(COMSIG_LIVING_START_PULL, COMSIG_MOVABLE_BUMP))

/datum/component/guard/proc/check_bump(atom/source, atom/bumper)
	var/mob/living/shooter = parent
	if(shooter.combat_mode)
		return
	shooter.visible_message(span_danger("<b>[shooter]</b> врезается в <b>[bumper]</b> и нарушает стражу!"), \
		span_danger("Я врезаюсь в <b>[bumper]</b> и нарушаю свою стражу!"), ignored_mobs = bumper)
	to_chat(bumper, span_userdanger("<b>[shooter]</b> врезается в меня и нарушает свою стражу!"))
	cancel()

/datum/component/guard/proc/check_deescalate()
	if(get_dist(parent, target) > 0)
		cancel()
		return

/datum/component/guard/proc/cancel()
	var/mob/living/guarder = parent
	guarder.visible_message(span_danger("<b>[guarder]</b> перестаёт сторожить!"), \
		span_danger("Я перестаю сторожить."), ignored_mobs = target)
	weapon.guard_ready = FALSE

	qdel(src)
	remove_target_overlay()

/datum/component/guard/proc/hitchungus(atom/movable/arrived)
	SIGNAL_HANDLER
	if(!isliving(arrived))
		return
	var/mob/living/carbon/human/guarder = parent
	var/mob/living/walker = arrived
	if(istype(walker))
		SET_HARM_INTENT(guarder)
		guarder.ClickOn(walker)
		cancel()

/datum/component/guard/proc/apply_target_overlay()
	target_overlay = /obj/effect/combat
	new /obj/effect/combat(get_turf(target))

/datum/component/guard/proc/remove_target_overlay()
	if(!target_overlay)
		return
	qdel(target_overlay)
