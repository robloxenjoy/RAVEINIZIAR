#define MAX_NOTICES 5
/obj/structure/noticeboard
	var/list/spawn_notices

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()
	if(!mapload)
		return

	for(var/notice in spawn_notices)
		new notice(src)
		notices++

	if(notices > MAX_NOTICES)
		icon_state = "nboard05"
		CRASH("Notice board has more mapload notices than allowed")

	icon_state = "nboard0[notices]"
