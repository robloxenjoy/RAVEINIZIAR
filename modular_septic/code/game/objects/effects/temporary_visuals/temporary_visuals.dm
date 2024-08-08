/obj/effect/temp_visual
	icon = 'modular_septic/icons/effects/effects.dmi'

/obj/effect/temp_visual/firing_effect
	icon = 'icons/obj/guns/projectiles_impact.dmi'
	icon_state = "idiotism"
	plane = GAME_PLANE_FOV_HIDDEN
	layer = HITSCAN_PROJECTILE_LAYER
	light_system = STATIC_LIGHT
	light_range = 2
	light_power = 2
	light_color = LIGHT_COLOR_FIRE

/obj/effect/temp_visual/firing_effect/energy
	light_range = 2
	light_power = 2
	light_color = "#ff0006"

/obj/effect/temp_visual/firing_effect/energyblue
	light_range = 2
	light_power = 2
	light_color = "#0000ff"
