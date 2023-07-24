/obj/item/trickysign
	name = "stop sign"
	desc = "A antique stop sign, for flouridated pedestrians and drivers to tell them when to not run over random people or stampede them. But now It's used to hit people in the head until they're dead."
	icon_state = "tricky"
	inhand_icon_state = "tricky"
	worn_icon_state = null
	icon = 'modular_septic/icons/obj/items/melee/bizzare.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_righthand.dmi'
	worn_icon = null
	equip_sound = null
	hitsound = list('modular_septic/sound/weapons/melee/sign1.ogg', 'modular_septic/sound/weapons/melee/sign2.ogg')
	miss_sound = list('modular_septic/sound/weapons/melee/sign_miss1.ogg', 'modular_septic/sound/weapons/melee/sign_miss2.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/sign_pickup.ogg'
	drop_sound = 'modular_septic/sound/weapons/melee/sign_drop.ogg'
	wield_info = /datum/wield_info/tricky
	min_force = 15
	force = 20
	min_force_strength = 1.9
	force_strength = 1.40
	parrying_modifier = 1
	wound_bonus = 20
	bare_wound_bonus = 5
	armor_damage_modifier = 2
	edge_protection_penetration = 10
	subtractible_armour_penetration = 10
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_HUGE
	attack_fatigue_cost = 4.5
	slot_flags = null
	sharpness = NONE
	parrying_modifier = 1
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED
	tetris_width = 32
	tetris_height = 96

/obj/item/trickysign/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isopenturf(over) || !isliving(usr) || !usr.Adjacent(src) || !usr.Adjacent(over) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(!do_after(user, 2 SECONDS) || (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) <= 12))
		var/message = pick(GLOB.whoopsie)
		user.visible_message(span_danger("[user] strains to embed [src] into the ground."), \
					span_danger("[message] I'm too fucking weak."))
		return
	var/obj/structure/trickysign/trickysign = new /obj/structure/trickysign(over)

	var/schwicky_turfs = list(/turf/open/floor/plating/dirt, /turf/open/floor/plating/grass, /turf/open/floor/plating/asteroid)
	if(over.type in schwicky_turfs)
		playsound(user, 'modular_septic/sound/weapons/melee/stone_embed.ogg', 80, FALSE)
	else
		playsound(user, 'modular_septic/sound/weapons/melee/tile_embed.ogg', 80, FALSE)
	user.do_attack_animation(trickysign)
	user.transferItemToLoc(src, trickysign)
	QDEL_NULL(trickysign.trickysign) //it already gets one on initialize, we need to troll
	trickysign.trickysign = src
	user.visible_message(span_danger("[user] embeds [src] into the ground!"), \
					span_danger("I embed [src] into the ground as hard as I can."))

/obj/item/trickysign/update_icon(updates)
	. = ..()
	if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		inhand_icon_state = "[initial(inhand_icon_state)]_wielded"
	else
		inhand_icon_state = "[initial(inhand_icon_state)]"
