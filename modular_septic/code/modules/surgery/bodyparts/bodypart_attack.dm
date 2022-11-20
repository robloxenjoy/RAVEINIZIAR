/obj/item/bodypart/blob_act()
	take_damage(max_damage)

/obj/item/bodypart/attack(mob/living/carbon/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/human = M
		if(HAS_TRAIT(human, TRAIT_LIMBATTACHMENT))
			if(!human.get_bodypart(body_zone) && !animal_origin)
				user.temporarilyRemoveItemFromInventory(src, TRUE)
				if(!attach_limb(human))
					to_chat(user, span_warning("<b>[human]</b>'s body rejects [src]!"))
					forceMove(human.loc)
				if(human == user)
					human.visible_message(span_warning("<b>[human]</b> jams [src] into [human.p_their()] empty socket!"),\
					span_notice("I force [src] into my empty socket, and it locks in place!"))
				else
					human.visible_message(span_warning("<b>[user]</b> jams [src] into <b>[human]</b>'s empty socket!"),\
					span_notice("<b>[user]</b> forces [src] into my empty socket, and it locks into place!"))
				return TRUE
	return ..()

/obj/item/bodypart/attackby(obj/item/attacking_item, mob/user, params)
	if(attacking_item.get_sharpness())
		add_fingerprint(user)
		if(!LAZYLEN(contents))
			to_chat(user, span_warning("There is nothing left inside [src]!"))
			return
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message(span_warning("[user] begins to cut open [src]."),\
			span_notice("I begin to cut open [src]..."))
		if(do_after(user, 5 SECONDS, target = src))
			drop_organs(TRUE)
		return
	return ..()

/obj/item/bodypart/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(status == BODYPART_ORGANIC)
		playsound(src, 'sound/misc/splort.ogg', 50, TRUE, -1)
