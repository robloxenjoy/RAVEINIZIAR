/obj/item/bodypart/mouth
	name = "Челюсть"
	desc = "У меня нет рта, но я должен кричать."
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "jaw"
	base_icon_state = "jaw"
	attack_verb_continuous = list("bites", "munches")
	attack_verb_simple = list("bite", "munch")
	parent_body_zone = BODY_ZONE_HEAD
	body_zone = BODY_ZONE_PRECISE_MOUTH
	body_part = JAW
	limb_flags = BODYPART_EDIBLE|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_ARTERY
	max_damage = 50
	max_stamina_damage = 50
	wound_resistance = -5
	maxdam_wound_penalty = 10 // too easy to hit max damage
	stam_heal_tick = 1

	max_teeth = HUMAN_TEETH_AMOUNT

	max_cavity_item_size = WEIGHT_CLASS_SMALL
	max_cavity_volume = 2.5

	melee_hit_modifier = -2
	melee_hit_zone_modifier = -1

	throw_range = 5
	dismemberment_sounds = list('modular_septic/sound/gore/severed.ogg')
	scars_covered_by_clothes = FALSE

	cavity_name = "oral cavity"
	amputation_point_name = "лицо"
	bone_type = BONE_MOUTH
	tendon_type = TENDON_MOUTH
	artery_type = ARTERY_MOUTH

	/// Sticky tape muting us
	var/obj/item/stack/sticky_tape/tapered = null

	///Facial hair colour and style
	var/facial_hair_color = "000000"
	var/facial_hairstyle = "Shaved"
	var/hair_alpha = 255

	///Lips
	var/lip_style = null
	var/lip_color = "white"
	var/stored_lipstick_trait

/obj/item/bodypart/mouth/get_limb_icon(dropped)
	if(dropped && !isbodypart(loc))
		. = list()
		var/image/funky_anus = image('modular_septic/icons/obj/items/surgery.dmi', src, base_icon_state, BELOW_MOB_LAYER)
		funky_anus.plane = plane
		. += funky_anus

/obj/item/bodypart/mouth/attach_limb(mob/living/carbon/new_owner, special, ignore_parent_limb = FALSE)
	. = ..()
	//Handle teeth and tape stuff
	if(!.)
		return
	if(tapered)
		ADD_TRAIT(owner, TRAIT_MUTE, "tape")
	if(teeth_mod)
		teeth_mod.add_speech_modifier(new_owner)

/obj/item/bodypart/mouth/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	var/mob/living/carbon/was_owner = owner
	. = ..()
	//Handle teeth and tape stuff
	if(!.)
		return
	if(tapered)
		REMOVE_TRAIT(was_owner, TRAIT_MUTE, "tape")
	if(teeth_mod)
		teeth_mod.remove_speech_modifier()
	//Handle dental implants
	for(var/datum/action/item_action/hands_free/activate_pill/pill_action in was_owner.actions)
		pill_action.Remove(owner)
		var/obj/pill = pill_action.target
		if(pill)
			pill.forceMove(src)

/obj/item/bodypart/mouth/update_limb(dropping_limb, mob/living/carbon/source)
	. = ..()
	if(istype(loc, /obj/item/bodypart/face))
		var/obj/item/bodypart/face/face = loc
		face.update_limb(dropping_limb, source)

	if(no_update)
		return

	var/mob/living/carbon/carbon
	if(source)
		carbon = source
	else
		carbon = owner

	if(carbon)
		if(HAS_TRAIT(carbon, TRAIT_HUSK) || HAS_TRAIT(src, TRAIT_HUSK))
			facial_hairstyle = "Shaved"
			facial_hair_color = "000000"
			hair_alpha = initial(hair_alpha)
			lip_style  = null
			stored_lipstick_trait = null
		else if(!animal_origin && advanced_rendering)
			var/mob/living/carbon/human/human = carbon
			var/datum/species/species = human.dna.species

			// facial hair
			if(human.facial_hairstyle && (FACEHAIR in species.species_traits))
				facial_hairstyle = human.facial_hairstyle
				facial_hair_color = human.dna.features["mcolor"]
				hair_alpha = species.hair_alpha
			else
				facial_hairstyle = "Shaved"
				facial_hair_color = "000000"
				hair_alpha = initial(hair_alpha)

/obj/item/bodypart/mouth/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	. = ..()
	if(istype(new_limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = new_limb
		head.jaw = src

/obj/item/bodypart/mouth/Topic(href, href_list)
	. = ..()
	if(href_list["tape"])
		var/mob/living/carbon/C = usr
		if(!istype(C) || !C.canUseTopic(owner, TRUE, FALSE, FALSE, TRUE, FALSE) || owner?.wear_mask || DOING_INTERACTION_WITH_TARGET(C, owner))
			return
		if(C == owner)
			owner.visible_message(span_warning("<b>[owner]</b> desperately tries to rip \the [tapered] from their mouth!"),
								span_warning("You desperately try to rip \the [tapered] from your mouth!"))
			if(do_mob(owner, owner, 3 SECONDS))
				tapered.forceMove(get_turf(owner))
				tapered = null
				owner.visible_message(span_warning("<b>[owner]</b> rips \the [tapered] from their mouth!"),
									span_warning("You successfully remove \the [tapered] from your mouth!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				owner.emote("scream")
				REMOVE_TRAIT(owner, TRAIT_MUTE, "tape")
			else
				to_chat(owner, span_warning("You fail to take \the [tapered] off."))
		else
			if(do_mob(C, owner, 1.5 SECONDS))
				owner.UnregisterSignal(tapered, COMSIG_MOB_SAY)
				tapered.forceMove(get_turf(owner))
				tapered = null
				C.visible_message(span_warning("<b>[C]</b> rips \the [tapered] from <b>[owner]</b>'s mouth!"),
								span_warning("You rip \the [tapered] out of <b>[owner]</b>'s mouth!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				if(owner)
					owner.emote("scream")
					REMOVE_TRAIT(owner, TRAIT_MUTE, "tape")
			else
				to_chat(usr, span_warning("You fail to take \the [tapered] off."))
		update_limb(!owner)

/obj/item/bodypart/mouth/proc/get_stickied(obj/item/stack/sticky_tape/tape, mob/user)
	if(!tape || tapered)
		return
	if(tape.use(1))
		if(user && owner)
			if(user == owner)
				owner.visible_message(span_danger("<b>[user]</b> tapes [owner.p_their()] own [name] shut with \the [tape]!"), \
					span_userdanger("I tape my [name] shut with \the [tape]!"))
			else
				owner.visible_message(span_danger("<b>[user]</b> tapes <b>[owner]</b>'s [name] shut with \the [tape]!"), \
					span_userdanger("[user] tapes your [name] shut with \the [tape]!"), \
					ignored_mobs = user)
				to_chat(user, span_warning("I successfully gag <b>[owner]</b>'s [name] shut with \the [src]!"))
		else if(user)
			user.visible_message(span_warning("[user] tapes [name] shut."), \
					span_notice("I tape [name] shut."))
		tapered = new tape.type(owner)
		tapered.amount = 1
		if(owner)
			ADD_TRAIT(owner, TRAIT_MUTE, "tape")
	update_limb(!owner)

/obj/item/bodypart/mouth/halber
	max_damage = 80
	max_stamina_damage = 80
	wound_resistance = -2
	maxdam_wound_penalty = 20
	bone_type = BONE_MOUTH_HALBER
