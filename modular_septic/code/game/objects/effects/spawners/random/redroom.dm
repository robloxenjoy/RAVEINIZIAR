/obj/effect/spawner/random/redroom
	name = "red room spawner"
	spawn_loot_chance = 2
	spawn_random_offset = TRUE
	loot = list(
		/obj/item/holochip/redroom,
		/obj/item/gun/energy/remis/bolt_acr,
		/obj/item/gun/ballistic/shotgun/abyss,
		/obj/item/gun/ballistic/automatic/remis/steyr,
		/obj/item/gun/ballistic/automatic/remis/winter,
		/obj/item/gun/ballistic/automatic/remis/abyss
	)

/obj/effect/spawner/random/redroom/scatter
	name = "red room spawner (scatter)"
	spawn_scatter_radius = 3

/obj/item/holochip/redroom
	credits = 60000
