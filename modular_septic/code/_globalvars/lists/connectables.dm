/*
Some details about how to use these lists
We're essentially trying to predict how doors/doorlike things will be placed/surounded, and use that to set their direction
It's a little finiky, and you may need to override the lists or worst case senario manually edit something's dir
But it should behave like you expect
*/

///What to connect with by default. Used by /atom/proc/auto_align(). This can be overriden
GLOBAL_LIST_INIT(default_connectables, typecacheof(list(
		/obj/machinery/door/airlock,
		/obj/machinery/door/poddoor,
		/obj/machinery/smartfridge,
		/obj/structure/girder/reinforced,
		/obj/structure/plasticflaps,
		/obj/machinery/power/shieldwallgen,
		/obj/structure/door_assembly,
	)))
///What to connect with at a lower priority by default. Used for stuff that we want to consider, but only if we don't find anything else
GLOBAL_LIST_INIT(lower_priority_connectables, typecacheof(list(
		/obj/machinery/door/window,
		/obj/structure/table,
		/obj/structure/window,
		/obj/structure/girder,
	)))
