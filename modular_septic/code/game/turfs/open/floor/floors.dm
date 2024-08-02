/turf/open/floor
	var/powerfloor = 15
	var/dangerfloor = 5

/turf/open/floor/attackby(obj/item/W, mob/living/carbon/user, params)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		if(istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			if((G.grasped_part?.body_zone == BODY_ZONE_PRECISE_FACE) || (G.grasped_part?.body_zone == BODY_ZONE_HEAD) || (G.grasped_part?.body_zone == BODY_ZONE_PRECISE_NECK))
				var/mob/living/carbon/human/GR = user.pulling
				if(GR == null)
					return
				if(GR.body_position == LYING_DOWN)
					var/obj/item/bodypart/head = GR.get_bodypart_nostump(BODY_ZONE_HEAD)
					if(head)
						var/damage = ((GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/2) + src?.powerfloor)
						var/armor_block = GR.run_armor_check(head, MELEE, sharpness = NONE)
						var/armor_reduce = GR.run_subarmor_check(head, MELEE, sharpness = NONE)
						GR.apply_damage(damage, BRUTE, head, armor_block, wound_bonus = 3, sharpness = NONE, reduced = armor_reduce)
						GR.visible_message(span_pinkdang("[user] hits [GR] head on [src]!"))
						user.changeNext_move(17)
						user.adjustFatigueLoss(6)
						playsound(get_turf(GR), 'modular_pod/sound/eff/punch 1.ogg', 80, 0)

/turf/open/floor/plating
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/iron
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,5)].ogg"

/turf/open/floor/mineral/plastitanium
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/light/red
	icon_state = "light_on-2"
	currentcolor = COLOR_SOFT_RED

/turf/open/floor/wood
	icon_state = "newwood"
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/wood/setup_broken_states()
	return list("newwood-broken", "newwood-broken2")
