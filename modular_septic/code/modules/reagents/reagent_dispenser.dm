/obj/structure/reagent_dispensers
	max_integrity = 150

/obj/structure/reagent_dispensers/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(. && atom_integrity <= 0)
		var/violence = (damage_flag == BULLET || damage_flag == LASER)
		boom(damage_type, violence)

/obj/structure/reagent_dispensers/boom(damage_type = BRUTE, violent = FALSE)
	rupture()

/obj/structure/reagent_dispensers/proc/rupture()
	audible_message(span_danger("[src] audibly ruptures!"))
	chem_splash(loc, 3, list(reagents))
	qdel(src)

/obj/structure/reagent_dispensers/fueltank/boom(damage_type = BRUTE, violent = FALSE)
	//change this later
	if(violent)
		explosion(src, heavy_impact_range = 1, light_impact_range = 5, flame_range = 5)
		qdel(src)
	else
		rupture()

/obj/structure/reagent_dispensers/fueltank/large
	max_integrity = 300

/obj/structure/reagent_dispensers/fueltank/large/boom(damage_type = BRUTE, violent = FALSE)
	if(violent)
		explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 7, flame_range = 12)
		qdel(src)
	else
		rupture()

/obj/structure/reagent_dispensers/fueltank/blob_act(obj/structure/blob/B)
	boom(violent = TRUE)

/obj/structure/reagent_dispensers/fueltank/ex_act()
	boom(violent = TRUE)

/obj/structure/reagent_dispensers/fueltank/zap_act(power, zap_flags)
	boom(violent = TRUE)
