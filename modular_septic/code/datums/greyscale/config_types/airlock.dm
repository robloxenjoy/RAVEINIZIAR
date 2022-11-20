/**
 * Airlock configurations.
 * Airlocks with no decorations are under /airlocks
 * Airlocks with see-through windows are under .../window
 * Airlocks with decorative color bands are under .../custom
 */

/datum/greyscale_config/airlocks
	name = "Solid Airlock"
	icon_file = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/greyscale_template.dmi'
	json_config = 'modular_septic/code/datums/greyscale/json_configs/airlock_plain.json'

/datum/greyscale_config/airlocks/custom
	name = "Airlock with Decorations"
	json_config = 'modular_septic/code/datums/greyscale/json_configs/airlock_custom.json'

/datum/greyscale_config/airlocks/window
	name = "Airlock with Window"
	json_config = 'modular_septic/code/datums/greyscale/json_configs/airlock_window.json'
