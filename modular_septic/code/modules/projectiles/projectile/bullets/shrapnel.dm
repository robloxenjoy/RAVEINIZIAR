/obj/projectile/bullet/shrapnel
	name = "Flying Shrapnel"
	icon_state = "shrapnel"
	base_icon_state = "shrapnel"
	damage = 18
	range = 20
	weak_against_armour = TRUE
	dismemberment = 0
	ricochets_max = 1
	ricochet_chance = 15
	shrapnel_type = /obj/item/shrapnel
	ricochet_incidence_leeway = 60
	hit_prone_targets = TRUE
	sharpness = SHARP_POINTY
	wound_bonus = 30
	embedding = list(embed_chance=70, ignore_throwspeed_threshold=TRUE, fall_chance=1)
	var/state_variation = 5

/obj/projectile/bullet/shrapnel/ted
	damage = 35

/obj/projectile/bullet/shrapnel/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, state_variation)]"

/obj/projectile/bullet/shrapnel/mine
	name = "Flying Shrapnel"
	damage = 20
	range = 20
	weak_against_armour = FALSE
	dismemberment = 0
	ricochets_max = 1
	ricochet_chance = 10
	shrapnel_type = /obj/item/shrapnel
	ricochet_incidence_leeway = 60
	hit_prone_targets = TRUE
	sharpness = SHARP_POINTY
	wound_bonus = 30
	embedding = list(embed_chance=75, ignore_throwspeed_threshold=TRUE, fall_chance=1)
