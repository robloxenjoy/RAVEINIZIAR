/datum/attribute_holder/sheet/traitor
	attribute_default = 0
	skill_default = null
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 3,
		SKILL_IMPACT_WEAPON_TWOHANDED = 3,
		SKILL_BRAWLING = 5,
		SKILL_WRESTLING = 4,
		SKILL_KNIFE = 2,
		SKILL_FORCESWORD = 5,
		SKILL_SHORTSWORD = 3,
		SKILL_SWORD_TWOHANDED = 0,
		SKILL_RAPIER = 0,
		SKILL_LONGSWORD = 1,
		SKILL_PISTOL = 4,
		SKILL_SMG = 4,
		SKILL_RIFLE = 3,
		SKILL_SHOTGUN = 4,
		SKILL_LAW = 2,
		SKILL_THROWING = 1,
		SKILL_ACROBATICS = 1,
		SKILL_ELECTRONICS = 8,
		SKILL_LOCKPICKING = 3,
	)

/datum/attribute_holder/sheet/traitor/on_add(datum/attribute_holder/plagiarist)
	. = ..()
	//we will always have at least 0 in these skills, this is intentional
	var/static/list/magic_attribute_variations = list(
		SKILL_IMPACT_WEAPON,
		SKILL_RIFLE,
		SKILL_ELECTRONICS,
		SKILL_LOCKPICKING,
	)
	for(var/attribute_type in magic_attribute_variations)
		if(ispath(attribute_type, SKILL))
			plagiarist.raw_attribute_list[attribute_type] = clamp(plagiarist.raw_attribute_list[attribute_type] + rand(-2, 2), plagiarist.skill_min, plagiarist.skill_max)
