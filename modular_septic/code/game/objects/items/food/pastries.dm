/obj/item/food/pancakes/raw/MakeGrillable()
	AddComponent(/datum/component/grillable,\
				cook_result = /obj/item/food/pancakes,\
				required_cook_time = rand(30 SECONDS, 40 SECONDS),\
				positive_result = TRUE,\
				use_large_steam_sprite = TRUE,\
				pollutant_type = /datum/pollutant/food/pancakes)
