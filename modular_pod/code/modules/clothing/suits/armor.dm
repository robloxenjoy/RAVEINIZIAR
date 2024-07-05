/obj/item/clothing/suit/armor/vest/leatherbreast
	name = "Leather Breast-armor"
	desc = "This will help you survive."
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	icon_state = "leathervest"
	worn_icon_state = "leathervest"
	inhand_icon_state = "infiltrator"
	armor = null
	body_parts_covered = NECK|CHEST|VITALS|GROIN
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 30, \
				CRUSHING = 22, \
				CUTTING = 24, \
				PIERCING = 10, \
				IMPALING = 8, \
				LASER = 7, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 3, \
				ORGAN = 5)
	strip_delay = 90

/obj/item/clothing/suit/armor/vest/leatherbreastt
	name = "Leather Breast-armor"
	desc = "Leather armor! Its made of brown frog leather."
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	icon_state = "leathervestt"
	worn_icon_state = "leathervestt"
	inhand_icon_state = "infiltrator"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 400
	integrity_failure = 0.1
	limb_integrity = 350
	body_parts_covered = CHEST|VITALS|GROIN
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 35, \
				CRUSHING = 7, \
				CUTTING = 25, \
				PIERCING = 20, \
				IMPALING = 10, \
				LASER = 7, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 5, \
				ORGAN = 3)
	strip_delay = 90

/obj/item/clothing/suit/armor/vest/chainmail/steel
	name = "Кольчуга"
	desc = "Кольчуга из стальных Уроборос-колец."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "steel_chainmail"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "steel_chainmail"
	carry_weight = 6 KILOGRAMS
	body_parts_covered = CHEST|VITALS|GROIN|ARMS|LEGS|NECK
	equip_sound = 'modular_septic/sound/armor/equip/armor_use_001.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_up_001.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/armor_down_001.ogg'
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	max_integrity = 500
	integrity_failure = 0.1
	limb_integrity = 450
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	repairable_by = /obj/item/stack/ballistic
	armor = list(MELEE = 1, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 20, \
				BOMB = 20, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 45, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 65, \
				CRUSHING = 4, \
				CUTTING = 35, \
				PIERCING = 10, \
				IMPALING = 12, \
				LASER = 1, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 2, \
				ACID = 2, \
				MAGIC = 0, \
				WOUND = 3, \
				ORGAN = 2)

/obj/item/clothing/suit/armor/vest/chainmail/steel/Initialize(mapload)
	. = ..()
	var/datum/component/shuffling/shuffling = GetComponent(/datum/component/shuffling)
	if(shuffling)
		shuffling.override_squeak_sounds = list('modular_septic/sound/armor/chainmail_stereo1.ogg'=1,
												'modular_septic/sound/armor/chainmail_stereo2.ogg'=1,
												'modular_septic/sound/armor/chainmail_stereo3.ogg'=1)
		shuffling.volume = 60
		shuffling.sound_falloff_exponent = 20

/obj/item/clothing/suit/armor/vest/bulletproofer
	name = "Лёгкий Бронежилет"
	desc = "Должно защитить от пуль мелкого калибра."
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	icon_state = "bulletproofer"
	worn_icon_state = "bulletproofer"
	inhand_icon_state = "infiltrator"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 450
	integrity_failure = 0.1
	limb_integrity = 400
	body_parts_covered = CHEST|VITALS|GROIN|NECK
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 10, \
				CRUSHING = 5, \
				CUTTING = 10, \
				PIERCING = 70, \
				IMPALING = 10, \
				LASER = 7, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 9, \
				ORGAN = 9)
	strip_delay = 90
	allowed = list(
		/obj/item/ammo_casing,
		/obj/item/grenade/frag,
		/obj/item/grenade/gas,
		)

/obj/item/clothing/suit/armor/vest/redjacket
	name = "Red Jacket"
	desc = "It is dangerous to walk in such a jacket here!"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	icon_state = "redjacket"
	worn_icon_state = "redjacket"
	inhand_icon_state = "infiltrator"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 450
	integrity_failure = 0.1
	limb_integrity = 400
	body_parts_covered = CHEST|VITALS|GROIN|NECK
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 6, \
				CRUSHING = 6, \
				CUTTING = 7, \
				PIERCING = 6, \
				IMPALING = 6, \
				LASER = 7, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 2, \
				ORGAN = 2)
	strip_delay = 90

