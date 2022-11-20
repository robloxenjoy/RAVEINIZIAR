/datum/status_effect/earfuck_hud
	id = "earfuck_hud"
	duration = -1
	tick_interval = 2
	alert_type = null

/datum/status_effect/earfuck_hud/on_apply()
	. = ..()
	owner.overlay_fullscreen("earfuck", /atom/movable/screen/fullscreen/earfuck)
	owner.overlay_fullscreen("blackie", /atom/movable/screen/fullscreen/black_bars)

/datum/status_effect/earfuck_hud/on_remove()
	. = ..()
	owner.clear_fullscreen("earfuck")
	owner.clear_fullscreen("blackie")
