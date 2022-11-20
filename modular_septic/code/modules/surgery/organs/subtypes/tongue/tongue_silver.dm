/obj/item/organ/tongue/lizard/silver
	name = "silver tongue"
	desc = "A genetic branch of the high society Silver Scales that gives them their silverizing properties. To them, it is everything, and society traitors have their tongue forcibly revoked. Oddly enough, it itself is just blue."
	icon_state = "tongue-silver"
	actions_types = list(/datum/action/item_action/organ_action/statue)

/datum/action/item_action/organ_action/statue
	name = "Become Statue"
	desc = "Become an elegant silver statue. Its durability and yours are directly tied together, so make sure you're careful."
	COOLDOWN_DECLARE(ability_cooldown)

	var/obj/structure/statue/custom/statue

/datum/action/item_action/organ_action/statue/New(Target)
	. = ..()
	statue = new
	RegisterSignal(statue, COMSIG_PARENT_QDELETING, .proc/statue_destroyed)

/datum/action/item_action/organ_action/statue/Destroy()
	UnregisterSignal(statue, COMSIG_PARENT_QDELETING)
	QDEL_NULL(statue)
	return ..()

/datum/action/item_action/organ_action/statue/Trigger()
	. = ..()
	if(!iscarbon(owner))
		to_chat(owner, span_warning("Your body rejects the powers of the tongue!"))
		return
	var/mob/living/carbon/becoming_statue = owner
	if(becoming_statue.health < 1)
		to_chat(becoming_statue, span_danger("You are too weak to become a statue!"))
		return
	if(!COOLDOWN_FINISHED(src, ability_cooldown))
		to_chat(becoming_statue, span_warning("You just used the ability, wait a little bit!"))
		return
	var/is_statue = becoming_statue.loc == statue
	to_chat(becoming_statue, span_notice("You begin to [is_statue ? "break free from the statue" : "make a glorious pose as you become a statue"]!"))
	if(!do_after(becoming_statue, (is_statue ? 5 : 30), target = get_turf(becoming_statue)))
		to_chat(becoming_statue, span_warning("Your transformation is interrupted!"))
		COOLDOWN_START(src, ability_cooldown, 3 SECONDS)
		return
	COOLDOWN_START(src, ability_cooldown, 10 SECONDS)

	if(statue.name == initial(statue.name)) //statue has not been set up
		statue.name = "statue of [becoming_statue.real_name]"
		statue.desc = "statue depicting [becoming_statue.real_name]"
		statue.set_custom_materials(list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT*5))

	if(is_statue)
		statue.visible_message(span_danger("[statue] becomes animated!"))
		becoming_statue.forceMove(get_turf(statue))
		statue.moveToNullspace()
		UnregisterSignal(becoming_statue, COMSIG_MOVABLE_MOVED)
	else
		becoming_statue.visible_message(span_notice("[becoming_statue] hardens into a silver statue."), \
										span_notice("You have become a silver statue!"))
		statue.set_visuals(becoming_statue.appearance)
		statue.forceMove(get_turf(becoming_statue))
		becoming_statue.forceMove(statue)
		statue.max_integrity = becoming_statue.health
		statue.repair_damage(statue.max_integrity)
		RegisterSignal(becoming_statue, COMSIG_MOVABLE_MOVED, .proc/human_left_statue)

//somehow they used an exploit/teleportation to leave statue, lets clean up
/datum/action/item_action/organ_action/statue/proc/human_left_statue(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	statue.moveToNullspace()
	UnregisterSignal(mover, COMSIG_MOVABLE_MOVED)

/datum/action/item_action/organ_action/statue/proc/statue_destroyed(datum/source)
	to_chat(owner, span_userdanger("Your existence as a living creature snaps as your statue form crumbles!"))
	if(iscarbon(owner))
		//drop everything, just in case
		var/mob/living/carbon/dying_carbon = owner
		for(var/obj/item/dropped in dying_carbon)
			if(!dying_carbon.dropItemToGround(dropped))
				qdel(dropped)
	qdel(owner)
