/mob/living/carbon/human/get_total_tint()
	. = 0
	if(isclothing(head))
		. += head.tint
	if(isclothing(wear_mask))
		. += wear_mask.tint
	if(isclothing(glasses))
		. += glasses.tint

	var/obj/item/organ/eyes/LE = LAZYACCESS(eye_organs, 1)
	var/obj/item/organ/eyes/RE = LAZYACCESS(eye_organs, 2)
	if(!RE && !LE)
		return INFINITY //we blind
