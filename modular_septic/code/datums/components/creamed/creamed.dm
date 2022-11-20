/datum/component/creamed/cream

/datum/component/creamed/cream/cream()
	. = ..()
	if(.)
		add_memory_in_range(parent, 7, MEMORY_CREAMPIED, list(DETAIL_PROTAGONIST = parent), story_value = STORY_VALUE_OKAY, memory_flags = MEMORY_CHECK_BLINDNESS, protagonist_memory_flags = NONE)
