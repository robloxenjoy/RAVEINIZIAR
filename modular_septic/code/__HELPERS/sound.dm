/proc/setup_audio_tracks()
	. = list()
	for(var/datum/audio_track/track as anything in init_subtypes(/datum/audio_track))
		if(!track.file)
			qdel(track)
			continue
		.[track.type] = track
