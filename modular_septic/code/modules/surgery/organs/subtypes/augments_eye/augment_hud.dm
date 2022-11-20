// HUD implants
/obj/item/organ/cyberimp/eyes/hud
	name = "HUD implant"
	desc = "These cybernetic eyes will display a HUD over everything you see. Maybe."
	organ_efficiency = list(ORGAN_SLOT_HUD = 100)
	var/HUD_type = 0
	var/HUD_trait = null

/obj/item/organ/cyberimp/eyes/hud/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(HUD_type)
		var/datum/atom_hud/atom_hud = GLOB.huds[HUD_type]
		atom_hud.add_hud_to(new_owner)
	if(HUD_trait)
		ADD_TRAIT(new_owner, HUD_trait, ORGAN_TRAIT)

/obj/item/organ/cyberimp/eyes/hud/Remove(mob/living/carbon/old_owner, special = FALSE)
	if(HUD_type)
		var/datum/atom_hud/atom_hud = GLOB.huds[HUD_type]
		atom_hud.remove_hud_from(old_owner)
	if(HUD_trait)
		REMOVE_TRAIT(old_owner, HUD_trait, ORGAN_TRAIT)
	return ..()
