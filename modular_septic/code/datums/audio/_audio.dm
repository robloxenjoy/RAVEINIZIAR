/**
 * The audio_track datum is not redundant to the byond sound datum!
 * This simply works as a way to easily document the name, author and other information about audio tracks,
 * which is mostly useful for music.
 * These datums are global and shouldn't be deleted once created.
 */
/datum/audio_track
	/// Path to the file of the audio track
	var/file
	/// Duration in deciseconds of the audio track
	var/duration
	/// Name of the audio track
	var/name
	/// Author of the audio track
	var/author
	/// Album, LP or wherever the fuck this audio track came from
	var/collection
	/// Url that leads to this audio track
	var/url
