/proc/setup_bones()
	. = list()
	.[/obj/item/organ/bone] = new /obj/item/organ/bone()
	for(var/obj/item/organ/bone as anything in init_subtypes(/obj/item/organ/bone))
		.[bone.type] = bone

/proc/setup_tendons()
	. = list()
	.[/obj/item/organ/tendon] = new /obj/item/organ/tendon()
	for(var/obj/item/organ/tendon as anything in init_subtypes(/obj/item/organ/tendon))
		.[tendon.type] = tendon

/proc/setup_nerves()
	. = list()
	.[/obj/item/organ/nerve] = new /obj/item/organ/nerve()
	for(var/obj/item/organ/nerve as anything in init_subtypes(/obj/item/organ/nerve))
		.[nerve.type] = nerve

/proc/setup_arteries()
	. = list()
	.[/obj/item/organ/artery] = new /obj/item/organ/artery()
	for(var/obj/item/organ/artery as anything in init_subtypes(/obj/item/organ/artery))
		.[artery.type] = artery
