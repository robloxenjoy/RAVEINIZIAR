/obj/item/stack/medical
	icon = 'modular_septic/icons/obj/items/stack_medical.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount = 10
	max_amount = 10
	/// Limb status we can get used on
	var/required_status = BODYPART_ORGANIC

/obj/item/stack/medical/try_heal(mob/living/patient, mob/user, silent = FALSE)
	if(!patient.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
		return
	if(patient == user)
		if(self_delay)
			if(!silent)
				user.visible_message(span_notice("<b>[user]</b> starts to apply [src] on [user.p_themselves()]..."), \
					span_notice("I begin applying [src] on myself..."))
			if(!do_mob(user, patient, self_delay, extra_checks=CALLBACK(patient, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				return
	else if(other_delay)
		if(!silent)
			user.visible_message(span_notice("<b>[user]</b> starts to apply [src] on <b>[patient]</b>."), \
					span_notice("I begin applying [src] on <b>[patient]</b>..."))
		if(!do_mob(user, patient, other_delay, extra_checks=CALLBACK(patient, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
			return

	if(heal(patient, user))
		log_combat(user, patient, "healed", src.name)
		use(1)
		if(repeating && amount > 0)
			try_heal(patient, user, TRUE)

/obj/item/stack/medical/heal(mob/living/patient, mob/user)
	if(iscarbon(patient))
		return heal_carbon(patient, user, heal_brute, heal_burn)
	else if(isanimal(patient) && heal_brute) // only brute can heal
		var/mob/living/simple_animal/critter = patient
		if (!critter.healable)
			to_chat(user, span_warning("I cannot use [src] on <b>[patient]</b>!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("<b>[patient]</b> is at full health."))
			return FALSE
		user.visible_message(span_green("<b>[user]</b> applies [src] on [patient]."), \
					span_green("I apply [src] on <b>[patient]</b>."))
		patient.heal_bodypart_damage(heal_brute)
		return TRUE
	to_chat(user, span_warning("I can't heal <b>[patient]</b> with [src]!"))

/obj/item/stack/medical/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	if(affecting.brute_dam && brute || affecting.burn_dam && burn)
		user.visible_message(span_green("<b>[user]</b> applies [src] on <b>[C]</b>'s [affecting.name]."), \
						span_green("I apply [src] on <b>[C]</b>'s [affecting.name]."))
		var/previous_damage = affecting.get_damage()
		if(affecting.heal_damage(brute, burn))
			C.update_damage_overlays()
		post_heal_effects(max(previous_damage - affecting.get_damage(), 0), C, user)
		return TRUE
	to_chat(user, span_warning("<b>[C]</b>'s [affecting.name] can not be healed with [src]!"))
	return FALSE

/obj/item/stack/medical/bruise_pack
	name = "bandage pack"
	singular_name = "bandage pack"
	desc = "A simple pack of small compression bandages and gauze roller bandages."
	amount = 10
	max_amount = 10
	self_delay = 0.3 SECONDS //These will get multiplied by damage
	other_delay = 0.15 SECONDS
	repeating = TRUE

/obj/item/stack/medical/bruise_pack/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	for(var/thing in affecting.injuries)
		var/datum/injury/injury = thing
		if(injury.is_bandaged())
			continue
		var/time = (user == C ? self_delay : other_delay ) * injury.damage
		time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
		if(!do_mob(user, C, time))
			to_chat(user, span_warning("I must stand still!"))
			return
		if(!use(1))
			to_chat(user, span_warning("All used up..."))
			return
		//bandage packs are VERY EASY to use
		if(user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MEDICINE)+6, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			to_chat(user, span_warning(fail_msg()))
			return
		if(injury.current_stage <= injury.max_bleeding_stage)
			user.visible_message(span_green("<b>[user]</b> bandages \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I bandage \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		else if(injury.damage_type == WOUND_BLUNT)
			user.visible_message(span_green("<b>[user]</b> places a compression bandage over \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I place a compression bandage over \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		else if(injury.damage_type == WOUND_BURN)
			user.visible_message(span_green("<b>[user]</b> dresses \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I dress \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		else
			user.visible_message(span_green("<b>[user]</b> places a bandaid over \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I place a bandaid over \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		injury.bandage_injury()
		if(!repeating)
			return TRUE
	to_chat(user, span_warning("<b>[C]</b>'s [affecting.name] can not be healed with [src]!"))
	return FALSE

/obj/item/stack/medical/ointment
	name = "ointment pack"
	singular_name = "ointment pack"
	desc = "Simple antibacterial ointment designed to disinfect and promote wound healing."
	amount = 10
	max_amount = 10
	self_delay = 0.2 SECONDS //These will get multiplied by damage
	other_delay = 0.1 SECONDS
	repeating = TRUE

/obj/item/stack/medical/ointment/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	for(var/thing in affecting.injuries)
		var/datum/injury/injury = thing
		if(injury.is_salved())
			continue
		var/time = (user == C ? self_delay : other_delay ) * injury.damage
		time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
		if(!do_mob(user, C, time))
			to_chat(user, span_warning("I must stand still!"))
			return
		if(!use(1))
			to_chat(user, span_warning("All used up..."))
			return
		//ointment is VERY EASY to use
		if(user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MEDICINE)+6, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			to_chat(user, span_warning(fail_msg()))
			return
		user.visible_message(span_green("<b>[user]</b> salves \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
							span_green("I salve \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		injury.salve_injury()
		injury.disinfect_injury()
		if(!repeating)
			return TRUE
	to_chat(user, span_warning("<b>[C]</b>'s [affecting.name] can not be healed with [src]!"))
	return FALSE

/obj/item/stack/medical/suture
	name = "sutures"
	singular_name = "suture"
	desc = "Basic sterile sutures used to stitch up bleeding cuts and lacerations."
	amount = 10
	max_amount = 10
	self_delay = 0.4 SECONDS //These will get multiplied by damage
	other_delay = 0.2 SECONDS
	heal_brute = 10
	repeating = TRUE

/obj/item/stack/medical/suture/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	// check for incision before getting at arteries
	if(affecting.get_incision(FALSE))
		// try fixing arteries first
		if(affecting.is_artery_torn())
			var/time = (user == C ? self_delay : other_delay ) * 20
			time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
			playsound(C, 'modular_septic/sound/gore/suture.ogg', 65, FALSE)
			if(!do_mob(user, C, time))
				to_chat(user, span_warning("I must stand still!"))
				return
			if(!use(1))
				to_chat(user, span_warning("All used up..."))
				return
			//suturing arteries is VERY hard
			if(user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SURGERY)-1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
				to_chat(user, span_warning(fail_msg()))
				return FALSE
			user.visible_message(span_green("<b>[user]</b> sutures <b>[C]</b>'s [affecting.name] arteries with \the [src]."), \
								span_green("I suture <b>[C]</b>'s [affecting.name] arteries with \the [src]."))
			for(var/obj/item/organ/artery in affecting.getorganslotlist(ORGAN_SLOT_ARTERY))
				if(artery.damage)
					artery.applyOrganDamage(-min(artery.maxHealth/2, 50))
					return TRUE
			return TRUE
		// tendons second
		if(affecting.is_tendon_torn())
			var/time = (user == C ? self_delay : other_delay ) * 20
			time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
			playsound(C, 'modular_septic/sound/gore/suture.ogg', 65, FALSE)
			if(!do_mob(user, C, time))
				to_chat(user, span_warning("I must stand still!"))
				return
			if(!use(1))
				to_chat(user, span_warning("All used up..."))
				return
			//suturing tendons is hard, but not as hard as arteries
			if(user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SURGERY)+1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
				to_chat(user, span_warning(fail_msg()))
				return FALSE
			user.visible_message(span_green("<b>[user]</b> sutures <b>[C]</b>'s [affecting.name] tendons with \the [src]."), \
								span_green("I suture <b>[C]</b>'s [affecting.name] tendons with \the [src]."))
			for(var/obj/item/organ/tendon in affecting.getorganslotlist(ORGAN_SLOT_TENDON))
				if(tendon.damage)
					tendon.applyOrganDamage(-min(tendon.maxHealth/2, 50))
					return TRUE
			return TRUE
	for(var/thing in affecting.injuries)
		var/datum/injury/injury = thing
		if(!(injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE)) || (injury.damage_per_injury() <= injury.autoheal_cutoff))
			continue
		var/time = (user == C ? self_delay : other_delay ) * injury.damage
		time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
		playsound(C, 'modular_septic/sound/gore/suture.ogg', 65, FALSE)
		if(!do_mob(user, C, time))
			to_chat(user, span_warning("I must stand still!"))
			return
		if(!use(1))
			to_chat(user, span_warning("All used up..."))
			return
		//sutures aren't easy to use
		if(user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SURGERY)+3, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			to_chat(user, span_warning(fail_msg()))
			return
		injury.heal_damage(brute)
		affecting.update_damages()
		if(affecting.update_bodypart_damage_state())
			C.update_damage_overlays()
		if(injury.damage_per_injury() > injury.autoheal_cutoff)
			user.visible_message(span_green("<b>[user]</b> partially stitches \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I partially stitch \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		else
			user.visible_message(span_green("<b>[user]</b> stitches \a [injury.get_desc()] shut on <b>[C]</b>'s [affecting.name] with \the [src]."), \
								span_green("I stitch \a [injury.get_desc()] shut on \the [affecting.name] with \the [src]."))
		injury.suture_injury()
		if(!repeating)
			return TRUE
	to_chat(user, span_warning("<b>[C]</b>'s [affecting.name] can not be healed with [src]!"))
	return FALSE

/obj/item/stack/medical/suture/medicated
	icon_state = "suture_purp"

/obj/item/stack/medical/suture/ballistic
	name = "ballistic \"black tar\" sutures"
	desc = "Sutures made specifically for repairing armor. Coated with black armor oils.\n<b>Not suitable for medical use.</b>"
	icon_state = "suture_tar"

/obj/item/stack/medical/suture/ballistic/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	var/time = (user == C ? self_delay : other_delay ) * 20
	time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
	playsound(C, 'modular_septic/sound/gore/suture.ogg', 65, FALSE)
	if(!do_mob(user, C, time))
		to_chat(user, span_warning("I must stand still!"))
		return
	if(!use(1))
		to_chat(user, span_warning("All used up..."))
		return
	if(C.get_chem_effect(CE_PAINKILLER) < 30)
		to_chat(user, span_userdanger("FUCK THIS REALLY HURTS!"))
		C.agony_scream()
	affecting.receive_damage(10, sharpness = SHARP_EDGED | SHARP_POINTY | SHARP_IMPALING)
	affecting.adjust_germ_level(100)
	// oh you fucking idiot NOW YOU'VE DONE IT
	if(prob(1))
		affecting.painless_wound_roll(WOUND_ARTERY, 150, sharpness = SHARP_EDGED | SHARP_POINTY | SHARP_IMPALING)

/obj/item/stack/medical/mesh
	name = "hydrogel meshes"
	singular_name = "hydrogel mesh"
	desc = "A bacteriostatic mesh of moist hydrophillic gel, capable of salving and dressing wounds while maintaining moisture."
	self_delay = 0.3 SECONDS //These will get multiplied by damage
	other_delay = 0.15 SECONDS
	amount = 10
	max_amount = 10
	heal_burn = 10
	repeating = TRUE

/obj/item/stack/medical/mesh/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("<b>[C]</b> doesn't have \a [parse_zone(user.zone_selected)]!"))
		return FALSE
	if(required_status && (affecting.status != required_status))
		to_chat(user, span_warning("[src] won't work on that limb!"))
		return FALSE
	for(var/thing in affecting.injuries)
		var/datum/injury/injury = thing
		if(injury.is_bandaged())
			continue
		var/time = (user == C ? self_delay : other_delay ) * injury.damage
		time *= (ATTRIBUTE_MIDDLING/max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY), 1))
		if(!do_mob(user, C, time))
			to_chat(user, span_warning("I must stand still!"))
			return
		if(!use(1))
			to_chat(user, span_warning("All used up..."))
			return
		if(injury.damage_type == WOUND_BURN)
			injury.heal_damage(burn)
			affecting.update_damages()
			if(affecting.update_bodypart_damage_state())
				C.update_damage_overlays()
		user.visible_message(span_green("<b>[user]</b> dresses \a [injury.get_desc()] on <b>[C]</b>'s [affecting.name] with \the [src]."), \
							span_green("I dress \a [injury.get_desc()] on \the [affecting.name] with \the [src]."))
		injury.salve_injury()
		injury.bandage_injury()
		if(!repeating)
			return TRUE
	to_chat(user, span_warning("<b>[C]</b>'s [affecting.name] can not be healed with [src]!"))
	return FALSE

/obj/item/stack/medical/bone_gel
	icon = 'modular_septic/icons/obj/items/stack_medical.dmi'
	desc = "A potent medical gel that, when applied to a fractured bone, triggers an intense melding reaction. A red warning label says: \"Do not ingest.\"."
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	amount = 1
	max_amount = 6

/obj/item/stack/medical/bone_gel/four //this is dumb lol
	amount = 6

/obj/item/stack/medical/gauze
	desc = "A long roll of medical gauze, perfect for dressing cuts and burns."
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	amount = 8
	max_amount = 12
	splint_factor = 0.75
	absorption_capacity = 100
	absorption_rate = 0.25
	medicine_overlay_prefix = "gauze"

/obj/item/stack/medical/gauze/try_heal(mob/living/M, mob/user, volume = 50)
	var/obj/item/bodypart/limb = M.get_bodypart_nostump(check_zone(user.zone_selected))
	if(!limb)
		to_chat(user, span_notice("There's nothing there to bandage!"))
		return
	if(limb.current_gauze)
		to_chat(user, span_warning("[user == M ? "My" : "<b>[M]</b>'s"] [limb.name] is already bandaged!"))
		return
	user.visible_message(span_warning("<b>[user]</b> begins wrapping <b>[M]</b>'s [limb.name] with [src]..."), \
				span_warning("I begin wrapping [user == M ? "my" : "<b>[M]</b>'s"] [limb.name] with [src]..."), \
				playsound(src, 'modular_septic/sound/effects/bandage.wav', volume, TRUE))
	if(!do_after(user, (user == M ? self_delay : other_delay), target=M))
		return

	user.visible_message(span_green("<b>[user]</b> applies [src] to <b>[M]</b>'s [limb.name]."), \
			span_green("I bandage [user == M ? "my" : "<b>[M]</b>'s"] [limb.name]."), \
			playsound(src, 'modular_septic/sound/effects/bandage_end.wav', volume, TRUE))
	limb.apply_gauze(src)
	return TRUE

/obj/item/stack/medical/gauze/improvised
	absorption_capacity = 100
	absorption_rate = 0.5

/obj/item/stack/medical/splint
	name = "medical splints"
	singular_name = "medical splint"
	desc = "Hard plastic splints that help stabilize fractured limbs."
	icon_state = "splint"
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	amount = 1
	max_amount = 5
	medicine_overlay_prefix = "splint"
	custom_price = PAYCHECK_ASSISTANT * 3
	splint_factor = 0.3
	merge_type = /obj/item/stack/medical/splint

/obj/item/stack/medical/splint/five
	amount = 5

/obj/item/stack/medical/splint/try_heal(mob/living/M, mob/user, silent)
	var/obj/item/bodypart/limb = M.get_bodypart_nostump(check_zone(user.zone_selected))
	if(!limb)
		to_chat(user, span_notice("There's nothing there to splint!"))
		return
	if(limb.current_splint)
		to_chat(user, span_warning("[user == M ? "My" : "<b>[M]</b>'s"] [limb.name] is already splinted!"))
		return
	user.visible_message(span_warning("<b>[user]</b> begins splinting <b>[M]</b>'s [limb.name] with \the [src]..."), \
				span_warning("I begin splinting [user == M ? "my" : "<b>[M]</b>'s"] [limb.name] with \the [src]..."))
	if(!do_after(user, (user == M ? self_delay : other_delay), target=M))
		return

	user.visible_message(span_green("<b>[user]</b> applies [src] to <b>[M]</b>'s [limb.name]."), \
			span_green("I splint [user == M ? "my" : "<b>[M]</b>'s"] [limb.name]."))
	limb.apply_splint(src)
	return TRUE

/obj/item/stack/medical/splint/tribal
	name = "tribal splints"
	singular_name = "tribal splint"
	desc = "A few bones wrapped tightly in sinew... Should be enough to keep a limb in place."
	icon_state = "splint_tribal"
	amount = 1
	self_delay = 6 SECONDS
	other_delay = 3 SECONDS
	custom_price = PAYCHECK_ASSISTANT
	splint_factor = 0.5
	merge_type = /obj/item/stack/medical/splint/tribal

/obj/item/stack/medical/splint/tribal/five
	amount = 5

/obj/item/stack/medical/splint/improvised
	name = "improvised splints"
	singular_name = "improvised splint"
	desc = "Crudely made out splints with wood and some cloth. Better than nothing."
	amount = 1
	self_delay = 6 SECONDS
	other_delay = 3 SECONDS
	custom_price = PAYCHECK_ASSISTANT * 0.6
	splint_factor = 0.6
	merge_type = /obj/item/stack/medical/splint/improvised

/obj/item/stack/medical/splint/improvised/five
	amount = 5

/obj/item/stack/medical/nanopaste
	name = "nanite paste"
	singular_name = "nanite paste"
	icon_state = "nanopaste"
	desc = "A paste composed of silicon and healing nanites. Very efficient at healing robotic limbs."
	novariants = TRUE
	amount = 10
	max_amount = 10
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	heal_brute = 20
	heal_burn = 20
	required_status = BODYPART_ROBOTIC
	grind_results = list(/datum/reagent/silicon = 10, /datum/reagent/silver = 10)
	merge_type = /obj/item/stack/medical/nanopaste

/obj/item/stack/medical/nervemend
	name = "nerve mender"
	singular_name = "nerve mender"
	desc = "A tube filled with stem cells, capable of rapidly assimilating to damaged nerve endings."
	icon_state = "fixovein"
	novariants = TRUE
	amount = 1
	max_amount = 5
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	grind_results = list(/datum/reagent/medicine/c2/libital = 10, /datum/reagent/medicine/coagulant = 10)
	merge_type = /obj/item/stack/medical/nervemend

/obj/item/stack/medical/nervemend/five
	amount = 5
