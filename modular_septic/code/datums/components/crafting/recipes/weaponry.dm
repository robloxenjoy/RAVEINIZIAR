/datum/crafting_recipe/solitario //SABER
	name = "Solitario-SD \"SABER\" Conversion"
	result = /obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/no_mag
	tool_behaviors = list(TOOL_SCREWDRIVER)
	reqs = list(/obj/item/gun/ballistic/automatic/remis/smg/solitario = 1,
				/obj/item/ballistic_mechanisms/solitario_sd = 1,
				/obj/item/suppressor = 1)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/visor //VISOR ATTACHMENT
	name = "Visor attachment for the Touro-5 Helmet"
	result = /obj/item/clothing/head/helmet/heavy/visor
	reqs = list(/obj/item/clothing/head/helmet/heavy = 1,
				/obj/item/ballistic_mechanisms/visor = 1)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/visor/on_craft_completion(mob/user, atom/result)
	playsound(user.loc, 'modular_septic/sound/weapons/guns/mod_use.wav', 65)
	return
