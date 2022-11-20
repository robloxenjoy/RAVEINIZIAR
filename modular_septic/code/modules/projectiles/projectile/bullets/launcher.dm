/obj/projectile/bullet/l40mm
	name ="40mm fragmentation grenade"
	desc = "MEU DEUS"
	icon = 'modular_septic/icons/obj/items/guns/projectiles/projectiles.dmi'
	icon_state= "bolter"
	damage = 60
	embedding = null
	shrapnel_type = null
	range = 7

/obj/projectile/bullet/l40mm/examine(mob/user)
	. = ..()
	user.client?.give_award(/datum/award/achievement/misc/meudeus, user)

/obj/projectile/bullet/l40mm/on_hit(atom/target, blocked = FALSE)
	. = ..()
	explosion(target, devastation_range = -1, heavy_impact_range = 2, light_impact_range = 4, flame_range = 2, flash_range = 3, adminlog = FALSE, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/gas40mm
	name ="40mm gassy grenade"
	desc = "OH MY GOODNESS GRACIOUS"
	icon = 'modular_septic/icons/obj/items/guns/projectiles/projectiles.dmi'
	icon_state= "bolter"
	damage = 30
	embedding = null
	shrapnel_type = null
	range = 7

/obj/projectile/bullet/gas40mm/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'modular_septic/sound/effects/gassy.ogg', 95, TRUE, 1)
	var/turf/gassyturf = get_turf(src)
	if(istype(gassyturf))
		gassyturf.pollute_turf(/datum/pollutant/incredible_gas, 1000)
	return BULLET_ACT_HIT

/obj/projectile/bullet/smoke40mm
	name ="40mm smoke grenade"
	desc = "MHM"
	icon = 'modular_septic/icons/obj/items/guns/projectiles/projectiles.dmi'
	icon_state= "bolter"
	damage = 30
	embedding = null
	shrapnel_type = null
	range = 7

/obj/projectile/bullet/smoke40mm/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'modular_septic/sound/effects/gas.ogg', 50, TRUE, 1)
	var/datum/effect_system/smoke_spread/bad/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	return BULLET_ACT_HIT

/obj/projectile/bullet/inc40mm
	name ="40mm incindiary grenade"
	desc = "MHM"
	icon = 'modular_septic/icons/obj/items/guns/projectiles/projectiles.dmi'
	icon_state= "bolter"
	damage = 30
	embedding = null
	shrapnel_type = null
	range = 7

/obj/projectile/bullet/inc40mm/on_hit(atom/target, blocked = FALSE)
	. = ..()
	explosion(target, devastation_range = -1, light_impact_range = 1, flame_range = 5, flash_range = 3, adminlog = FALSE, explosion_cause = src)
	return BULLET_ACT_HIT
