/obj/item/organ/cyberimp/neck/selfdestruct
	name = "cranial depressurization implant"
	desc = "A strange implant. Probably should not be tampered."
	organ_flags = ORGAN_SYNTHETIC|ORGAN_VITAL
	icon = 'modular_septic/icons/obj/items/implants.dmi'
	icon_state = "implant-e"
	implant_overlay = null
	implant_overlay_color = null
	emp_vulnerability = 0
	scanner_hidden = TRUE

/obj/item/organ/cyberimp/neck/selfdestruct/Remove(mob/living/carbon/old_owner, special)
	var/old_zone = current_zone
	. = ..()
	if(!special && old_zone && !(old_owner.status_flags & BUILDING_ORGANS))
		var/obj/item/bodypart/explodie = old_owner.get_bodypart(old_zone)
		if(explodie)
			old_owner.visible_message(span_bolddanger("<b>[old_owner]</b>'s [explodie] implodes in a shower of gore!"))
			explodie.apply_dismember(WOUND_BLUNT, TRUE, FALSE)
