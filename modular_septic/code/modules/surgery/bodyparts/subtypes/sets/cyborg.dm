//For ye whom may venture here, split up arm / hand sprites are formatted as "l_hand" & "l_arm".
//The complete sprite (displayed when the limb is on the ground) should be named "borg_l_arm".
//Failure to follow this pattern will cause the hand's icons to be missing due to the way get_limb_icon() works to generate the mob's icons using the aux_zone var.

/obj/item/bodypart/r_arm/robot
	name = "cyborg right arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_r_arm"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/r_hand/robot)

	bone_type = /obj/item/organ/bone/r_arm/robot
	tendon_type = /obj/item/organ/tendon/r_arm/robot
	nerve_type = /obj/item/organ/nerve/r_arm/robot
	artery_type = /obj/item/organ/artery/r_arm/robot

/obj/item/bodypart/r_arm/robot/nochildren
	starting_children = null

/obj/item/bodypart/r_hand/robot
	name = "cyborg right hand"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_r_hand"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	bone_type = /obj/item/organ/bone/r_hand/robot
	tendon_type = /obj/item/organ/tendon/r_hand/robot
	nerve_type = /obj/item/organ/nerve/r_hand/robot
	artery_type = /obj/item/organ/artery/r_hand/robot

/obj/item/bodypart/l_arm/robot
	name = "cyborg left arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_l_arm"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/l_hand/robot)

	bone_type = /obj/item/organ/bone/l_arm/robot
	tendon_type = /obj/item/organ/tendon/l_arm/robot
	nerve_type = /obj/item/organ/nerve/l_arm/robot
	artery_type = /obj/item/organ/artery/l_arm/robot

/obj/item/bodypart/l_arm/robot/nochildren
	starting_children = null

/obj/item/bodypart/l_hand/robot
	name = "cyborg left hand"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_l_hand"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	bone_type = /obj/item/organ/bone/l_hand/robot
	tendon_type = /obj/item/organ/tendon/l_hand/robot
	nerve_type = /obj/item/organ/nerve/l_hand/robot
	artery_type = /obj/item/organ/artery/l_hand/robot

/obj/item/bodypart/r_leg/robot
	name = "cyborg right leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_r_leg"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/r_foot/robot)

	bone_type = /obj/item/organ/bone/r_leg/robot
	tendon_type = /obj/item/organ/tendon/r_leg/robot
	nerve_type = /obj/item/organ/nerve/r_leg/robot
	artery_type = /obj/item/organ/artery/r_leg/robot

/obj/item/bodypart/r_leg/robot/nochildren
	starting_children = null

/obj/item/bodypart/r_foot/robot
	name = "cyborg right foot"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_r_foot"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	bone_type = /obj/item/organ/bone/r_foot/robot
	tendon_type = /obj/item/organ/tendon/r_foot/robot
	nerve_type = /obj/item/organ/nerve/r_foot/robot
	artery_type = /obj/item/organ/artery/r_foot/robot

/obj/item/bodypart/l_leg/robot
	name = "cyborg left leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_l_leg"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/l_foot/robot)

	bone_type = /obj/item/organ/bone/l_leg/robot
	tendon_type = /obj/item/organ/tendon/l_leg/robot
	nerve_type = /obj/item/organ/nerve/l_leg/robot
	artery_type = /obj/item/organ/artery/l_leg/robot

/obj/item/bodypart/l_leg/robot/nochildren
	starting_children = null

/obj/item/bodypart/l_foot/robot
	name = "cyborg left foot"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_l_foot"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	bone_type = /obj/item/organ/bone/l_foot/robot
	tendon_type = /obj/item/organ/tendon/l_foot/robot
	nerve_type = /obj/item/organ/nerve/l_foot/robot
	artery_type = /obj/item/organ/artery/l_foot/robot

/obj/item/bodypart/groin/robot
	name = "cyborg groin"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_groin"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	bone_type = /obj/item/organ/bone/groin/robot
	tendon_type = /obj/item/organ/tendon/groin/robot
	nerve_type = /obj/item/organ/nerve/groin/robot
	artery_type = /obj/item/organ/artery/groin/robot