/obj/item/clothing/suit/armor/vest/leatherjacket
	name = "Leather Jacket"
	desc = "It is dangerous to walk in such a jacket here!"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	icon_state = "leatherjacket"
	worn_icon_state = "leatherjacket"
	inhand_icon_state = "infiltrator"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 450
	integrity_failure = 0.1
	limb_integrity = 400
	body_parts_covered = CHEST|VITALS|GROIN|NECK
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 6, \
				CRUSHING = 6, \
				CUTTING = 7, \
				PIERCING = 6, \
				IMPALING = 6, \
				LASER = 7, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 2, \
				ORGAN = 2)
	strip_delay = 90

/*
/obj/item/clothing/suit/armor/vest/redjacket/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 2
	STR.max_w_class = 12
	STR.set_holdable(list(/obj/item/gun/ballistic/revolver/remis/nova, /obj/item/ammo_casing))


/obj/item/clothing/suit/armor/vest/redjacket/attack_self_secondary(mob/user, modifiers)
	. = ..()
	GetComponent(src, /datum/component/storage)
	open_storage()
*/

/obj/item/clothing/suit/armor/vest/fullcrazy/copper
	name = "Copper Armor"
	desc = "Armor made of copper."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "copper_armor"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "copper_armor"
	body_parts_covered = CHEST|VITALS|GROIN|ARMS|NECK
	equip_sound = 'modular_septic/sound/armor/equip/armor_use_001.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/armor_drop.ogg'
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 600
	integrity_failure = 0.1
	limb_integrity = 550
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	repairable_by = /obj/item/stack/ballistic
	armor = list(MELEE = 1, \
				BULLET = 1, \
				LASER = 0, \
				ENERGY = 20, \
				BOMB = 20, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 0, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = NONE, \
				EDGE_PROTECTION = 75, \
				CRUSHING = 38, \
				CUTTING = 38, \
				PIERCING = 20, \
				IMPALING = 24, \
				LASER = 1, \
				ENERGY = 0, \
				BOMB = 15, \
				BIO = 0, \
				FIRE = 5, \
				ACID = 0, \
				MAGIC = 0, \
				WOUND = 5, \
				ORGAN = 5)
	carry_weight = 7 KILOGRAMS

/obj/item/clothing/suit/armor/vest/fullcrazy/copper/Initialize(mapload)
	. = ..()
	var/datum/component/shuffling/shuffling = GetComponent(/datum/component/shuffling)
	if(shuffling)
		shuffling.override_squeak_sounds = list('modular_septic/sound/armor/heavygear_stereo1.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo2.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo3.ogg'=1)
		shuffling.volume = 60
		shuffling.sound_falloff_exponent = 20

/obj/item/clothing/suit/armor/vest/fullcrazy/steel
	name = "Steel Plate Armor"
	desc = "Plate armor made of steel."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "platearmor"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "platearmor"
	body_parts_covered = CHEST|VITALS|GROIN|ARMS|NECK|LEGS
	equip_sound = 'modular_septic/sound/armor/equip/armor_use_001.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/armor_drop.ogg'
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 650
	integrity_failure = 0.1
	limb_integrity = 600
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	repairable_by = /obj/item/stack/ballistic
	armor = list(MELEE = 1, \
				BULLET = 1, \
				LASER = 0, \
				ENERGY = 20, \
				BOMB = 20, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 0, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = NONE, \
				EDGE_PROTECTION = 80, \
				CRUSHING = 43, \
				CUTTING = 43, \
				PIERCING = 25, \
				IMPALING = 29, \
				LASER = 1, \
				ENERGY = 0, \
				BOMB = 15, \
				BIO = 0, \
				FIRE = 5, \
				ACID = 0, \
				MAGIC = 0, \
				WOUND = 7, \
				ORGAN = 7)
	carry_weight = 8 KILOGRAMS

