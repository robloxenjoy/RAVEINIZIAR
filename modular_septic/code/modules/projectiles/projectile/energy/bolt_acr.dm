/obj/projectile/beam/bolt_acr
	icon = 'modular_septic/icons/obj/items/guns/projectiles/energy.dmi'
	icon_state = "demoncore"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS
	pass_flags_self = PASSTABLE | PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS
	light_range = 2
	light_power = 3
	light_color = LIGHT_COLOR_LIGHT_CYAN
	//should never happen
	ricochets_max = 1
	ricochet_chance = 100
	range = 6
	damage = 33
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	tracer_type = null
	impact_type = null

/obj/projectile/beam/bolt_acr/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(. && isliving(target))
		var/mob/living/living_target = target
		if(ishuman(living_target))
			target.AddComponent(/datum/component/irradiated, 600, RADIATION_SICKNESS_STAGE_1)
		living_target.add_client_colour(/datum/client_colour/glass_colour/blue)
		addtimer(CALLBACK(living_target, /mob/proc/remove_client_colour, /datum/client_colour/glass_colour/blue), 0.5 SECONDS)
