/obj/machinery/camera

/obj/machinery/camera/Initialize(mapload, obj/structure/camera_assembly/CA)
	. = ..()
	AddElement(/datum/element/wall_mount)
