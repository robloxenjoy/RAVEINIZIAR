/turf/open/floor/trapdoor
	name = "trapdoor"
	desc = "Watch the FUCK out!"
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "trapdoor"
	base_icon_state = "trapdoor"
	baseturfs = /turf/open/openspace

/turf/open/floor/trapdoor/Initialize(mapload)
	. = ..()
	var/obj/item/assembly/trapdoor/our_assembly = find_nearest_assembly()
	AddComponent(/datum/component/trapdoor, FALSE, baseturfs, our_assembly)

/turf/open/floor/trapdoor/proc/find_nearest_assembly()
	for(var/turf/maybe_here in range(6, src))
		for(var/obj/item/trapdoor_remote/remote in maybe_here)
			if(remote.internals)
				return remote.internals
		for(var/obj/item/assembly/assembly in maybe_here)
			return assembly
