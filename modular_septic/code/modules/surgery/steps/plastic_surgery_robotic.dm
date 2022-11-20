//reshape_face
/datum/surgery_step/mechanic_reshape_face
	name = "Reshape monitor"
	implements = list(
		/obj/item/stack/medical/nanopaste = 80,
	)
	possible_locs = list(BODY_ZONE_PRECISE_FACE)
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_RETRACTED)
	minimum_time = 48
	maximum_time = 128
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_reshape_face/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if(!.)
		return
	var/obj/item/stack/chungus = tool
	if(chungus.amount < 3)
		return FALSE

/datum/surgery_step/mechanic_reshape_face/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to alter [target]'s appearance..."), \
		span_notice("[user] begins to alter [target]'s appearance."), \
		span_notice("[user] begins to make an incision in [target]'s face."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_reshape_face/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/stack/chungus = tool
	if(istype(chungus))
		chungus.use(3)
	var/obj/item/bodypart/face/face = target.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
	if(HAS_TRAIT(target, TRAIT_DISFIGURED) || (face && HAS_TRAIT(face, TRAIT_DISFIGURED)))
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, TRAIT_GENERIC)
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, BRUTE)
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, BURN)
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, ACID)
		if(face)
			REMOVE_TRAIT(face, TRAIT_DISFIGURED, TRAIT_GENERIC)
			REMOVE_TRAIT(face, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)
			REMOVE_TRAIT(face, TRAIT_DISFIGURED, BRUTE)
			REMOVE_TRAIT(face, TRAIT_DISFIGURED, BURN)
			REMOVE_TRAIT(face, TRAIT_DISFIGURED, ACID)
		display_results(user, target, \
			span_notice("I successfully restore [target]'s appearance."), \
			span_notice("[user] successfully restores [target]'s appearance!"), \
			span_notice("[user] finishes the operation on [target]'s face."))
	else
		var/list/names = list()
		if(!isabductor(user))
			for(var/i in 1 to 10)
				names += target.dna.species.random_name(target.gender, TRUE)
		else
			for(var/_i in 1 to 9)
				names += "Subject [target.gender == MALE ? "i" : "o"]-[pick("a", "b", "c", "d", "e")]-[rand(10000, 99999)]"
			names += target.dna.species.random_name(target.gender, TRUE) //give one normal name in case they want to do regular plastic surgery
		var/chosen_name = input(user, "Choose a new name to assign.", "Plastic Surgery") as null|anything in names
		if(!chosen_name)
			return
		var/oldname = target.real_name
		target.real_name = chosen_name
		var/newname = target.real_name	//something about how the code handles names required that I use this instead of target.real_name
		display_results(user, target, \
			span_notice("I alter [oldname]'s appearance completely, [target.p_they()] [target.p_are()] now [newname]."), \
			span_notice("[user] alters [oldname]'s appearance completely, [target.p_they()] [target.p_are()] now [newname]!"), \
			span_notice("[user] finishes the operation on [target]'s face."))
	if(ishuman(target))
		var/mob/living/carbon/human/human = target
		human.sec_hud_set_ID()
	target.update_name()
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_reshape_face/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/stack/chungus = tool
	if(istype(chungus))
		chungus.use(3)
	display_results(user, target, \
		span_warning("I screw up, leaving [target]'s appearance even more disfigured!"), \
		span_warning("[user] screws up, disfiguring [target]'s appearance!"), \
		span_warning("[user] fucks up the operation on [target]'s face."))
	ADD_TRAIT(target, TRAIT_DISFIGURED, TRAIT_GENERIC)
	target.update_name()
	return SURGERY_SUCCESS
