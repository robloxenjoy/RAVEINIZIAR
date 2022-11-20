/obj/effect/spawner/random/weapons
	name = "random weapon spawner"
	spawn_loot_chance = 100
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17,
		/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster,
		/obj/item/gun/ballistic/automatic/pistol/remis/ppk,
		/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador,
		/obj/item/gun/ballistic/automatic/pistol/m1911,
		/obj/item/gun/ballistic/automatic/pistol/aps
	)

/obj/effect/spawner/random/weapons/gatekeeper
	name = "gatekeeper weapon spawn"
	spawn_loot_chance = 20
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/gun/ballistic/automatic/remis/smg/bastardo
	)

/obj/effect/spawner/random/weapons/rarepistol
	name = "rare concealed pistol spawn"
	spawn_loot_chance = 5
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911,
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17,
		/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster
	)

/obj/effect/spawner/random/weapons/rarepistolbomj
	name = "rare bomj pistol spawn"
	spawn_loot_chance = 50
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911
	)

/obj/effect/spawner/random/weapons/armorypistol
	name = "armory pistol"
	spawn_loot_chance = 100
	spawn_all_loot = TRUE
	spawn_random_offset = TRUE
	loot = list(
		list(
		/obj/item/gun/ballistic/automatic/pistol/remis/ppk = 100,
		/obj/item/ammo_box/magazine/ppk22lr = 100,
		/obj/item/ammo_box/magazine/ppk22lr = 100,
		) = 90,
		list(
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 100,
		/obj/item/ammo_box/magazine/m45 = 100,
		/obj/item/ammo_box/magazine/m45 = 100,
		) = 5,
		list(
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17 = 100,
		/obj/item/ammo_box/magazine/glock9mm = 100,
		/obj/item/ammo_box/magazine/glock9mm = 100,
		) = 10
	)

/obj/effect/spawner/random/weapons/suppressor
	name = "rare suppressor spawn"
	spawn_loot_chance = 5
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/suppressor
	)

/obj/effect/spawner/random/weapons/receiverspawn
	name = "rare conversion-kit spawn"
	spawn_loot_chance = 35
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/ballistic_mechanisms/solitario_sd
	)
