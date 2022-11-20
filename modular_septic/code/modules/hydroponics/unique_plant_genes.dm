/datum/plant_gene/trait/pollutant_production
	name = "Fragrance Production"

	var/obj/machinery/hydroponics/home_tray
	var/datum/pollutant/pollution_type = /datum/pollutant/miasma

/datum/plant_gene/trait/pollutant_production/on_new_seed(obj/item/seeds/new_seed)
	if(!..())
		return
	RegisterSignal(new_seed, COMSIG_SEED_ON_GROW, .proc/try_pollute)
	RegisterSignal(new_seed, COMSIG_PARENT_PREQDELETED, .proc/stop_polluting)

/datum/plant_gene/trait/pollutant_production/proc/try_pollute(obj/item/seeds/our_seed, obj/machinery/hydroponics/grown_tray)
	SIGNAL_HANDLER

	if(grown_tray.age < our_seed.maturation)
		return

	home_tray.AddElement(/datum/element/pollution_emitter, pollution_type, ((our_seed.potency - 50) / 25) * 15)

/datum/plant_gene/trait/pollutant_production/proc/stop_polluting()
	SIGNAL_HANDLER

	home_tray.RemoveElement(/datum/element/pollution_emitter)
	home_tray = null
