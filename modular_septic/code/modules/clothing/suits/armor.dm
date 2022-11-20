/obj/item/clothing/suit/armor
	body_parts_covered = CHEST|VITALS|GROIN

/obj/item/clothing/suit/armor/Initialize(mapload)
	. = ..()
	LoadComponent(/datum/component/shuffling, list(
				'modular_septic/sound/armor/gear_stereo1.wav'=1,
				'modular_septic/sound/armor/gear_stereo2.wav'=1,
				'modular_septic/sound/armor/gear_stereo3.wav'=1), 70, falloff_exponent = 20)

/obj/item/clothing/suit/armor/vest
	name = "slim type II armor vest"
	desc = "A slim version of the type I armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_slim"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_slim"
	//A decent kevlar vest weighs almost 3kg
	//But does not cover the groin
	carry_weight = 2.5 KILOGRAMS
	body_parts_covered = CHEST|VITALS
	equip_sound = 'modular_septic/sound/armor/equip/armor_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/armor_drop.wav'
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	max_integrity = 200
	integrity_failure = 0.1
	limb_integrity = 190
	repairable_by = /obj/item/stack/ballistic
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 20, \
				BOMB = 25, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 50, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
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

/obj/item/clothing/suit/armor/vest/alt
	name = "type II armor vest"
	desc = "A type II armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest"
	//Bulkier vest
	carry_weight = 6 KILOGRAMS
	body_parts_covered = CHEST|VITALS|GROIN

/obj/item/clothing/suit/armor/vest/alt/medium
	name = "\"Escapador\" type III+ armor vest"
	desc = "A type III+ armored vest that provides intermediate ballistic protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_medium"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_medium"
	max_integrity = 300
	integrity_failure = 0.05
	limb_integrity = 220
	repairable_by = /obj/item/stack/ballistic
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 20, \
				BOMB = 25, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 50, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
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
	carry_weight = 7 KILOGRAMS
	body_parts_covered = CHEST|VITALS|GROIN

/obj/item/clothing/suit/armor/vest/alt/heavy
	name = "\"Defesa Total\" type IV armor vest"
	desc = "A type IV armored plate carrier that provides intermediate ballistic protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_heavy"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_heavy"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 400
	integrity_failure = 0.04
	limb_integrity = 350
	repairable_by = /obj/item/stack/ballistic/plate
	subarmor = list(SUBARMOR_FLAGS = NONE, \
				EDGE_PROTECTION = 75, \
				CRUSHING = 28, \
				CUTTING = 28, \
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
	//Bulkierer vest
	carry_weight = 9 KILOGRAMS
	body_parts_covered = CHEST|VITALS|GROIN

/obj/item/clothing/suit/armor/vest/alt/ultraheavy
	name = "\"Princess\" type V armor vest"
	desc = "A type V armored plate carrier with pads that cover more then what a regular vest would allow."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_ultraheavy"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_ultraheavy"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 500
	integrity_failure = 0.04
	limb_integrity = 450
	repairable_by = /obj/item/stack/ballistic/plate
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
	//VEST WITH THAT BULK
	carry_weight = 15 KILOGRAMS
	body_parts_covered = NECK|CHEST|VITALS|GROIN

/obj/item/clothing/suit/armor/vest/alt/ultraheavy/Initialize(mapload)
	. = ..()
	var/datum/component/shuffling/shuffling = GetComponent(/datum/component/shuffling)
	if(shuffling)
		shuffling.override_squeak_sounds = list('modular_septic/sound/armor/heavygear_stereo1.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo2.ogg'=1,
												'modular_septic/sound/armor/heavygear_stereo3.ogg'=1)
		shuffling.volume = 70
		shuffling.sound_falloff_exponent = 20

/obj/item/clothing/suit/armor/vest/infiltrator
	name = "infiltrator vest"
	desc = "This vest appears to be made of of highly flexible materials that absorb impacts with ease, comes with both impact padding and ballistic padding."
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	icon_state = "infiltrator"
	worn_icon_state = "infiltrator"
	inhand_icon_state = "infiltrator"
	armor = null
	body_parts_covered = NECK|CHEST|VITALS|GROIN
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 45, \
				CRUSHING = 20, \
				CUTTING = 20, \
				PIERCING = 34, \
				IMPALING = 8, \
				LASER = 5, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 2, \
				ACID = 2, \
				MAGIC = 0, \
				WOUND = 0, \
				ORGAN = 0)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	strip_delay = 80
