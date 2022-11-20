/obj/item/organ/ears/fluffy
	name = "fluffy ears"
	icon_state = "ears-fluffy"
	dna_block = DNA_EARS_BLOCK
	mutantpart_key = "ears"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR = list("FFAA00"))

/obj/item/organ/ears/fluffy/update_overlays()
	. = ..()
	var/image/overlay = image(icon, src, "ears-fluffy-detail")
	if(length(mutantpart_info))
		overlay.color = mutantpart_info[MUTANT_INDEX_COLOR]
	. += overlay