/obj/item/clothing/suit/armor/vest/fullcrazy/steel/Initialize(mapload)
	. = ..()
	var/datum/component/shuffling/shuffling = GetComponent(/datum/component/shuffling)
	if(shuffling)
		shuffling.override_squeak_sounds = list('modular_septic/sound/armor/heavygear_stereo1.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo2.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo3.ogg'=1)
		shuffling.volume = 60
		shuffling.sound_falloff_exponent = 20

/obj/item/clothing/head/helmet/golden/full
	name = "Golden Helmet"
	desc = "Orbicular golden helmet. It is very expensive."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "goldenhelmet"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "goldenhelmet"
	max_integrity = 400
	limb_integrity = 380
	body_parts_covered = HEAD|FACE|EYES
	flags_inv = HIDEHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | PEPPERPROOF
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 40, \
                CRUSHING = 15, \
                CUTTING = 25, \
                PIERCING = 15, \
                IMPALING = 9, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 20, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 9, \
                ORGAN = 9)
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 3.5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.ogg'

/obj/item/clothing/head/helmet/silver/full
	name = "Silver Helmet"
	desc = "Moony silver helmet. Cool!"
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "silverhelmet"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "silverhelmet"
	max_integrity = 450
	limb_integrity = 400
	body_parts_covered = HEAD|FACE|JAW
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSMOUTH
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 45, \
                CRUSHING = 30, \
                CUTTING = 33, \
                PIERCING = 15, \
                IMPALING = 8, \
                LASER = 5, \
                ENERGY = 5, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 30, \
                ACID = 2, \
                MAGIC = 3, \
                WOUND = 7, \
                ORGAN = 7)
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 3.3 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.ogg'

/obj/item/clothing/suit/armor/tabard
	name = "Tabard"
	desc = "Hope this will protect you."
	color = null
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "tabard"
	worn_icon = 'modular_pod/icons/mob/clothing/detailed/tabards.dmi'
	worn_icon_state = "tabard"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 480
	integrity_failure = 0.1
	limb_integrity = 460
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|VITALS|GROIN
	slot_flags = ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 20, \
				CRUSHING = 15, \
				CUTTING = 15, \
				PIERCING = 20, \
				IMPALING = 5, \
				LASER = 3, \
				ENERGY = 0, \
				BOMB = 3, \
				BIO = 0, \
				FIRE = 3, \
				ACID = 3, \
				MAGIC = 0, \
				WOUND = 10, \
				ORGAN = 10)
	strip_delay = 90
	var/picked

/obj/item/clothing/suit/armor/tabard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/armor/tabard/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None", "Symbol", "Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "Symbol")
		design = null
		design = input(user, "Select a symbol.","Tabard Design") as null|anything in list("chalice", "peace", "z", "v", "skull", "arrow")
		if(!design)
			return
		design = "_[design]"
	var/colorone = input(user, "Select a primary color.","Tabard Design") as color|null
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a secondary color.","Tabard Design") as color|null
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	picked = TRUE
	if(design != "None")
		detail_tag = design
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = colorone
	if(colortwo)
		detail_color = colortwo
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_oversuit()

/obj/item/clothing/head/helmet/codec/def_yel
	name = "Шлем"
	desc = "Валькирия - под таким названием зарегистрирован этот шлем."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "yel_bik"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "yel_bik"
	max_integrity = 400
	limb_integrity = 400
	body_parts_covered = HEAD|FACE|EYES|JAW
	flags_inv = HIDEHAIR|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | PEPPERPROOF
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 40, \
                CRUSHING = 25, \
                CUTTING = 25, \
                PIERCING = 15, \
                IMPALING = 9, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 20, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 10, \
                ORGAN = 4)
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 3.5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.ogg'

/obj/item/clothing/suit/armor/roba
	name = "Роба"
	desc = "Главное, что цвет хороший."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "kapno"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "kapnob"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = null
	max_integrity = 180
	integrity_failure = 0.1
	limb_integrity = 150
	body_parts_covered = CHEST|VITALS|GROIN|NECK|LEGS|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_OVERSUIT
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 2, \
				CRUSHING = 1, \
				CUTTING = 5, \
				PIERCING = 2, \
				IMPALING = 2, \
				LASER = 1, \
				ENERGY = 0, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 1, \
				ACID = 1, \
				MAGIC = 0, \
				WOUND = 3, \
				ORGAN = 1)
	strip_delay = 90
