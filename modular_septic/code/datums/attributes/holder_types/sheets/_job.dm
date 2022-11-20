///job subtype so i can implement stat and skill variance
/datum/attribute_holder/sheet/job
	attribute_default = 0
	skill_default = null
	var/list/attribute_variance = 0

/datum/attribute_holder/sheet/job/New(mob/new_parent)
	. = ..()
	if(isnum(attribute_variance))
		var/og_variance = attribute_variance
		attribute_variance = list()
		for(var/thing in raw_attribute_list)
			if(!ispath(thing, STAT))
				continue
			attribute_variance[thing] = list(-og_variance, og_variance)
	else if(islist(attribute_variance) && (LAZYLEN(attribute_variance) == 2) && isnum(attribute_variance[1]) && isnum(attribute_variance[2]))
		var/list/og_variance = attribute_variance.Copy()
		attribute_variance = list()
		for(var/thing in raw_attribute_list)
			if(!ispath(thing, STAT))
				continue
			attribute_variance[thing] = list(og_variance[1], og_variance[2])

/datum/attribute_holder/sheet/job/on_add(datum/attribute_holder/plagiarist)
	. = ..()
	if(attribute_variance)
		for(var/path in plagiarist.raw_attribute_list)
			if(LAZYLEN(attribute_variance[path]) < 2)
				continue
			var/random = rand(attribute_variance[path][1], attribute_variance[path][2])
			if(ispath(path, SKILL))
				plagiarist.raw_attribute_list[path] = clamp(plagiarist.raw_attribute_list[path] + random, plagiarist.skill_min, plagiarist.skill_max)
			else
				plagiarist.raw_attribute_list[path] = clamp(plagiarist.raw_attribute_list[path] + random, plagiarist.attribute_min, plagiarist.attribute_max)
	//Perception is a dumb little snowflake
	if(!isnull(plagiarist.raw_attribute_list[STAT_PERCEPTION]))
		plagiarist.raw_attribute_list[STAT_PERCEPTION] = plagiarist.raw_attribute_list[STAT_INTELLIGENCE]
	//Will is a dumb little snowflake
	if(!isnull(plagiarist.raw_attribute_list[STAT_WILL]))
		plagiarist.raw_attribute_list[STAT_WILL] = plagiarist.raw_attribute_list[STAT_INTELLIGENCE]
