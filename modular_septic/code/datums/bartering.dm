/datum/bartering_recipe
    var/list/outputs = null
    var/list/inputs = null

///BALLSITICS///
/datum/bartering_recipe/ppk
    outputs = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/ppk = 1
    )
    inputs = list(
        /obj/item/stack/cable_coil = 1,
        /obj/item/food/canned/beans = 1
    )

/datum/bartering_recipe/bolsa
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/smg/bolsa = 1,
		/obj/item/ammo_box/magazine/uzi9mm = 2
    )
    inputs = list(
        /obj/item/food/canned/beef = 2
    )

/datum/bartering_recipe/thump
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/smg/thump = 1,
		/obj/item/ammo_box/magazine/thump45 = 2
    )
    inputs = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/ppk = 2
    )

/datum/bartering_recipe/winter
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/winter = 1,
		/obj/item/ammo_box/magazine/a556winter = 2
    )
    inputs = list(
        /obj/item/ammo_casing/batteries = 3
    )

/datum/bartering_recipe/federson
    outputs = list(
        /obj/item/gun/ballistic/rifle/boltaction/remis/federson = 1,
		/obj/item/storage/box/c276 = 1
    )
    inputs = list(
        /obj/item/ammo_casing/batteries/bigvolt = 1
    )

/datum/bartering_recipe/combatshotgun
    outputs = list(
        /obj/item/gun/ballistic/shotgun/automatic/combat = 1,
		/obj/item/storage/box/c12buckshot = 1
    )
    inputs = list(
        /obj/item/toothbrush = 1
    )

/datum/bartering_recipe/niggergun
    outputs = list(
        /obj/item/gun/ballistic/shotgun/ithaca = 1,
		/obj/item/storage/box/c12buckshot = 1
    )
    inputs = list(
        /obj/item/circuitboard = 1
    )

/datum/bartering_recipe/abyss
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/abyss = 1,
		/obj/item/ammo_box/magazine/a545 = 2
    )
    inputs = list(
        /obj/item/reagent_containers/pill/carbonylmethamphetamine = 8
    )

/datum/bartering_recipe/faceshield
    outputs = list(
        /obj/item/ballistic_mechanisms/visor = 1
    )
    inputs = list(
        /obj/item/organ/stomach = 1
    )

/datum/bartering_recipe/batata
    outputs = list(
        /obj/item/gun/ballistic/shotgun/grenadelauncher/batata = 1
    )
    inputs = list(
        /obj/item/ammo_casing/l40mm = 4
    )

/datum/bartering_recipe/solitario
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed = 1,
		/obj/item/ammo_box/magazine/hksmg380 = 2
    )
    inputs = list(
        /obj/item/reagent_containers/food/drinks/bottle = 1
    )

/datum/bartering_recipe/combatmaster
    outputs = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/combatmaster = 1,
		/obj/item/ammo_box/magazine/combatmaster9mm = 2
    )
    inputs = list(
         /obj/item/bodypart/head = 1
    )

/datum/bartering_recipe/svd
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/svd = 1,
		/obj/item/ammo_box/magazine/a762svd = 3
    )
    inputs = list(
        /obj/item/deviouslick/soapdispenser = 1
    )

/datum/bartering_recipe/boltacr
    outputs = list(
        /obj/item/gun/energy/remis/bolt_acr = 1
    )
    inputs = list(
        /obj/item/deviouslick/sounding = 1
    )

/datum/bartering_recipe/nasr
    outputs = list(
        /obj/item/gun/energy/remis/nasr = 1
    )
    inputs = list(
        /obj/item/organ/heart = 2
    )

/datum/bartering_recipe/balldestroyer
    outputs = list(
        /obj/item/gun/ballistic/shotgun/bolas = 1,
		/obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas/loaded = 2
    )
    inputs = list(
        /obj/item/organ/intestines = 1
    )

/datum/bartering_recipe/aniquilador
    outputs = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/aniquilador = 1,
		/obj/item/ammo_box/magazine/aniquilador = 2
    )
    inputs = list(
        /obj/item/organ/kidneys = 2
    )

///ARMOR AND CLOTHING///
/datum/bartering_recipe/helmet
    outputs = list(
        /obj/item/clothing/head/helmet/heavy = 1
    )
    inputs = list(
        /obj/item/book/ccp_propaganda = 1
    )

/datum/bartering_recipe/vest
    outputs = list(
        /obj/item/clothing/suit/armor/vest/alt/heavy = 1
    )
    inputs = list(
        /obj/item/deviouslick/broken_lcd = 1
    )

/datum/bartering_recipe/heavyhelmet
    outputs = list(
        /obj/item/clothing/head/helmet/crackhead = 1
    )
    inputs = list(
        /obj/item/toy/beach_ball/holoball = 1
    )

/datum/bartering_recipe/slaughtergoggle
    outputs = list(
        /obj/item/clothing/glasses/sunglasses/slaughter = 1
    )
    inputs = list(
        /obj/item/crowbar = 1
    )

/datum/bartering_recipe/ultraheavy
    outputs = list(
        /obj/item/clothing/suit/armor/vest/alt/ultraheavy = 1
    )
    inputs = list(
        /obj/item/bodypart/l_leg = 2,
        /obj/item/bodypart/r_leg = 2
    )

/datum/bartering_recipe/belt
    outputs = list(
        /obj/item/storage/belt/military = 1
    )
    inputs = list(
        /obj/item/chair = 1
    )

/datum/bartering_recipe/backpack
    outputs = list(
        /obj/item/storage/backpack/satchel/itobe = 1
    )
    inputs = list(
        /obj/item/light/bulb = 3
    )
///MELEE///
/datum/bartering_recipe/esword
    outputs = list(
        /obj/item/melee/energy/sword/kelzad = 1
    )
    inputs = list(
        /obj/item/reagent_containers/syringe = 1,
        /obj/item/ammo_casing/batteries = 2
    )

/datum/bartering_recipe/lead_pipe
    outputs = list(
        /obj/item/lead_pipe = 1
    )
    inputs = list(
        /obj/item/stack/teeth = 4,
    )

/datum/bartering_recipe/kukri
    outputs = list(
        /obj/item/changeable_attacks/sword/kukri = 1
    )
    inputs = list(
        /obj/item/bodypart/r_arm = 1,
        /obj/item/bodypart/l_arm = 1
    )

//MISC//
/datum/bartering_recipe/oxygen
    outputs = list(
        /obj/item/tank/internals/oxygen = 1
    )
    inputs = list(
        /obj/item/chair/wood = 1
    )

/datum/bartering_recipe/suppressor
    outputs = list(
        /obj/item/suppressor = 1
    )
    inputs = list(
        /obj/item/clothing/gloves/color/black = 1
    )

/datum/bartering_recipe/carbonyl
    outputs = list(
        /obj/item/storage/pill_bottle/carbonylmethamphetamine = 1
    )
    inputs = list(
        /obj/item/shard = 4
    )
