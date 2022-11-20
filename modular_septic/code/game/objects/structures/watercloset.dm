//lifeweb sinks wtf
/obj/structure/sink
	var/can_bite = TRUE

/obj/structure/sink/attack_jaw(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(busy)
		to_chat(user, span_warning("Someone is using \the [src]."))
		return
	if(reagents.total_volume <= 0)
		to_chat(user, span_warning("\The [src] is empty. Fuck."))
		return
	to_chat(user, span_notice("I start drinking from [src]..."))
	busy = TRUE
	if(!do_after(user, 1.5 SECONDS, target = src))
		busy = FALSE
		return 1
	busy = FALSE
	reagents.trans_to(user, 5, methods = INGEST)
