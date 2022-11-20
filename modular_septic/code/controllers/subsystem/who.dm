/**
 * This subsystem mostly exists to populate and manage the who datums,
 * which themselves only get used to handle the who and adminwho tgui.
 */
SUBSYSTEM_DEF(who)
	name = "Who"
	flags = SS_NO_FIRE
	/// Who datum
	var/datum/who/who_datum
	/// Adminwho datum
	var/datum/adminwho/adminwho_datum

/datum/controller/subsystem/who/Initialize(start_timeofday)
	. = ..()
	who_datum = new()
	adminwho_datum = new()
