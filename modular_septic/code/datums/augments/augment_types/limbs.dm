/datum/augment_item/limb
	category = AUGMENT_CATEGORY_LIMBS
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	uses_robotic_styles = TRUE

/datum/augment_item/limb/apply_to_human(mob/living/carbon/human/human, character_setup = FALSE, datum/preferences/prefs)
	var/obj/item/bodypart/new_bodypart = new path()
	new_bodypart.advanced_rendering = FALSE
	if(uses_robotic_styles && prefs.augment_styles[slot])
		new_bodypart.render_icon = GLOB.robotic_styles_list[prefs.augment_styles[slot]]
	var/obj/item/bodypart/old_bodypart = human.get_bodypart(new_bodypart.body_zone)
	var/list/oldorgans = list()
	oldorgans |= human.getorganslotlistzone(ORGAN_SLOT_BONE, old_bodypart.body_zone)
	oldorgans |= human.getorganslotlistzone(ORGAN_SLOT_TENDON, old_bodypart.body_zone)
	oldorgans |= human.getorganslotlistzone(ORGAN_SLOT_ARTERY, old_bodypart.body_zone)
	oldorgans |= human.getorganslotlistzone(ORGAN_SLOT_NERVE, old_bodypart.body_zone)
	for(var/obj/item/organ/organ as anything in oldorgans)
		organ.Remove(human, TRUE)
		qdel(organ)
	new_bodypart.replace_limb(human, special = TRUE, ignore_child_limbs = TRUE)
	qdel(old_bodypart)

/datum/augment_item/limb/missing
	uses_robotic_styles = FALSE

/datum/augment_item/limb/missing/apply_to_human(mob/living/carbon/human/human, character_setup = FALSE, datum/preferences/prefs)
	var/obj/item/bodypart/BP = path
	var/obj/item/bodypart/oldBP = human.get_bodypart(initial(BP.body_zone))
	if(oldBP)
		oldBP.drop_limb(FALSE, FALSE, FALSE, TRUE)

//RIGHT EYELID
/datum/augment_item/limb/r_eyelid
	slot = AUGMENT_SLOT_R_EYELID

/datum/augment_item/limb/missing/r_eyelid
	name = "Amputated Right Orbit"
	description = "You have no right eyelid."
	slot = AUGMENT_SLOT_R_EYELID
	path = /obj/item/bodypart/r_eyelid
	value = -4

//LEFT EYELID
/datum/augment_item/limb/l_eyelid
	slot = AUGMENT_SLOT_L_EYELID

/datum/augment_item/limb/missing/l_eyelid
	name = "Amputated Left Orbit"
	description = "You have no left eyelid."
	slot = AUGMENT_SLOT_L_EYELID
	path = /obj/item/bodypart/l_eyelid
	value = -4

//HEADS
/datum/augment_item/limb/head
	slot = AUGMENT_SLOT_HEAD

//FACES
/datum/augment_item/limb/face
	slot = AUGMENT_SLOT_FACE

/datum/augment_item/limb/missing/face
	name = "Amputated Face"
	description = "You have no face."
	slot = AUGMENT_SLOT_FACE
	path = /obj/item/bodypart/face
	value = -4

//JAWS
/datum/augment_item/limb/jaw
	slot = AUGMENT_SLOT_MOUTH

/datum/augment_item/limb/missing/jaw
	name = "Amputated Jaw"
	description = "You have no jaw."
	slot = AUGMENT_SLOT_MOUTH
	path = /obj/item/bodypart/mouth
	value = -4

//CHESTS
/datum/augment_item/limb/chest
	slot = AUGMENT_SLOT_CHEST

//VITALS
/datum/augment_item/limb/vitals
	slot = AUGMENT_SLOT_VITALS

//GROINS
/datum/augment_item/limb/groin
	slot = AUGMENT_SLOT_GROIN

/datum/augment_item/limb/missing/groin
	name = "Amputated Groin"
	description = "You have no groin."
	slot = AUGMENT_SLOT_GROIN
	path = /obj/item/bodypart/groin
	value = -4

//LEFT ARMS
/datum/augment_item/limb/l_arm
	slot = AUGMENT_SLOT_L_ARM

/datum/augment_item/limb/missing/l_arm
	name = "Amputated Left Arm"
	description = "You have no left arm."
	slot = AUGMENT_SLOT_L_ARM
	path = /obj/item/bodypart/l_arm
	value = -4

/datum/augment_item/limb/l_arm/surplus
	name = "Surplus Robotic Left Arm"
	path = /obj/item/bodypart/l_arm/robot/surplus
	value = -2

/datum/augment_item/limb/l_arm/robotic
	name = "Robotic Left Arm"
	path = /obj/item/bodypart/l_arm/robot/weak

//LEFT HANDS
/datum/augment_item/limb/l_hand
	slot = AUGMENT_SLOT_L_HAND

