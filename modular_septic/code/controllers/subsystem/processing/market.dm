PROCESSING_SUBSYSTEM_DEF(market)
	name = "Market"
	flags = SS_NO_INIT
	wait = 30 SECONDS
	var/list/obj/machinery/computer/exports/market_consoles = list()

/datum/controller/subsystem/processing/market/fire(resumed)
	. = ..()
	if(MC_TICK_CHECK)
		return
	// After we process export datums, we update the UI on every market console if necessary
	for(var/obj/machinery/computer/exports/market_console as anything in market_consoles)
		for(var/datum/tgui/window in SStgui.open_uis_by_src[REF(market_console)])
			window.send_full_update()
			playsound(market_console, 'modular_septic/sound/effects/jewish.wav', 65, 2)
			market_console.balloon_alert_to_viewers("Capitalism!")
			market_console.visible_message(span_warning("[icon2html(market_console)] [market_console] beeps rapidly, flashing a notification that the stock market has been updated!"))
		if(MC_TICK_CHECK)
			return
