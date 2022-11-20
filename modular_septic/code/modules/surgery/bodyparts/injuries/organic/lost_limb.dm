/** LIMB LOSS **/
/datum/injury/lost_limb

/datum/injury/lost_limb/apply_injury(damage, obj/item/bodypart/limb, losstype, clean)
	var/damage_amt = limb.max_damage
	if(clean)
		damage_amt /= 2

	switch(losstype)
		if(WOUND_SLASH, WOUND_PIERCE)
			damage_type = WOUND_SLASH
			if(limb.is_robotic_limb())
				required_status = BODYPART_ROBOTIC
				max_bleeding_stage = -1
				bleed_threshold = INFINITY
				stages = list("mangled robotic socket" = 0)
			else
				required_status = BODYPART_ORGANIC
				max_bleeding_stage = 3 //clotted stump and above can bleed.
				stages = list(
					"ripped stump" = damage_amt*1.3,
					"bloody stump" = damage_amt,
					"clotted stump" = damage_amt*0.5,
					"scarred stump" = 0
				)
		if(WOUND_BURN)
			damage_type = WOUND_BURN
			stages = list(
				"mangled charred stump" = damage_amt*1.3,
				"charred stump" = damage_amt,
				"scarred stump" = damage_amt*0.5,
				"scarred stump" = 0
				)

	. = ..(damage_amt)
