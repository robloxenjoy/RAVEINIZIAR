/datum/supply_pack/security/armory
	group = "Armory"
	access = FALSE
	access_view = FALSE
	crate_type = /obj/structure/closet/crate/arsenal

/datum/supply_pack/security/armory/comgun
	name = "Peneloppe CYM semi-automatic shotgun"
	desc = "A semi-automatic 12-gauge shotgun with the ability to rapidly fill any unarmored opponent with lead depending on your choice of slugs or buckshot."
	cost = 100 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/shotgun/automatic/combat
	)

/datum/supply_pack/security/armory/shotgun
	name = "ITOBE Modelo 37 shotgun"
	desc = "A pump-action 12-gauge shotgun with traditional wood furniture."
	cost = 77 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/shotgun/ithaca
	)

/datum/supply_pack/security/armory/bolas
	name = "Destruidor de Bolas 4-gauge shotgun"
	desc = "A pump-action 4-guage high-power shotgun for armor and structure penetration."
	cost = 180 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/shotgun/bolas
	)

/datum/supply_pack/security/armory/genocidio
	name = "7.62 Inverno Genocídio NK-49 Assault Rifle"
	desc = "Assault Rifle designation, 'Winter Genocide' Special Operations Assault Rifle for Extreme Law Enforcement and Military Use, comes with an extra two magazines and has a threaded barrel for suppressors"
	cost = 185 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/winter,
		/obj/item/ammo_box/magazine/a556winter,
		/obj/item/ammo_box/magazine/a556winter,
	)
	crate_name = "genocidio crate"

/datum/supply_pack/security/armory/abyss
	name = "AN-94 5.4539 Abyss Assault Rifle"
	desc = "A fully-automatic assault rifle chambered in 5.45, comes with an extra two magazines and has a threaded barrel for suppressors."
	cost = 200 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/abyss,
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545,
	)
	crate_name = "an94 crate"

/datum/supply_pack/security/armory/lampiao
	name = "7.62x54R Lampiao Semi-Automatic Designated Marksman Rifle"
	desc = "A semi-automatic DMR that combines accuaracy and heavy penetration power against armor; low capacity magazine, however this won't amount to anything due to the power of the cartridge."
	cost = 260 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/svd,
		/obj/item/ammo_box/magazine/a762svd,
		/obj/item/ammo_box/magazine/a762svd,
	)
	crate_name = "lampiao crate"

/datum/supply_pack/security/armory/glock
	name = "Gosma-17 Handgun"
	desc = "A popular brand of 9mm handgun for self-defense and law enforcement."
	cost = 60 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17,
	)
	crate_name = "9mm gosma-17"

/datum/supply_pack/security/armory/combatmaster
	name = "Tactical Frag Master 2511 Military Handgun"
	desc = "A professional, target-shooting handgun with a comfortable and ergonomic grip, comes with and is compatible with 20-round magazines of the same name."
	cost = 75 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster
	)
	crate_name = ".9mm frag master 2511"

/datum/supply_pack/security/armory/revolver
	name = ".357 Revolver"
	desc = "A six-round revolver firing in .357 magnum, arrives loaded."
	cost = 70 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/revolver
	)
	crate_name = ".357 revolver"

/datum/supply_pack/security/armory/newambu
	name = ".38 Nova Seguranca M62 Revolver"
	desc = "A six-round revolver firing in .38, has more stopping power then a .22 but less then a 9mm. Recommended to load with +P to overcome this factor."
	cost = 40 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/revolver/remis/nova
	)
	crate_name = ".38 nova revolver"

/datum/supply_pack/security/armory/poppy
	name = ".500 Poppy Revolver"
	desc = "A six-round revolver firing in .500 magnum, high-stopping power with enough penetration to go straight through most armours, high-recoil."
	cost = 85 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/revolver/remis/poppy
	)
	crate_name = ".500 poppy revolver"

/datum/supply_pack/security/armory/m1911
	name = "M1911 Handgun"
	desc = "A .45 traditional handgun from 1911, refurbished to working order, comes with an 8-round capacity magazine."
	cost = 48 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911
	)
	crate_name = ".45 M1911"

