/obj/item/clothing/head/helmet
	name = "type II ballistic helmet"
	desc = "A type II armored helmet. Moderate protection against most types of damage. Does not cover the face."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "helmet"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "helmet"
	max_integrity = 200
	limb_integrity = 190
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 40, \
                CRUSHING = 13, \
                CUTTING = 15, \
                PIERCING = 34, \
                IMPALING = 5, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 2.5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.wav'

/obj/item/clothing/head/helmet/medium
	name = "\"Evacuador\" type III+ ballistic helmet"
	desc = "A type III+ ballistic helmet. Intermediate protection against most types of damage. Does not cover the face."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "helmet_medium"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "helmet_medium"
	max_integrity = 300
	integrity_failure = 0.05
	limb_integrity = 220
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 58, \
                CRUSHING = 19, \
                CUTTING = 18, \
                PIERCING = 42, \
                IMPALING = 6, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	carry_weight = 2.5 KILOGRAMS

/obj/item/clothing/head/helmet/heavy
	name = "\"Touro-5\" type IV heavy ballistic helmet"
	desc = "A type IV armored heavy helmet. Intermediate protection against most types of damage. Has a-pair of mounts on the sides for a faceshield to protect the face."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "helmet_heavy"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "helmet_heavy"
	max_integrity = 400
	integrity_failure = 0.04
	limb_integrity = 350
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 75, \
                CRUSHING = 24, \
                CUTTING = 24, \
                PIERCING = 50, \
                IMPALING = 14, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 13, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	carry_weight = 3.5 KILOGRAMS

/obj/item/clothing/head/helmet/heavy/visor
    desc = "A type IV armored heavy helmet. Intermediate protection against most types of damage. Has a visor attached, providing ballistic protection for the face."
    icon_state = "helmet_heavy_visor"
    worn_icon_state = "helmet_heavy_visor"
    body_parts_covered = HEAD|FACE|JAW|EYES

/obj/item/clothing/head/helmet/crackhead
	name = "\"Crackudo\" type V heavy ballistic helmet"
	desc = "A type V armored heavy helmet. Specialized protection against ballistic threats, although vintage, incredibly heavy, and uncomfortable to wear. Often used by ITOBE privates who couldn't get their hands on actual gear \
	Embuing it with the slang-term, \"Crackudo\", for crackhead."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "helmet_heavy_face"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "helmet_heavy_face"
	max_integrity = 500
	integrity_failure = 0.04
	limb_integrity = 450
	body_parts_covered = HEAD|FACE|JAW|EYES
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 80, \
                CRUSHING = 28, \
                CUTTING = 28, \
                PIERCING = 60, \
                IMPALING = 18, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 17, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	carry_weight = 5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use_visor.wav'

/obj/item/clothing/head/helmet/infiltrator
	name = "infiltrator helmet"
	desc = "The galaxy isn't big enough for the two of us."
	icon_state = "infiltrator"
	worn_icon_state = "infiltrator"
	inhand_icon_state = "infiltrator"
	armor = null
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flash_protect = FLASH_PROTECTION_WELDER
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	body_parts_covered = HEAD|FACE|JAW|EYES
	strip_delay = 80
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 45, \
                CRUSHING = 18, \
                CUTTING = 18, \
                PIERCING = 35, \
                IMPALING = 7, \
                LASER = 8, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
