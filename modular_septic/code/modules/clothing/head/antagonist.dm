/obj/item/clothing/head/denominator
	name = "darkened denominator's armored face cover"
	desc = "A mask with some ceramic plating put underneath the metal surface; classified under type IV ballistic protection."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "deno"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "deno"
	max_integrity = 200
	limb_integrity = 190
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 69, \
                CRUSHING = 22, \
                CUTTING = 22, \
                PIERCING = 45, \
                IMPALING = 12, \
                LASER = 32, \
                ENERGY = 20, \
                BOMB = 20, \
                BIO = 0, \
                FIRE = 30, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 2.5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.ogg'
	body_parts_covered = HEAD|FACE|JAW|EYES|NECK
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEEYES

/obj/item/clothing/head/denominator/shotgunner
	name = "darkened denominator shotgunner armored face cover"
	desc = "A mask with some ceramic plating put underneath the metal surface; classified under type IV ballistic protection, this one belongs to the shotgunner squad."
	icon_state = "deno_shotgunner"
	worn_icon_state = "deno_shotgunner"

/obj/item/clothing/head/denominator/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		user.apply_status_effect(/datum/status_effect/denominator_hud)

/obj/item/clothing/head/denominator/dropped(mob/living/user)
	. = ..()
	user.remove_status_effect(/datum/status_effect/denominator_hud)

/obj/item/clothing/head/bighatnice
	name = "Big Hat"
	desc = "Extraordinary and sexy hat. Plumpy."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "biglid"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "biglid"
	max_integrity = 160
	limb_integrity = 100
//	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	armor = list(MELEE = 1, BULLET = 1, LASER = 0, ENERGY = 3, BOMB = 0, BIO = 0, FIRE = 1, ACID = 1, WOUND = 1)
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	carry_weight = 200 GRAMS
	body_parts_covered = HEAD
	flags_inv = HIDEEARS

/obj/item/clothing/head/aphexcap
	name = "Aphex Cap"
	desc = "Good old cap."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "aphex_real"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "aphex_real"
	max_integrity = 160
	limb_integrity = 100
//	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	armor = list(MELEE = 1, BULLET = 1, LASER = 0, ENERGY = 3, BOMB = 0, BIO = 0, FIRE = 1, ACID = 1, WOUND = 1)
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	carry_weight = 200 GRAMS
	body_parts_covered = HEAD
	flags_inv = HIDEEARS

/obj/item/clothing/head/leather_headbag
	name = "Leather Headbag"
	desc = "So creepy..."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "leather_headbag"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "leather_headbag"
	max_integrity = 160
	limb_integrity = 100
//	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	armor = list(MELEE = 3, \
				BULLET = 3, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 1)
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	carry_weight = 200 GRAMS
	body_parts_covered = HEAD|FACE|JAW|EYES|NECK
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEEYES

/obj/item/clothing/head/blackhood
	name = "Blackhood"
	desc = "Only mysterious people wear clothes like this."
	icon = 'modular_pod/icons/obj/clothing/hats.dmi'
	icon_state = "black_hood"
	worn_icon = 'modular_pod/icons/mob/clothing/head.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "black_hood"
	max_integrity = 160
	limb_integrity = 100
	repairable_by_offhand = null
	integrity_failure = 0.1
	armor = list(MELEE = 4, \
				BULLET = 4, \
				LASER = 0, \
				ENERGY = 5, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 10, \
				ACID = 5, \
				WOUND = 1)
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	carry_weight = 150 GRAMS
	body_parts_covered = HEAD|NECK
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR