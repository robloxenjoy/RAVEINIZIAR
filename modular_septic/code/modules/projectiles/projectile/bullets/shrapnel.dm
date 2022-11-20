/obj/projectile/bullet/shrapnel
	name = "flying shrapnel shard"
	icon_state = "shrapnel"
	base_icon_state = "shrapnel"
	damage = 14
	range = 5
	weak_against_armour = TRUE
	dismemberment = 0
	ricochets_max = 0
	ricochet_chance = 0
	shrapnel_type = /obj/item/shrapnel
	ricochet_incidence_leeway = 60
	hit_prone_targets = TRUE
	sharpness = SHARP_EDGED
	wound_bonus = 30
	embedding = list(embed_chance=70, ignore_throwspeed_threshold=TRUE, fall_chance=1)
	var/state_variation = 5

/obj/projectile/bullet/shrapnel/ted
	damage = 35

/obj/projectile/bullet/shrapnel/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, state_variation)]"
