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
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.wav'
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