/datum/supply_pack/security/armory/solitario
	name = "Solidario e Inseguro R5 submachine gun"
	desc = "A compact and suppressable Ordinator-issue submachine gun chambered in .22lr, comes with 40-round magazines."
	cost = 130 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/smg/solitario,
		/obj/item/ammo_box/magazine/hksmg22lr,
	)
	crate_name = "Purple-rimmed Crate"

/datum/supply_pack/security/armory/walter
	name = "Bombeiro 22lr Handgun"
	desc = "A .22lr handgun, compact, and affordable."
	cost = 26 DOLLARS
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/ppk
	)
	crate_name = ".22lr Walter"

/datum/supply_pack/security/armory/solitario_magazine
	name = "Solidario e Inseguro R5 Magazine (4)"
	desc = "S&I magazine pack of four for the R5 Submachine Gun"
	cost = 15 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/hksmg22lr,
		/obj/item/ammo_box/magazine/hksmg22lr
	)
	crate_name = ".22lr drum magazines"

/datum/supply_pack/security/armory/suppressor
	name = "Sound Suppressor"
	desc = "A Suppressor for attaching on the end of threaded barrels, works for most modern firearms."
	cost = 50 DOLLARS
	contains = list(
		/obj/item/suppressor
	)
	crate_name = "suppressor crate"

//////////AMMUNITION/////////////
//357//
/datum/supply_pack/security/armory/a357
	name = ".357 Ammo Box"
	desc = "A boxed container containing 36 rounds of .357"
	cost = 35 DOLLARS
	contains = list(
		/obj/item/storage/box/a357,
	)
	crate_name = ".357 ammunition"
//9mm//
/datum/supply_pack/security/armory/a9mm
	name = "9mm Ammo Box"
	desc = "A boxed container containing 36 rounds of 9mm"
	cost = 20 DOLLARS
	contains = list(
		/obj/item/storage/box/a9mm,
	)
	crate_name = "9mm ammunition"
//.38//
/datum/supply_pack/security/armory/a38
	name = ".38 Ammo Box"
	desc = "A boxed container containing 36 rounds of .38"
	cost = 10 DOLLARS
	contains = list(
		/obj/item/storage/box/a38,
	)
	crate_name = ".38 ammunition"
//.38pluspee//
/datum/supply_pack/security/armory/a38/pluspee
	name = ".38 +P Ammo Box"
	desc = "A boxed container containing 36 rounds of .38 +P"
	cost = 17 DOLLARS
	contains = list(
		/obj/item/storage/box/a38/pluspee,
	)
	crate_name = ".38 +P ammunition"
//.500//
/datum/supply_pack/security/armory/a500
	name = ".500 Ammo Box"
	desc = "A boxed container containing 36 rounds of .500"
	cost = 42 DOLLARS
	contains = list(
		/obj/item/storage/box/a500,
	)
	crate_name = ".500 ammunition"
//.45//
/datum/supply_pack/security/armory/c45
	name = ".45 Ammo Box"
	desc = "A boxed container containing 36 rounds of .45"
	cost = 23 DOLLARS
	contains = list(
		/obj/item/storage/box/a45,
	)
	crate_name = ".45 ammunition"
//545//
/datum/supply_pack/security/armory/c545
	name = "5.45 Ammo Box"
	desc = "A boxed container containing 64 rounds of 5.45"
	cost = 30 DOLLARS
	contains = list(
		/obj/item/storage/box/c545,
	)
	crate_name = "5.45 ammunition"
//762//
/datum/supply_pack/security/armory/c762
	name = "7.62 Ammo Box"
	desc = "A boxed container containing 64 rounds of 7.62"
	cost = 40 DOLLARS
	contains = list(
		/obj/item/storage/box/c762,
	)
	crate_name = "7.62 ammunition"
//762x54R//
/datum/supply_pack/security/armory/c762x54
	name = "7.62x54 Ammo Box"
	desc = "A boxed container containing 64 rounds of 7.62x54"
	cost = 52 DOLLARS
	contains = list(
		/obj/item/storage/box/c762x54,
	)
	crate_name = "7.62x54 ammunition"
//Federson//
/datum/supply_pack/security/armory/c276
	name = ".276 Federson Ammo Box"
	desc = "A boxed container containing 64 rounds of .276 Federson"
	cost = 32 DOLLARS
	contains = list(
		/obj/item/storage/box/c276,
	)
	crate_name = ".276 ammunition"
//12 gauge buckshot//
/datum/supply_pack/security/armory/c12buckshot
	name = "12-Gauge Buckshot Ammo Box"
	desc = "A boxed container containing 16 shells of 12-gauge buckshot"
	cost = 12 DOLLARS
	contains = list(
		/obj/item/storage/box/c12buckshot,
	)
	crate_name = "12-gauge buckshot"
//12 gauge slugs//
/datum/supply_pack/security/armory/c12slugs
	name = "12-Gauge Slugs Ammo Box"
	desc = "A boxed container containing 16 shells of 12-gauge slugs"
	cost = 18 DOLLARS
	contains = list(
		/obj/item/storage/box/c12slugs,
	)
	crate_name = "12-gauge buckshot"
//4 gauge buckshot//
/datum/supply_pack/security/armory/c4buckshot
	name = "4-Gauge Buckshot Ammo Box"
	desc = "A boxed container containing 16 shells of 4-gauge buckshot"
	cost = 35 DOLLARS
	contains = list(
		/obj/item/storage/box/c4buckshot,
	)
	crate_name = "12-gauge buckshot"
//4 gauge slugs//
/datum/supply_pack/security/armory/c4slugs
	name = "4-Gauge Slugs Ammo Box"
	desc = "A boxed container containing 16 shells of 4-gauge slugs"
	cost = 43 DOLLARS
	contains = list(
		/obj/item/storage/box/c4slugs,
	)
	crate_name = "12-gauge slugs"

/datum/supply_pack/security/armory/walter_magazine
	name = "Two Bombeiro 22lr Magazines"
	desc = "Two loaded magazines for the Bomeiro .22lr pistol"
	cost = 10 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/ppk22lr,
		/obj/item/ammo_box/magazine/ppk22lr
	)
	crate_name = ".22lr walter magazine"

/datum/supply_pack/security/armory/m1911_magazine
	name = "Two M1911 Magazines"
	desc = "A .45 magazine. Fits in any cold 1911 handgun."
	cost = 32 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m45
	)
	crate_name = ".45 M1911 magazine"

/datum/supply_pack/security/armory/combatmaster_magazine
	name = "Tactical Frag Master 2511 Magazine (2)"
	desc = "Two loaded 20 round magazine for the frag master handgun."
	cost = 40.25 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/combatmaster9mm,
		/obj/item/ammo_box/magazine/combatmaster9mm
	)
	crate_name = ".9mm frag master magazines"

/datum/supply_pack/security/armory/glock_magazine
	name = "Gosma-17 magazines (2)"
	desc = "Two loaded magazines for the Gosma-17 9mm pistol"
	cost = 31 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/glock9mm,
		/obj/item/ammo_box/magazine/glock9mm
	)
	crate_name = ".9mm gosma-17 magazines"

/datum/supply_pack/security/armory/abyss_magazine
	name = "AN-94 magazines (2)"
	desc = "Ammunition Shipment for the AN-94 Abyss."
	cost = 60 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545
	)
	crate_name = "5.45 Abyss AN-94 magazines"

/datum/supply_pack/security/armory/lampiao_magazine
	name = "Lampiao magazines (2)"
	desc = "Ammunition Shipment for the Lampiao DMR."
	cost = 80 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/a762svd,
		/obj/item/ammo_box/magazine/a762svd
	)
	crate_name = "7.62x54R Lampiao Magazine magazines"

/datum/supply_pack/security/armory/genocidio_magazine
	name = "Genocídio magazines (2)"
	desc = "Ammunition Shipment for the 7.62 Inverno Gencídio Assault Rifle"
	cost = 75 DOLLARS
	contains = list(
		/obj/item/ammo_box/magazine/a556winter,
		/obj/item/ammo_box/magazine/a556winter
	)
	crate_name = "7.62 Inverno Genocídio magazines"

/datum/supply_pack/security/armory/kukri
	name = "General All-Purpose Kukri"
	desc = "A premium kukri with a sling to fit to any belt, makes clean cuts against both flesh and underbrush, It's not likely you'd encounter the latter."
	cost = 20 DOLLARS
	contains = list(
		/obj/item/changeable_attacks/sword/kukri
	)
	crate_name = "kukri"
