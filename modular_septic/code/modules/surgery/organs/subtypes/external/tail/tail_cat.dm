/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	icon_state = "tail-cat"
	tail_type = "Cat"
	mutantpart_colored = FALSE
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR = list("FFAA00"))

/obj/item/organ/tail/cat/update_overlays()
	. = ..()
	var/image/overlay = image(icon, src, "tail-cat-detail")
	if(length(mutantpart_info))
		overlay.color = mutantpart_info[MUTANT_INDEX_COLOR]
	. += overlay
