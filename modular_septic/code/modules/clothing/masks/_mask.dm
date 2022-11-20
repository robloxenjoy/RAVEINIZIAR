/obj/item/clothing/mask
	worn_icon_muzzled = 'modular_septic/icons/mob/clothing/mask_muzzled.dmi'
	mutant_variants = NONE
	carry_weight = 250 GRAMS
	/// Whether this mask lowers the pitch of the wearer's babbling
	var/lowers_pitch = FALSE

/obj/item/clothing/mask/proc/consume_filter_pollution(datum/pollution/pollution)
	return

/obj/item/clothing/mask/balaclava
	name = "\proper balaclava"
	desc = "TOXIN"
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "agent_balaclava"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "agent_balaclava"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	lowers_pitch = TRUE
