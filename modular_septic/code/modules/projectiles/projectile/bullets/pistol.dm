/obj/projectile/bullet/c22lr
	name = ".22lr bullet"
	damage = 20
	wound_bonus = 5
	bare_wound_bonus = 5
	embedding = list("embed_chance"=50, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=5,
					"rip_time"=20)

/obj/projectile/bullet/c9mm
	damage = 30
	wound_bonus = 0
	bare_wound_bonus = 0
	embedding = list("embed_chance"=30, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)

/obj/projectile/bullet/c45
	damage = 35
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	embedding = list("embed_chance"=40, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)

/obj/projectile/bullet/c9x21
	damage = 32
	wound_bonus = 0
	bare_wound_bonus = 0
	embedding = list("embed_chance"=25, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)

/obj/projectile/bullet/five57
	damage = 38
	wound_bonus = 0
	bare_wound_bonus = 0
	subtractible_armour_penetration = 3.5
	embedding = list("embed_chance"=20, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)

/obj/projectile/bullet/five57/ap
	edge_protection_penetration = 15
	subtractible_armour_penetration = 15

/obj/projectile/bullet/anaquilador
	icon_state = "lebullet"
	damage = 60
	wound_bonus = 25
	organ_bonus = 120
	bare_organ_bonus = 120
	ranged_modifier = 3
	subtractible_armour_penetration = 10
	edge_protection_penetration = 10
	embedding = list("embed_chance"=100, \
					"fall_chance"=0, \
					"jostle_chance"=10, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=10,
					"rip_time"=20)

/obj/projectile/bullet/c380
	name = ".380 ACP bullet"
	damage = 28
	wound_bonus = 5
	bare_wound_bonus = 5
	embedding = list("embed_chance"=80, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=5,
					"rip_time"=20)

/obj/projectile/bullet/l46
	damage = 30
	wound_bonus = 0
	bare_wound_bonus = 0
	subtractible_armour_penetration = 8
	edge_protection_penetration = 8
	embedding = list("embed_chance"=20, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=20)
