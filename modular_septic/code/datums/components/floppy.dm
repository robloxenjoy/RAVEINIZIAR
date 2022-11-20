// I couldn't think of a decent name and this is only used by floppa as of now, so floppy
/datum/component/floppy
	/// What icon_state we use while flopping
	var/floppy_state = ""
	/// The duration of our flopping
	var/flop_duration = 16
	/// If we are currently flopping, this timer tracks unflopping
	var/flop_timer

/datum/component/floppy/Initialize(floppy_state = "", flop_duration = 16)
	// sadly, humans do not possess the incredible ability to flop
	if(!isliving(parent) || ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	src.floppy_state = floppy_state
	src.flop_duration = flop_duration

/datum/component/floppy/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, .proc/got_touched)

/datum/component/floppy/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_ATTACK_HAND)
	stop_flopping()

/datum/component/floppy/proc/got_touched(mob/living/source, mob/living/petter, list/modifiers)
	SIGNAL_HANDLER

	//only flop when not being attacked
	if(!IS_HELP_INTENT(petter, modifiers))
		return

	start_flopping(source)

/datum/component/floppy/proc/start_flopping(mob/living/source)
	if(flop_timer)
		deltimer(flop_timer)
		flop_timer = null
	RegisterSignal(source, COMSIG_ATOM_UPDATE_ICON_STATE, .proc/icon_state_updated)
	source.update_appearance(UPDATE_ICON_STATE)
	flop_timer = addtimer(CALLBACK(src, .proc/stop_flopping, source), flop_duration, TIMER_STOPPABLE)

/datum/component/floppy/proc/stop_flopping(mob/living/source)
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_ICON_STATE)
	source.icon_state = initial(source.icon_state)
	source.update_appearance(UPDATE_ICON_STATE)
	if(flop_timer)
		deltimer(flop_timer)
	flop_timer = null

/datum/component/floppy/proc/icon_state_updated(mob/living/source)
	SIGNAL_HANDLER

	source.icon_state = floppy_state
