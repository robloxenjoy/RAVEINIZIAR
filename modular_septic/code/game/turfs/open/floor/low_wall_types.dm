/turf/open/floor/low_wall/reinforced
	name = "reinforced low wall"
	icon = 'modular_septic/icons/turf/tall/walls/low_walls/reinforced_metal.dmi'
	icon_state = "low_wall-0"
	base_icon_state = "low_wall"
	window_type = /obj/item/stack/sheet/rglass
	armor = list(MELEE = 80, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 25, BIO = 100, FIRE = 0, ACID = 100)
	max_integrity = 150
	damage_deflection = 11

/turf/open/floor/low_wall/reinforced/window
	start_with_window = TRUE

/turf/open/floor/low_wall/reinforced/grille_and_window
	start_with_grille = TRUE
	start_with_window = TRUE

/turf/open/floor/low_wall/mineral
	name = "mineral low wall"
	material_flags = MATERIAL_EFFECTS

/turf/open/floor/low_wall/mineral/wood
	name = "wooden low wall"
	window_type = /obj/item/stack/sheet/glass
	max_integrity = 150
	damage_deflection = 11
	custom_materials = list(/datum/material/wood = 2000)

/turf/open/floor/low_wall/mineral/wood/window
	start_with_window = TRUE

/turf/open/floor/low_wall/mineral/wood/grille_and_window
	start_with_grille = TRUE
	start_with_window = TRUE