/obj/item/bodypart/vitals/robot
	name = "cyborg vitals"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/groin/robot)

	tendon_type = /obj/item/organ/tendon/vitals/robot
	nerve_type = /obj/item/organ/nerve/vitals/robot
	artery_type = /obj/item/organ/artery/vitals/robot

/obj/item/bodypart/chest/robot
	name = "cyborg upper body"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_chest"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/vitals/robot)

	bone_type = /obj/item/organ/bone/chest/robot
	tendon_type = /obj/item/organ/tendon/chest/robot
	nerve_type = /obj/item/organ/nerve/chest/robot
	artery_type = /obj/item/organ/artery/chest/robot

	var/wired = FALSE
	var/obj/item/stock_parts/cell/cell = null

/obj/item/bodypart/chest/robot/nochildren
	starting_children = null

/obj/item/bodypart/chest/robot/get_cell()
	return cell

/obj/item/bodypart/chest/robot/handle_atom_del(atom/A)
	if(A == cell)
		cell = null
	return ..()

/obj/item/bodypart/chest/robot/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/item/bodypart/chest/robot/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		if(cell)
			to_chat(user, span_warning("There's already a cell installed!"))
			return
		else
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("I insert the cell."))
	else if(istype(W, /obj/item/stack/cable_coil))
		if(wired)
			to_chat(user, span_warning("It's already wired!"))
			return
		var/obj/item/stack/cable_coil/coil = W
		if (coil.use(1))
			wired = TRUE
			to_chat(user, span_notice("I insert the wire."))
		else
			to_chat(user, span_warning("I'd need at least one length of coil to wire it!"))
	else
		return ..()

/obj/item/bodypart/chest/robot/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!wired)
		to_chat(user, span_warning("There's no wiring installed in [src]!"))
		return
	. = TRUE
	I.play_tool_sound(src)
	to_chat(user, span_notice("I cut the wires out of [src]."))
	new /obj/item/stack/cable_coil(drop_location(), 1)
	wired = FALSE

/obj/item/bodypart/chest/robot/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(!cell)
		to_chat(user, span_warning("There's no power cell installed in [src]!"))
		return
	. = TRUE
	I.play_tool_sound(src)
	to_chat(user, span_notice("I remove \the [cell] from [src]."))
	cell.forceMove(drop_location())
	cell = null

/obj/item/bodypart/chest/robot/examine(mob/user)
	. = ..()
	if(cell)
		. += "It has a [cell] inserted, secured in with a few screws."
	else
		. += span_info("It has an empty port for a power cell.")
	if(wired)
		. += "Its all wired up[cell ? " and ready for usage" : ""]."
	else
		. += span_info("It has a couple spots that still need to be wired.")

/obj/item/bodypart/chest/robot/drop_organs(mob/user, violent_removal)
	if(wired)
		new /obj/item/stack/cable_coil(drop_location(), 1)
		wired = FALSE
	if(cell)
		cell.forceMove(drop_location())
		cell = null
	return ..()

/obj/item/bodypart/neck/robotic
	name = "cyborg throat"
	desc = "A bridge between the monitor and braincase thingmajig."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "neck-c"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/head/robot)

	bone_type = /obj/item/organ/bone/neck/robot
	tendon_type = /obj/item/organ/tendon/neck/robot
	nerve_type = /obj/item/organ/nerve/neck/robot
	artery_type = /obj/item/organ/artery/neck/robot

/obj/item/bodypart/neck/robotic/nochildren
	starting_children = null

/obj/item/bodypart/l_eyelid/robotic
	name = "cyborg left eyelid"
	desc = "My vision is augmented."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "eye-c"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	tendon_type = /obj/item/organ/tendon/l_eye/robot
	nerve_type = /obj/item/organ/nerve/l_eye/robot
	artery_type = /obj/item/organ/artery/l_eye/robot

