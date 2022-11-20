/obj/item/organ/tail/lizard
	name = "lizard tail"
	desc = "A severed lizard tail. Somewhere, no doubt, a lizard hater is very pleased with themselves."
	icon_state = "tail-lizard"
	tail_type = "Smooth"
	dna_block = DNA_LIZARD_TAIL_BLOCK
	mutantpart_colored = FALSE
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR = list("DDFFDD"))
	/// The mutantpart_key of the spiens
	var/spines_key = "spines"
	/// The sprite accessory this tail gives to the human it's attached to. If null, it will inherit its value from the human's DNA once attached.
	var/list/list/spines_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR = list("DDFFDD"))

/obj/item/organ/tail/lizard/update_overlays()
	. = ..()
	var/image/overlay = image(icon, src, "tail-lizard-detail")
	if(length(mutantpart_info))
		overlay.color = mutantpart_info[MUTANT_INDEX_COLOR]
	. += overlay

/obj/item/organ/tail/lizard/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(!(new_owner.status_flags & BUILDING_ORGANS))
		if(LAZYACCESS(spines_info, MUTANT_INDEX_NAME) && new_owner.has_dna())
			new_owner.dna.species.mutant_bodyparts[spines_key] = spines_info.Copy()
			new_owner.update_body()
			update_appearance()

/obj/item/organ/tail/lizard/Remove(mob/living/carbon/human/old_owner, special)
	. = ..()
	if(!(old_owner.status_flags & BUILDING_ORGANS))
		if(LAZYACCESS(spines_info, MUTANT_INDEX_NAME) && old_owner.has_dna())
			if(old_owner.dna.species.mutant_bodyparts[spines_key])
				spines_info = old_owner.dna.species.mutant_bodyparts[spines_key].Copy() //Update the info in case it was changed on the person
			old_owner.dna.species.mutant_bodyparts -= spines_key
			old_owner.update_body()
			update_appearance()

/obj/item/organ/tail/lizard/build_from_dna(datum/dna/dna_datum, associated_key)
	. = ..()
	if(!dna_datum.species.mutant_bodyparts[spines_key])
		return
	spines_info = dna_datum.species.mutant_bodyparts[spines_key].Copy()

/obj/item/organ/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh. Probably not usable for lizard wine."
