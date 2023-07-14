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
	name = "Steel Chainmail Armor"
	desc = "Armor made of steel rings. Ouroboros-rings."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "steel_chainmail"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "steel_chainmail"
	carry_weight = 6 KILOGRAMS
	body_parts_covered = CHEST|VITALS|GROIN|ARMS|LEGS|NECK
	equip_sound = 'modular_septic/sound/armor/equip/armor_use_001.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_up_001.wav'
	drop_sound = 'modular_septic/sound/armor/equip/armor_down_001.wav'
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
	name = "Light Bulletproofer"
	desc = "It will probably stop the bullet."
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
	body_parts_covered = CHEST|VITALS|GROIN
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
	body_parts_covered = CHEST|VITALS|GROIN
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
	allowed = list(
		/obj/item/gun/ballistic/revolver/remis/nova,
		)

/obj/item/clothing/head/helmet/golden/full
	name = "Golden Helmet"
	desc = "Orbicular golden helmet. It is very expensive."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "goldenhelmet"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "goldenhelmet"
	max_integrity = 300
	limb_integrity = 290
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
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.wav'

/obj/item/clothing/head/helmet/silver/full
	name = "Silver Helmet"
	desc = "Moony silver helmet. Cool!"
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "silverhelmet"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	worn_icon_state = "silverhelmet"
	max_integrity = 350
	limb_integrity = 310
	body_parts_covered = HEAD|FACE|JAW
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSMOUTH
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 45, \
                CRUSHING = 20, \
                CUTTING = 23, \
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
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.wav'