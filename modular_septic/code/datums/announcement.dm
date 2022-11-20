/datum/announcement
	/// Title of the announcement
	var/title
	/// Contents of the announcement
	var/contents

/datum/announcement/New(title, contents)
	. = ..()
	if(title)
		src.title = title
	if(contents)
		src.contents = contents
	SSstation.station_announcements += src

/datum/announcement/Destroy(force)
	. = ..()
	SSstation.station_announcements -= src
