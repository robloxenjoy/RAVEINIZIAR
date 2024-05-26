/obj/projectile/bullet
	embedding = list("embed_chance"=35, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)
	wound_falloff_tile = -2
	embed_falloff_tile = 0
	ricochets_max = 2
	ricochet_chance = 20
	ricochet_incidence_leeway = 45
	sharpness = SHARP_POINTY

/obj/projectile/bullet/on_hit(atom/target, blocked, pierce_hit, reduced, edge_protection)
	. = ..()
	if(. && isliving(target))
		var/mob/living/living_targett = target
		if(ishuman(living_targett))
			if(damage > 10)
				var/mob/living/carbon/human/living_target = target
				if(living_target.diceroll(GET_MOB_ATTRIBUTE_VALUE(living_target, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL) <= DICE_SUCCESS)
					living_target.Immobilize(2 SECONDS)
				if(living_target.diceroll(GET_MOB_ATTRIBUTE_VALUE(living_target, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL) <= DICE_SUCCESS)
					if(blocked != 100)
						var/damage_dealt = damage - (damage * (blocked/100)) - reduced
						if(damage_dealt > edge_protection)
							living_target.Stun(2 SECONDS)
				if(living_target.diceroll(GET_MOB_ATTRIBUTE_VALUE(living_target, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)
					living_target.Stumble(3 SECONDS)
				if(living_target.diceroll(GET_MOB_ATTRIBUTE_VALUE(living_target, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)
					living_target.add_confusion(3)
