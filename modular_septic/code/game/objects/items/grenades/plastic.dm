/obj/item/grenade/c4/afterattack(atom/movable/bomb_target, mob/user, flag)
	. = ..()
	aim_dir = get_dir(user,bomb_target)
	if(!flag)
		return

	to_chat(user, span_notice("You start planting [src]. The timer is set to [det_time]..."))

	if(do_after(user, 30, target = bomb_target))
		if(!user.temporarilyRemoveItemFromInventory(src))
			return
		target = bomb_target

		message_admins("[ADMIN_LOOKUPFLW(user)] planted [name] on [target.name] at [ADMIN_VERBOSEJMP(target)] with [det_time] second fuse")
		log_game("[key_name(user)] planted [name] on [target.name] at [AREACOORD(user)] with a [det_time] second fuse")

		notify_ghosts("[user] has planted \a [src] on [target] with a [det_time] second fuse!", source = target, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Explosive Planted")

		moveToNullspace() //Yep

		if(istype(bomb_target, /obj/item)) //your crappy throwing star can't fly so good with a giant brick of c4 on it.
			var/obj/item/thrown_weapon = bomb_target
			thrown_weapon.throw_speed = max(1, (thrown_weapon.throw_speed - 3))
			thrown_weapon.throw_range = max(1, (thrown_weapon.throw_range - 3))
			if(thrown_weapon.embedding)
				thrown_weapon.embedding["embed_chance"] = 0
				thrown_weapon.updateEmbedding()
		else if(istype(bomb_target, /mob/living))
			plastic_overlay.layer = FLOAT_LAYER

		target.add_overlay(plastic_overlay)
		to_chat(user, span_notice("You plant the bomb. Timer counting down from [det_time]."))
		playsound(bomb_target, 'modular_septic/sound/weapons/c4_plant.wav', 60, TRUE)
		addtimer(CALLBACK(src, .proc/detonate), det_time*10)
