SUBSYSTEM_DEF(antagonists)
	name = "Antagonists"
	flags = SS_NO_FIRE

/datum/controller/subsystem/antagonists/Initialize(start_timeofday)
	. = ..()
	GLOB.syndicate_employers = list("Dream Agent", "Dream HVAX")
	GLOB.normal_employers = list("Dream Agent", "Dream KVAX")
	GLOB.hijack_employers = list("Dream HVAX")
	GLOB.nanotrasen_employers = list("Dream KVAX")
