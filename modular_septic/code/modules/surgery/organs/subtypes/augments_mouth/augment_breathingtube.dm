/obj/item/organ/cyberimp/mouth/breathing_tube
	name = "breathing tube implant"
	desc = "This simple implant adds an internals connector to your back, allowing you to use internals without a mask and protecting you from being choked."
	icon_state = "implant_mask"
	organ_efficiency = list(ORGAN_SLOT_MOUTH_AUG = 100, ORGAN_SLOT_BREATHING_TUBE = 100)
	w_class = WEIGHT_CLASS_TINY
	emp_vulnerability = 60

/obj/item/organ/cyberimp/mouth/breathing_tube/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	if(prob(emp_vulnerability/severity))
		to_chat(owner, span_warning("Your breathing tube suddenly closes!"))
		owner.losebreath += 2
