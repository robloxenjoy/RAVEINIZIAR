/datum/map_generator/nevado_surface_generator
	///2D list of all biomes based on heat and humidity combos.
	var/list/possible_biomes = list(
		BIOME_LOW_HUMIDITY = /datum/biome/plains/nevado_surface,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains/nevado_surface,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/jungle/deep/nevado_surface,
		BIOME_HIGH_HUMIDITY = /datum/biome/water/nevado_surface,
	)
	///Used to select "zoom" level into the perlin noise, higher numbers result in slower transitions
	var/perlin_zoom = 50

///Seeds the rust-g perlin noise with a random number.
/datum/map_generator/nevado_surface_generator/generate_terrain(list/turfs)
	. = ..()
	var/height_seed = rand(0, 50000)
	var/humidity_seed = rand(0, 50000)

	for(var/t in turfs) //Go through all the turfs and generate them
		var/turf/gen_turf = t
		var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))

		var/datum/biome/selected_biome
		if(height <= 0.75) //If height is less than 0.75, we generate biomes based on the humidity of the area.
			var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
			var/humidity_level  //Type of humidity zone we're in LOW-MEDIUM-HIGH
			switch(humidity)
				if(0 to 0.25)
					humidity_level = BIOME_LOW_HUMIDITY
				if(0.25 to 0.5)
					humidity_level = BIOME_LOWMEDIUM_HUMIDITY
				if(0.5 to 0.75)
					humidity_level = BIOME_HIGHMEDIUM_HUMIDITY
				if(0.75 to 1)
					humidity_level = BIOME_HIGH_HUMIDITY
			selected_biome = possible_biomes[humidity_level]
		else //Over 0.75; It's a mountain
			selected_biome = /datum/biome/mountain
		selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping
		selected_biome.generate_turf(gen_turf)
		CHECK_TICK
