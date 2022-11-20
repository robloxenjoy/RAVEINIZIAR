/obj/item/organ/tail/fluffy
	name = "fluffy tail"
	icon_state = "tail-furry"
	mutantpart_colored = FALSE

/obj/item/organ/tail/fluffy/update_overlays()
	. = ..()
	var/image/overlay = image(icon, src, "tail-furry-detail")
	if(length(mutantpart_info))
		overlay.color = mutantpart_info[MUTANT_INDEX_COLOR]
	. += overlay

/obj/item/organ/tail/fluffy/no_wag
	can_wag = FALSE
