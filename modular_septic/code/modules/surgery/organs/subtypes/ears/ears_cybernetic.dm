/obj/item/organ/ears/cybernetic
	name = "cybernetic ears"
	icon_state = "ears-c"
	desc = "A basic cybernetic organ designed to mimic the operation of ears."
	ear_damage_multiplier = 0.9
	emp_vulnerability = 80
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/ears/cybernetic/upgraded
	name = "upgraded cybernetic ears"
	icon_state = "ears-c-u"
	base_icon_state = "ears-c-u"
	desc = "An advanced cybernetic ear, surpassing the performance of organic ears."
	ear_damage_multiplier = 0.5

/obj/item/organ/ears/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	adjustEarDamage(2*(emp_vulnerability/(100/severity)), (emp_vulnerability/(100/severity)))
