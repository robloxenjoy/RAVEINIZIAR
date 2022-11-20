// Weapon exports. Stun batons, disablers, etc.

/datum/export/weapon
	include_subtypes = FALSE

/datum/export/weapon/baton
	cost = 4.8 DOLLARS
	unit_name = "truncheon"
	export_types = list(/obj/item/melee/truncheon)

/datum/export/weapon/knife
	cost = 2.5 DOLLARS
	unit_name = "knife"
	export_types = list(/obj/item/knife)

/datum/export/weapon/laser
	cost = 85 DOLLARS
	unit_name = "laser weaponry"
	export_types = list(/obj/item/gun/energy/laser)

/datum/export/weapon/shotgun
	cost = 54 DOLLARS
	unit_name = "shotgun"
	export_types = list(/obj/item/gun/ballistic/shotgun)

/datum/export/weapon/shotgun/comgun
	cost = 70 DOLLARS
	unit_name = "combat shotgun"
	export_types = list(/obj/item/gun/ballistic/shotgun/automatic/combat)

/datum/export/weapon/shotgun/bolas
	cost = 110 DOLLARS
	unit_name = "big ass shotgun"
	export_types = list(/obj/item/gun/ballistic/shotgun/bolas)

/datum/export/weapon/genocido
	cost = 125.5 DOLLARS
	unit_name = "NK-49 Assault Rifle"
	export_types = list(/obj/item/gun/ballistic/automatic/remis/winter)

/datum/export/weapon/abyss
	cost = 140 DOLLARS
	unit_name = "AN94 Assault Rifle"
	export_types = list(/obj/item/gun/ballistic/automatic/remis/abyss)

/datum/export/weapon/lampiao
	cost = 140 DOLLARS
	unit_name = "Lampiao Designated Marksman Rifle"
	export_types = list(/obj/item/gun/ballistic/automatic/remis/svd)

/datum/export/weapon/glock
	cost = 25 DOLLARS
	unit_name = "Gosma-17"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/remis/glock17)

/datum/export/weapon/combatmaster
	cost = 35 DOLLARS
	unit_name = "Tactical Frag Master"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster)

/datum/export/weapon/revolver
	cost = 42 DOLLARS
	unit_name = ".357 Revolver"
	export_types = list(/obj/item/gun/ballistic/revolver)

/datum/export/weapon/revolver/newambu
	cost = 21 DOLLARS
	unit_name = ".38 Nova Seguranca M62 Revolver"
	export_types = list(/obj/item/gun/ballistic/revolver/remis/nova)

/datum/export/weapon/revolver/poppy
	cost = 55 DOLLARS
	unit_name = ".500 Poppy Revolver"
	export_types = list(/obj/item/gun/ballistic/revolver/remis/poppy)

/datum/export/weapon/solitario
	cost = 65 DOLLARS
	unit_name = "Solidario e Inseguro R5 submachine sun"
	export_types = list(/obj/item/gun/ballistic/automatic/remis/smg/solitario)

/datum/export/weapon/walter
	cost = 9 DOLLARS
	unit_name = "Bombeiro 22lr Handgun"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/remis/ppk)

/datum/export/weapon/m1911
	cost = 15 DOLLARS
	unit_name = "M1911"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/m1911)

/datum/export/weapon/suppressor
	cost = 20 DOLLARS
	unit_name = "Sound Suppressor"
	export_types = list(/obj/item/suppressor)

/datum/export/weapon/grenade
	cost = 15 DOLLARS
	unit_name = "fragmentation grenade"
	export_types = list(/obj/item/grenade/frag)

/datum/export/weapon/flashbang
	cost = 8 DOLLARS
	unit_name = "flashbang grenade"
	export_types = list(/obj/item/grenade/flashbang)

/datum/export/weapon/teargas
	cost = 6 DOLLARS
	unit_name = "tear gas grenade"
	export_types = list(/obj/item/grenade/chem_grenade/teargas)

/datum/export/weapon/handcuffs
	cost = 1 DOLLARS
	unit_name = "pair"
	message = "of handcuffs"
	export_types = list(/obj/item/restraints/handcuffs)