/datum/augment_item/limb/missing/l_hand
	name = "Amputated Left Hand"
	description = "You have no left hand."
	slot = AUGMENT_SLOT_L_HAND
	path = /obj/item/bodypart/l_hand
	value = -4

/datum/augment_item/limb/l_hand/surplus
	name = "Surplus Robotic Left Hand"
	path = /obj/item/bodypart/l_hand/robot/surplus
	value = -2

/datum/augment_item/limb/l_hand/robotic
	name = "Robotic Left Hand"
	path = /obj/item/bodypart/l_hand/robot/weak

//RIGHT ARMS
/datum/augment_item/limb/r_arm
	slot = AUGMENT_SLOT_R_ARM

/datum/augment_item/limb/missing/r_arm
	name = "Amputated Right Arm"
	description = "You have no right arm."
	slot = AUGMENT_SLOT_R_ARM
	path = /obj/item/bodypart/r_arm
	value = -4

/datum/augment_item/limb/r_arm/surplus
	name = "Surplus Robotic Right Arm"
	path = /obj/item/bodypart/r_arm/robot/surplus
	value = -2

/datum/augment_item/limb/r_arm/robotic
	name = "Robotic Right Arm"
	path = /obj/item/bodypart/r_arm/robot/weak

//RIGHT HANDS
/datum/augment_item/limb/r_hand
	slot = AUGMENT_SLOT_R_HAND

/datum/augment_item/limb/missing/r_hand
	name = "Amputated Right Hand"
	description = "You have no right hand."
	slot = AUGMENT_SLOT_R_HAND
	path = /obj/item/bodypart/r_hand
	value = -4

/datum/augment_item/limb/r_hand/surplus
	name = "Surplus Robotic Right Hand"
	path = /obj/item/bodypart/r_hand/robot/surplus
	value = -2

/datum/augment_item/limb/r_hand/robotic
	name = "Robotic Right Hand"
	path = /obj/item/bodypart/r_hand/robot/weak

//LEFT LEGS
/datum/augment_item/limb/l_leg
	slot = AUGMENT_SLOT_L_LEG

/datum/augment_item/limb/missing/l_leg
	name = "Amputated Left Leg"
	description = "You have no left leg."
	slot = AUGMENT_SLOT_L_LEG
	path = /obj/item/bodypart/l_leg
	value = -4

/datum/augment_item/limb/l_leg/surplus
	name = "Surplus Robotic Left Leg"
	path = /obj/item/bodypart/l_leg/robot/surplus
	value = -2

/datum/augment_item/limb/l_leg/robotic
	name = "Robotic Left Leg"
	path = /obj/item/bodypart/l_leg/robot/weak

//LEFT FEET
/datum/augment_item/limb/l_foot
	slot = AUGMENT_SLOT_L_FOOT

/datum/augment_item/limb/missing/l_foot
	name = "Amputated Left Foot"
	description = "You have no left foot."
	slot = AUGMENT_SLOT_L_FOOT
	path = /obj/item/bodypart/l_foot
	value = -4

/datum/augment_item/limb/l_foot/surplus
	name = "Surplus Robotic Left Foot"
	path = /obj/item/bodypart/l_foot/robot/surplus
	value = -2

/datum/augment_item/limb/l_foot/robotic
	name = "Robotic Left Foot"
	path = /obj/item/bodypart/l_foot/robot/weak

//RIGHT LEGS
/datum/augment_item/limb/r_leg
	slot = AUGMENT_SLOT_R_LEG

/datum/augment_item/limb/missing/r_leg
	name = "Amputated Right Leg"
	description = "You have no right leg."
	slot = AUGMENT_SLOT_R_LEG
	path = /obj/item/bodypart/r_leg
	value = -4

/datum/augment_item/limb/r_leg/surplus
	name = "Surplus Robotic Right Leg"
	path = /obj/item/bodypart/r_leg/robot/surplus
	value = -2

/datum/augment_item/limb/r_leg/robotic
	name = "Robotic Right Leg"
	path = /obj/item/bodypart/r_leg/robot/weak

//RIGHT FEET
/datum/augment_item/limb/r_foot
	slot = AUGMENT_SLOT_R_FOOT

/datum/augment_item/limb/missing/r_foot
	name = "Amputated Right Foot"
	description = "You have no right foot."
	slot = AUGMENT_SLOT_R_FOOT
	path = /obj/item/bodypart/r_foot
	value = -4

/datum/augment_item/limb/r_foot/surplus
	name = "Surplus Robotic Right Foot"
	path = /obj/item/bodypart/r_foot/robot/surplus
	value = -2

/datum/augment_item/limb/r_foot/robotic
	name = "Robotic Right Foot"
	path = /obj/item/bodypart/r_foot/robot/weak
