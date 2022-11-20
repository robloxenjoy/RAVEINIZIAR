// Sub stands for subtractible
#define SUBARMORID "subarmor-\
					[subarmor_flags]-\
					[edge_protection]-\
					[crushing]-\
					[cutting]-\
					[piercing]-\
					[impaling]-\
					[laser]-\
					[energy]-\
					[bomb]-\
					[bio]-\
					[fire]-\
					[acid]-\
					[magic]-\
					[wound]-\
					[organ]"

/datum/subarmor
	datum_flags = DF_USE_TAG
	var/subarmor_flags
	var/edge_protection
	var/crushing
	var/cutting
	var/piercing
	var/impaling
	var/laser
	var/energy
	var/bomb
	var/bio
	var/fire
	var/acid
	var/magic
	var/wound
	var/organ

/datum/subarmor/New(subarmor_flags = NONE, \
			edge_protection = 0,
			crushing = 0, \
			cutting = 0, \
			piercing = 0, \
			impaling = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	src.subarmor_flags = subarmor_flags
	src.edge_protection = edge_protection
	src.crushing = crushing
	src.cutting = cutting
	src.piercing = piercing
	src.impaling = impaling
	src.laser = laser
	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.fire = fire
	src.acid = acid
	src.magic = magic
	src.wound = wound
	src.organ = organ
	tag = SUBARMORID

/datum/subarmor/proc/modifyRating(subarmor_flags = NONE,
							edge_protection = 0, \
							cutting = 0, \
							piercing = 0, \
							impaling = 0,
							laser = 0, \
							energy = 0, \
							bomb = 0, \
							bio = 0, \
							fire = 0, \
							acid = 0, \
							magic = 0, \
							wound = 0, \
							organ = 0)
	return getSubarmor(src.subarmor_flags | subarmor_flags, \
					src.edge_protection+edge_protection, \
					src.crushing+crushing, \
					src.cutting+cutting, \
					src.piercing+piercing, \
					src.impaling+impaling, \
					src.laser+laser, \
					src.energy+energy, \
					src.bomb+bomb, \
					src.bio+bio, \
					src.fire+fire, \
					src.acid+acid, \
					src.magic+magic, \
					src.wound+wound, \
					src.organ+organ)

/datum/subarmor/proc/modifyAllRatings(modifier = 0)
	return getSubarmor(src.subarmor_flags,
				edge_protection+modifier,
				crushing+modifier, \
				cutting+modifier, \
				piercing+modifier, \
				impaling+modifier, \
				laser+modifier, \
				energy+modifier, \
				bomb+modifier, \
				bio+modifier, \
				fire+modifier, \
				acid+modifier, \
				magic+modifier, \
				wound+modifier, \
				organ+modifier)

/datum/subarmor/proc/setRating(subarmor_flags, \
						edge_protection, \
						crushing, \
						cutting, \
						piercing, \
						impaling, \
						laser, \
						energy, \
						bomb, \
						bio, \
						fire, \
						acid, \
						magic, \
						wound, \
						organ)
	return getSubarmor((isnull(subarmor_flags) ? src.subarmor_flags : subarmor_flags), \
					(isnull(edge_protection) ? src.edge_protection : edge_protection), \
					(isnull(crushing) ? src.crushing : crushing), \
					(isnull(cutting) ? src.cutting : cutting), \
					(isnull(piercing) ? src.piercing : piercing), \
					(isnull(impaling) ? src.impaling : impaling), \
					(isnull(laser) ? src.laser : laser), \
					(isnull(energy) ? src.energy : energy), \
					(isnull(bomb) ? src.bomb : bomb), \
					(isnull(bio) ? src.bio : bio), \
					(isnull(fire) ? src.fire : fire), \
					(isnull(acid) ? src.acid : acid), \
					(isnull(magic) ? src.magic : magic), \
					(isnull(wound) ? src.wound : wound), \
					(isnull(organ) ? src.organ : organ))

/datum/subarmor/proc/getRating(rating)
	return vars[rating]

/datum/subarmor/proc/getList()
	return list(SUBARMOR_FLAGS = subarmor_flags, \
				EDGE_PROTECTION = edge_protection, \
				CRUSHING = crushing, \
				CUTTING = cutting, \
				PIERCING = piercing, \
				IMPALING = impaling, \
				LASER = laser, \
				ENERGY = energy, \
				BOMB = bomb, \
				BIO = bio, \
				FIRE = fire, \
				ACID = acid, \
				MAGIC = magic, \
				WOUND = wound, \
				ORGAN = organ)

/datum/subarmor/proc/attachSubrmor(datum/subarmor/attached_armor)
	return getSubarmor(subarmor_flags | attached_armor.subarmor_flags, \
					edge_protection+attached_armor.edge_protection, \
					crushing+attached_armor.crushing, \
					cutting+attached_armor.cutting, \
					piercing+attached_armor.piercing, \
					impaling+attached_armor.impaling, \
					laser+attached_armor.laser, \
					energy+attached_armor.energy, \
					bomb+attached_armor.bomb, \
					bio+attached_armor.bio, \
					fire+attached_armor.fire, \
					acid+attached_armor.acid, \
					magic+attached_armor.magic, \
					wound+attached_armor.wound, \
					organ+attached_armor.organ)

/datum/subarmor/proc/detachSubrmor(datum/subarmor/detached_armor)
	return getSubarmor(subarmor_flags & ~detached_armor.subarmor_flags, \
					edge_protection-detached_armor.edge_protection, \
					crushing-detached_armor.crushing, \
					piercing-detached_armor.piercing, \
					impaling-detached_armor.impaling, \
					laser-detached_armor.laser, \
					energy-detached_armor.energy, \
					bomb-detached_armor.bomb, \
					bio-detached_armor.bio, \
					fire-detached_armor.fire, \
					acid-detached_armor.acid, \
					magic-detached_armor.magic, \
					wound-detached_armor.wound, \
					organ-detached_armor.organ)

/datum/subarmor/vv_edit_var(var_name, var_value)
	. = ..()
	tag = SUBARMORID // update tag in case armor values were edited

/proc/getSubarmor(subarmor_flags = NONE, \
			edge_protection = 0, \
			crushing = 0, \
			cutting = 0, \
			piercing = 0, \
			impaling = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	. = locate(SUBARMORID)
	if(!.)
		. = new /datum/subarmor(subarmor_flags, \
							edge_protection, \
							crushing, \
							cutting, \
							piercing, \
							impaling, \
							laser, \
							energy, \
							bomb, \
							bio, \
							fire, \
							acid, \
							magic, \
							wound, \
							organ)

#undef SUBARMORID
