// ОДЁЖКА ВСЯКАЯ

/obj/item/clothing/under/codec/purp
	name = "Одёжка"
	desc = "Хорошего качества."
	icon = 'modular_pod/icons/obj/clothing/under/under.dmi'
	icon_state = "pur"
	worn_icon = 'modular_pod/icons/mob/clothing/under/under.dmi'
	worn_icon_state = "pur"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "soldat"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	armor = list(MELEE = 1, BULLET = 1, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 2, ACID = 2, WOUND = 1)
	carry_weight = 300 GRAMS
	can_adjust = FALSE
	body_parts_covered = CHEST|VITALS|ARMS
/*
	var/picked

/obj/item/clothing/under/codec/purp/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/under/codec/purp/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Выбери пометку.","Дизайн!") as null|anything in list("Никакая", "Символ", "Сплит")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "Символ")
		design = null
		design = input(user, "Выбери символ.","Дизайн!") as null|anything in list("life")
		if(!design)
			return
		design = "_[design]"
	var/colorone = input(user, "Выбери основной цвет.","Дизайн!") as color|null
	if(!colorone)
		return
	var/colortwo
	if(design != "Никакая")
		colortwo = input(user, "Выбери второй цвет.","Дизайн!") as color|null
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	picked = TRUE
	if(design != "Никакая")
		detail_tag = design
	switch(design)
		if("Сплит")
			detail_tag = "_spl"
	color = colorone
	if(colortwo)
		detail_color = colortwo
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_w_uniform()

/obj/item/clothing/under/codec/purp/area/red
	picked = TRUE
	detail_color = "#f84e2d"
	detail_tag = "_spl"

/obj/item/clothing/under/codec/purp/area/blue
	picked = TRUE
	detail_color = "#2d4ef8"
	detail_tag = "_spl"

/obj/item/clothing/under/codec/purp/area/Initialize(mapload)
	. = ..()
	update_icon()
*/
// ШТАНИШКИ

/obj/item/clothing/pants/codec/purp
	name = "Штаны"
	desc = "Ну ведь, хорошее качество!"
	icon = 'modular_pod/icons/obj/clothing/pants.dmi'
	icon_state = "pur_pants"
	worn_icon = 'modular_pod/icons/mob/clothing/pants.dmi'
	worn_icon_state = "pur_pants"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	max_integrity = 100
	integrity_failure = 0.1
	limb_integrity = 90
	repairable_by = /obj/item/stack/ballistic
	carry_weight = 400 GRAMS
	armor = list(MELEE = 1, BULLET = 1, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 2, ACID = 2, WOUND = 1)

/obj/item/clothing/under/codec/purp/black
	color = "#151414"

/obj/item/clothing/pants/codec/purp/black
	color = "#151414"

/obj/item/clothing/under/codec/purp/red
	color = "#933400"

/obj/item/clothing/pants/codec/purp/red
	color = "#933400"
