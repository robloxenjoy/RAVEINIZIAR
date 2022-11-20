/obj/item/organ/external/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_EXTERNAL_WINGS = 100)
	icon_state = "wings"
	dna_block = DNA_WINGS_BLOCK
	mutantpart_key = "wings"
	mutantpart_colored = TRUE
	mutantpart_info = list(MUTANT_INDEX_NAME = "Bat", MUTANT_INDEX_COLOR = list("335533"))
	///The flight action object
	var/datum/action/innate/flight/fly
	///Whether or not we are currently flying
	var/is_flying = FALSE
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight = FALSE
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open = FALSE
	///Whether an openable wing is currently opened
	var/is_open = FALSE
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight = FALSE

/obj/item/organ/external/wings/on_life(delta_time, times_fired)
	. = ..()
	if(!is_flying)
		return
	handle_flight(owner)

/obj/item/organ/external/wings/proc/open_wings()
	is_open = TRUE
	owner?.update_body()

/obj/item/organ/external/wings/proc/close_wings()
	is_open = FALSE
	owner?.update_body()

///Called on_life() - Handle flight code and check if we're still flying
/obj/item/organ/external/wings/proc/handle_flight(mob/living/carbon/human/human)
	if(human.movement_type & ~FLYING)
		return FALSE
	if(!can_fly(human))
		toggle_flight(human)
		return FALSE
	return TRUE

/obj/item/organ/external/wings/proc/toggle_flight(mob/living/carbon/human/human)
	if(!HAS_TRAIT_FROM(human, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT))
		human.physiology.stun_mod *= 2
		ADD_TRAIT(human, TRAIT_NO_FLOATING_ANIM, SPECIES_FLIGHT_TRAIT)
		ADD_TRAIT(human, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT)
		passtable_on(human, SPECIES_FLIGHT_TRAIT)
		open_wings()
	else
		human.physiology.stun_mod *= 0.5
		REMOVE_TRAIT(human, TRAIT_NO_FLOATING_ANIM, SPECIES_FLIGHT_TRAIT)
		REMOVE_TRAIT(human, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT)
		passtable_off(human, SPECIES_FLIGHT_TRAIT)
		close_wings()

///Check if we're still eligible for flight (wings covered, atmosphere too thin, etc)
/obj/item/organ/external/wings/proc/can_fly(mob/living/carbon/human/human)
	if(!granted_flight && !(human.dna.species.flying_species))
		return FALSE
	if((human.stat >= UNCONSCIOUS) || (human.body_position == LYING_DOWN))
		return FALSE
	//Jumpsuits have tail holes, so it makes sense they have wing holes too
	if(human.wear_suit && ((human.wear_suit.flags_inv & HIDEJUMPSUIT) && (!human.wear_suit.species_exception || !is_type_in_list(src, human.wear_suit.species_exception))))
		to_chat(human, span_warning("My suit blocks my wings from extending!"))
		return FALSE
	var/turf/location = get_turf(human)
	if(!location)
		return FALSE
	var/datum/gas_mixture/environment = location.return_air()
	if(environment && !(environment.return_pressure() > 30))
		to_chat(human, span_warning("The atmosphere is too thin for me to fly!"))
		return FALSE
	return TRUE

///Slipping but in the air?
/obj/item/organ/external/wings/proc/fly_slip(mob/living/carbon/human/human)
	var/obj/buckled_obj
	if(human.buckled)
		buckled_obj = human.buckled

	to_chat(human, span_notice("My wings spazz out and launch me!"))

	playsound(human.loc, 'sound/misc/slip.ogg', 50, TRUE, -3)

	for(var/obj/item/choking_hazard in human.held_items)
		human.accident(choking_hazard)

	var/olddir = human.dir
	human.stop_pulling()
	if(buckled_obj)
		buckled_obj.unbuckle_mob(human)
		step(buckled_obj, olddir)
	else
		var/turf/throw_me = get_ranged_target_turf(human, olddir)
		if(throw_me)
			throw_at(throw_me, 4, 3)
	return TRUE

///hud action for starting and stopping flight
/datum/action/innate/flight
	name = "Toggle Flight"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "flight"

/datum/action/innate/flight/Activate()
	var/mob/living/carbon/human/human = owner
	for(var/obj/item/organ/external/wings/wings in human.getorganslot(ORGAN_SLOT_EXTERNAL_WINGS))
		if(wings?.can_fly(human))
			if(human.movement_type & FLYING)
				to_chat(human, span_notice("I settle gently back onto the ground..."))
			else
				to_chat(human, span_notice("I beat my wings and begin to hover gently above the ground..."))
				human.set_resting(FALSE, TRUE)
			wings.toggle_flight(human)
			return
