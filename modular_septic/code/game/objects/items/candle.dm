/obj/item/candle
	carry_weight = 100 GRAMS
	/// Pollutant type for scented candles
	var/scented_type

/obj/item/candle/process(delta_time)
	if(!lit)
		return PROCESS_KILL
	if(!infinite)
		wax -= delta_time
	if(wax <= 0)
		new /obj/item/trash/candle(loc)
		qdel(src)
	if(scented_type)
		var/turf/my_turf = get_turf(src)
		if(istype(my_turf))
			my_turf.pollute_turf(scented_type, 5)
	update_appearance()
	open_flame()

/obj/item/candle/vanilla
	name = "vanilla scented candle"
	scented_type = /datum/pollutant/fragrance/vanilla

/obj/item/candle/pear
	name = "pear scented candle"
	scented_type = /datum/pollutant/fragrance/pear

/obj/item/candle/amber
	name = "amber scented candle"
	scented_type = /datum/pollutant/fragrance/amber

/obj/item/candle/jasmine
	name = "jasmine scented candle"
	scented_type = /datum/pollutant/fragrance/jasmine

/obj/item/candle/mint
	name = "mint scented candle"
	scented_type = /datum/pollutant/fragrance/mint
