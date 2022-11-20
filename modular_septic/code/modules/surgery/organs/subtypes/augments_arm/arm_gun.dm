/obj/item/organ/cyberimp/arm/gun/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(30/severity) && owner && !(organ_flags & ORGAN_FAILING))
		Retract()
		owner.visible_message(span_danger("A loud bang comes from [owner]'s [current_zone == BODY_ZONE_R_ARM ? "right" : "left"] arm!"))
		playsound(get_turf(owner), 'sound/weapons/flashbang.ogg', 100, 1)
		to_chat(owner, span_userdanger("I feel an explosion erupt inside my [current_zone == BODY_ZONE_R_ARM ? "right" : "left"] arm as your implant breaks!"))
		owner.adjust_fire_stacks(20)
		owner.IgniteMob()
		owner.adjustFireLoss(25)
		organ_flags |= ORGAN_FAILING
