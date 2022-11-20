/proc/accessory_list_of_key_for_species(key, datum/species/species, mismatched, ckey)
	var/list/accessory_list = list()
	for(var/name in GLOB.sprite_accessories[key])
		var/datum/sprite_accessory/sprite_accessory = GLOB.sprite_accessories[key][name]
		if(!mismatched && sprite_accessory.recommended_species && !(species.id in sprite_accessory.recommended_species))
			continue
		accessory_list += sprite_accessory.name
	return accessory_list

/proc/random_accessory_of_key_for_species(key, datum/species/species, mismatched=FALSE, ckey)
	var/list/accessory_list = accessory_list_of_key_for_species(key, species, mismatched, ckey)
	if(!length(accessory_list))
		return
	var/datum/sprite_accessory/sprite_accessory = GLOB.sprite_accessories[key][pick(accessory_list)]
	if(!sprite_accessory)
		CRASH("Cant find random accessory of [key] key, for species [species.id]")
	return sprite_accessory

/proc/assemble_body_markings_from_set(datum/body_marking_set/body_marking_set, list/features, datum/species/pref_species)
	var/list/body_markings = list()
	for(var/name in body_marking_set.body_marking_list)
		var/datum/body_marking/body_marking = GLOB.body_markings[name]
		for(var/zone in GLOB.body_markings_per_limb)
			var/list/marking_list = GLOB.body_markings_per_limb[zone]
			if(name in marking_list)
				if(!body_markings[zone])
					body_markings[zone] = list()
				body_markings[zone][name] = body_marking.get_default_color(features, pref_species)
	return body_markings

#define TILES_PER_SECOND 0.7

/proc/recoil_camera(mob/camera_mob, duration = 1, angle = 180, strength = 1, easing = CUBIC_EASING|EASE_OUT)
	if(!camera_mob || !camera_mob.client || duration < 1 || !easing)
		return
	var/client/camera_client = camera_mob.client

	angle = clamp(angle, 0, 360)
	var/hypotenuse = strength*world.icon_size
	var/offset_y = FLOOR(hypotenuse*sin(angle), 0.1)
	var/offset_x = FLOOR(hypotenuse*-cos(angle), 0.1)

	testing("angle: [angle]")
	testing("offset_y: [offset_y]")
	testing("offset_x: [offset_x]")
	animate(camera_client, pixel_x = offset_x, pixel_y = offset_y, time = duration, easing = easing, flags = ANIMATION_RELATIVE)
	animate(pixel_x = -offset_x, pixel_y = -offset_y, time = duration, easing = easing, flags = ANIMATION_RELATIVE)

#undef TILES_PER_SECOND
