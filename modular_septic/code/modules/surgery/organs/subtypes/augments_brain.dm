/obj/item/organ/cyberimp/brain
	name = "cybernetic brain implant"
	desc = "Injectors of extra sub-routines for the brain."
	icon_state = "brain_implant"
	implant_overlay = "brain_implant_overlay"
	organ_efficiency = list(ORGAN_SLOT_HEAD_AUG = 100)
	zone = BODY_ZONE_HEAD
	w_class = WEIGHT_CLASS_TINY
	emp_vulnerability = 50

/obj/item/organ/cyberimp/brain/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	var/stun_amount = 200/severity * emp_vulnerability/50
	owner.Stun(stun_amount)
	to_chat(owner, span_warning("Your body seizes up!"))
