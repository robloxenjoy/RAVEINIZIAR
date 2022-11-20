/obj/item/organ/eyes/robotic
	name = "robotic eye"
	icon_state = "eye-c"
	desc = "Your vision is augmented."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/eyes/robotic/l
	zone = BODY_ZONE_PRECISE_L_EYE

/obj/item/organ/eyes/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	if(prob(10 * severity))
		return
	to_chat(owner, span_warning("Static obfuscates your vision!"))
	owner.flash_act(visual = 1)

/obj/item/organ/eyes/robotic/basic
	name = "basic robotic eye"
	desc = "A basic cybernetic eye that restores vision, but at some vulnerability to light."
	eye_color = "5500ff"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/eyes/robotic/basic/l
	zone = BODY_ZONE_PRECISE_L_EYE

/obj/item/organ/eyes/robotic/basic/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	if(prob(10 * severity))
		applyOrganDamage(10 * severity)
		to_chat(owner, span_warning("Your eyes start to fizzle in their sockets!"))
		do_sparks(2, TRUE, owner)
		owner.death_scream()