/obj/item/bodypart/r_eyelid/robotic
	name = "cyborg right eyelid"
	desc = "My vision is augmented."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "eye-c"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	tendon_type = /obj/item/organ/tendon/r_eye/robot
	nerve_type = /obj/item/organ/nerve/r_eye/robot
	artery_type = /obj/item/organ/artery/r_eye/robot

/obj/item/bodypart/face/robotic
	name = "cyborg face"
	desc = "A standard reinforced flap of metal."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "face-c"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

/obj/item/bodypart/mouth/robotic
	name = "cyborg jaw"
	desc = "A standard reinforced tonguecase."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "jaw-c"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE

	bone_type = /obj/item/organ/bone/mouth/robot
	tendon_type = /obj/item/organ/tendon/mouth/robot
	nerve_type = /obj/item/organ/nerve/mouth/robot
	artery_type = /obj/item/organ/artery/mouth/robot

/obj/item/bodypart/head/robot
	name = "cyborg head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals."
	render_icon = DEFAULT_BODYPART_ICON_ROBOTIC
	icon_state = "borg_head"
	inhand_icon_state = "buildpipe"
	flags_1 = CONDUCT_1
	status = BODYPART_ROBOTIC
	limb_flags = BODYPART_SYNTHETIC|BODYPART_NO_STUMP|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE

	brute_reduction = 5
	burn_reduction = 5

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	incoming_brute_mult = ROBOTIC_BRUTE_DMG_MULTIPLIER
	incoming_burn_mult = ROBOTIC_BURN_DMG_MULTIPLIER
	incoming_pain_mult = ROBOTIC_PAIN_DMG_MULTIPLIER

	advanced_rendering = FALSE
	starting_children = list(/obj/item/bodypart/face/robotic)

	bone_type = /obj/item/organ/bone/head/robot
	tendon_type = /obj/item/organ/tendon/head/robot
	nerve_type = /obj/item/organ/nerve/head/robot
	artery_type = /obj/item/organ/artery/head/robot

	var/obj/item/assembly/flash/handheld/flash1 = null
	var/obj/item/assembly/flash/handheld/flash2 = null

/obj/item/bodypart/head/robot/handle_atom_del(atom/A)
	if(A == flash1)
		flash1 = null
	if(A == flash2)
		flash2 = null
	return ..()

/obj/item/bodypart/head/robot/Destroy()
	QDEL_NULL(flash1)
	QDEL_NULL(flash2)
	return ..()

/obj/item/bodypart/head/robot/examine(mob/user)
	. = ..()
	if(!flash1 && !flash2)
		. += span_info("It has two empty eye sockets for flashes.")
	else
		var/single_flash = FALSE
		if(!flash1 || !flash2)
			single_flash = TRUE
			. += "One of its eye sockets is currently occupied by a flash."
		else
			. += "It has two eye sockets occupied by flashes."
		. += span_notice("It shouldn't be hard to pry [single_flash ? "it" : "them"] out.")

/obj/item/bodypart/head/robot/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/assembly/flash/handheld))
		var/obj/item/assembly/flash/handheld/F = W
		if(flash1 && flash2)
			to_chat(user, span_warning("I've already inserted the eyes!"))
			return
		else if(F.burnt_out)
			to_chat(user, span_warning("I can't use a broken flash!"))
			return
		else
			if(!user.transferItemToLoc(F, src))
				return
			if(flash1)
				flash2 = F
			else
				flash1 = F
			to_chat(user, span_notice("I insert the flash into the eye socket."))
			return
	return ..()

/obj/item/bodypart/head/robot/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(flash1 || flash2)
		I.play_tool_sound(src)
		to_chat(user, span_notice("I remove the flash from [src]."))
		if(flash1)
			flash1.forceMove(drop_location())
			flash1 = null
		if(flash2)
			flash2.forceMove(drop_location())
			flash2 = null
	else
		to_chat(user, span_warning("There is no flash to remove from [src]."))
	return TRUE

/obj/item/bodypart/head/robot/drop_organs(mob/user, violent_removal)
	if(flash1)
		flash1.forceMove(user.loc)
		flash1 = null
	if(flash2)
		flash2.forceMove(user.loc)
		flash2 = null
	return ..()
