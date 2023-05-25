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
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 30, \
				CRUSHING = 22, \
				CUTTING = 24, \
				PIERCING = 30, \
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
	resistance_flags = FIRE_PROOF | ACID_PROOF
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