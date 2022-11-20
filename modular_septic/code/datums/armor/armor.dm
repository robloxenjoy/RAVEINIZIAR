#define ARMORID "armor-\
				[melee]-\
				[bullet]-\
				[laser]-\
				[energy]-\
				[bomb]-\
				[bio]-\
				[fire]-\
				[acid]-\
				[magic]-\
				[wound]-\
				[organ]"

/datum/armor
	var/organ

/datum/armor/New(melee = 0, \
			bullet = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	src.melee = melee
	src.bullet = bullet
	src.laser = laser
	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.fire = fire
	src.acid = acid
	src.magic = magic
	src.wound = wound
	src.consume = melee
	src.organ = organ
	tag = ARMORID

/datum/armor/modifyRating(melee = 0, \
							bullet = 0, \
							laser = 0, \
							energy = 0, \
							bomb = 0, \
							bio = 0, \
							fire = 0, \
							acid = 0, \
							magic = 0, \
							wound = 0, \
							organ = 0)
	return getArmor(src.melee+melee, \
					src.bullet+bullet, \
					src.laser+laser, \
					src.energy+energy, \
					src.bomb+bomb, \
					src.bio+bio, \
					src.fire+fire, \
					src.acid+acid, \
					src.magic+magic, \
					src.wound+wound, \
					src.organ+organ)

/datum/armor/modifyAllRatings(modifier = 0)
	return getArmor(melee+modifier, \
				bullet+modifier, \
				laser+modifier, \
				energy+modifier, \
				bomb+modifier, \
				bio+modifier, \
				fire+modifier, \
				acid+modifier, \
				magic+modifier, \
				wound+modifier, \
				organ+modifier)

/datum/armor/setRating(melee, bullet, laser, energy, bomb, bio, fire, acid, magic, wound, organ)
	return getArmor((isnull(melee) ? src.melee : melee),\
					(isnull(bullet) ? src.bullet : bullet),\
					(isnull(laser) ? src.laser : laser),\
					(isnull(energy) ? src.energy : energy),\
					(isnull(bomb) ? src.bomb : bomb),\
					(isnull(bio) ? src.bio : bio),\
					(isnull(fire) ? src.fire : fire),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(magic) ? src.magic : magic),\
					(isnull(wound) ? src.wound : wound), \
					(isnull(organ) ? src.organ : organ))

/datum/armor/getList()
	return list(MELEE = melee, \
				BULLET = bullet, \
				LASER = laser, \
				ENERGY = energy, \
				BOMB = bomb, \
				BIO = bio, \
				FIRE = fire, \
				ACID = acid, \
				MAGIC = magic, \
				WOUND = wound, \
				ORGAN = organ)

/datum/armor/attachArmor(datum/armor/attached_armor)
	return getArmor(melee+attached_armor.melee, \
					bullet+attached_armor.bullet, \
					laser+attached_armor.laser, \
					energy+attached_armor.energy, \
					bomb+attached_armor.bomb, \
					bio+attached_armor.bio, \
					fire+attached_armor.fire, \
					acid+attached_armor.acid, \
					magic+attached_armor.magic, \
					wound+attached_armor.wound, \
					organ+attached_armor.organ)

/datum/armor/detachArmor(datum/armor/detached_armor)
	return getArmor(melee-detached_armor.melee, \
					bullet-detached_armor.bullet, \
					laser-detached_armor.laser, \
					energy-detached_armor.energy, \
					bomb-detached_armor.bomb, \
					bio-detached_armor.bio, \
					fire-detached_armor.fire, \
					acid-detached_armor.acid, \
					magic-detached_armor.magic, \
					wound-detached_armor.wound, \
					organ-detached_armor.organ)

/datum/armor/vv_edit_var(var_name, var_value)
	. = ..()
	tag = ARMORID // update tag in case armor values were edited

/proc/getArmor(melee = 0, \
			bullet = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	. = locate(ARMORID)
	if(!.)
		. = new /datum/armor(melee, \
							bullet, \
							laser, \
							energy, \
							bomb, \
							bio, \
							fire, \
							acid, \
							magic, \
							wound, \
							organ)

#undef ARMORID
