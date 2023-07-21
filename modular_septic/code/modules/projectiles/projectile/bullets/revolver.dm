//gangstalker bullets
/obj/projectile/bullet/a357
	name = ".357 magnum bullet"
	damage = 48
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

/obj/projectile/bullet/c38
	name = ".38 suspicious +P bullet"
	damage = 28
	wound_bonus = 0
	bare_wound_bonus = 0
	embedding = list("embed_chance"=60, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6, \
					"rip_time"=20)
	embed_falloff_tile = 0
	ricochet_chance = 20

/obj/projectile/bullet/c38/pluspee
	name = ".38 suspicious bullet"
	damage = 34
	wound_bonus = 2
	bare_wound_bonus = 0
	embedding = list("embed_chance"=40, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6, \
					"rip_time"=20)
	embed_falloff_tile = 0
	ricochet_chance = 20

/obj/projectile/bullet/c38/dumdum
	embedding = list("embed_chance"=75, \
					"fall_chance"=0, \
					"jostle_chance"=10, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=30)
	wound_falloff_tile = -5
	embed_falloff_tile = -15

/obj/projectile/bullet/a500
	name = ".500 magnum bullet"
	damage = 60
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0

/obj/projectile/bullet/pulser
	name = "pulser bullet"
	damage = 10
	wound_bonus = 15
	bare_wound_bonus = 15
	stamina = 10
	paralyze = 10
	edge_protection_penetration = 5
	subtractible_armour_penetration = 5
	sharpness = NONE