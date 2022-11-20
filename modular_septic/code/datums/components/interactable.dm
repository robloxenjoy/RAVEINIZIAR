//Add this component to an atom to make them sexable, basically
/datum/component/interactable
	COOLDOWN_DECLARE(next_interaction)
	COOLDOWN_DECLARE(next_sexual_interaction)
	/// Last world.time we did an interaction
	var/last_interaction_as_user_time = 0
	/// Last world.time we received an interaction
	var/last_interaction_as_target_time = 0
	/// Does not need to be a weakref since interaction datums aren't supposed to be deleted
	var/datum/interaction/last_interaction_as_user
	/// Does not need to be a weakref since interaction datums aren't supposed to be deleted
	var/datum/interaction/last_interaction_as_target
	/// Used to clear var/last_interaction_as_user
	var/clear_user_interaction_timer
	/// Used to clear var/last_interaction_as_target
	var/clear_target_interaction_timer

/datum/component/interactable/Initialize()
	if(!isatom(parent) || isarea(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/interactable/Destroy(force, silent)
	. = ..()
	last_interaction_as_user = null
	last_interaction_as_target = null
	if(clear_user_interaction_timer)
		deltimer(clear_user_interaction_timer)
		clear_user_interaction_timer = null
	if(clear_target_interaction_timer)
		deltimer(clear_target_interaction_timer)
		clear_target_interaction_timer = null

/datum/component/interactable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOUSEDROP_ONTO, .proc/mousedrop)
	RegisterSignal(parent, COMSIG_INTERACTABLE_TRY_INTERACT, .proc/try_interact)
	RegisterSignal(parent, COMSIG_INTERACTABLE_COOLDOWN, .proc/on_cooldown)
	RegisterSignal(parent, COMSIG_INTERACTABLE_SEX_COOLDOWN, .proc/on_sex_cooldown)

/datum/component/interactable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOUSEDROP_ONTO)
	UnregisterSignal(parent, COMSIG_INTERACTABLE_TRY_INTERACT)
	UnregisterSignal(parent, COMSIG_INTERACTABLE_COOLDOWN)
	UnregisterSignal(parent, COMSIG_INTERACTABLE_SEX_COOLDOWN)

/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InteractionMenu")
		ui.set_autoupdate(TRUE)
		ui.open()

/datum/component/interactable/ui_state(mob/user)
	return GLOB.always_state

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	var/atom/atom_parent = parent
	if(get_dist(user, atom_parent) > DEFAULT_MESSAGE_RANGE)
		return UI_CLOSE
	return min(
		ui_status_only_living(user, atom_parent),
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, atom_parent),
		),
	)

/datum/component/interactable/ui_data(mob/user)
	var/list/data = list()
	var/datum/component/interactable/user_interactable = user.GetComponent(/datum/component/interactable)
	var/atom/target = parent

	var/list/categories = list()
	for(var/datum/interaction/interaction in get_interactions_with(user_interactable))
		if(!categories[interaction.category])
			categories[interaction.category] = list("name" = interaction.category, "interactions" = list())
		var/list/this_interaction = list()
		this_interaction["name"] = interaction.name
		this_interaction["desc"] = interaction.desc
		this_interaction["button_icon"] = interaction.button_icon
		this_interaction["block_interact"] = FALSE
		if((interaction.interaction_flags & INTERACTION_RESPECT_COOLDOWN) && !COOLDOWN_FINISHED(src, next_interaction))
			this_interaction["block_interact"] = TRUE
		else if((interaction.interaction_flags & INTERACTION_RESPECT_SEX_COOLDOWN) && !COOLDOWN_FINISHED(src, next_sexual_interaction))
			this_interaction["block_interact"] = TRUE

		categories[interaction.category]["interactions"] += list(this_interaction)
	data["target_name"] = target.name
	data["categories"] = list()
	for(var/category in categories)
		data["categories"] += list(categories[category])
	if(user_interactable)
		data["block_interact"] = !COOLDOWN_FINISHED(user_interactable, next_interaction)
	return data

/datum/component/interactable/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if((action == "interact") && params["interaction"])
		var/datum/interaction/interact = GLOB.name_to_interaction_datum[params["interaction"]]
		if(interact)
			var/mob/living/user = usr
			var/datum/component/interactable/user_interactable = user.GetComponent(/datum/component/interactable)
			if(interact.allow_interaction(user_interactable, src) && interact.do_interaction(user_interactable, src))
				interact.after_interact(user_interactable, src)
			return TRUE

/datum/component/interactable/proc/mousedrop(atom/dropped_atom, atom/movable/receiver, mob/user, params)
	SIGNAL_HANDLER
	if((dropped_atom == parent) && (user == parent))
		if(SEND_SIGNAL(receiver, COMSIG_INTERACTABLE_TRY_INTERACT, user))
			return COMPONENT_NO_MOUSEDROP

/datum/component/interactable/proc/try_interact(atom/source, mob/living/user)
	SIGNAL_HANDLER

	. = TRUE
	var/mob/living/carbon/human/human_user = user
	//TK or distance check
	if((get_dist(parent, user) > 1) && !(istype(human_user) && human_user.dna.check_mutation(TK)))
		return FALSE
	var/datum/component/interactable/user_interactable = user.GetComponent(/datum/component/interactable)
	if(!user_interactable)
		return FALSE
	INVOKE_ASYNC(src, .proc/ui_interact, user)

/datum/component/interactable/proc/on_cooldown()
	SIGNAL_HANDLER

	return COOLDOWN_FINISHED(src, next_interaction)

/datum/component/interactable/proc/on_sex_cooldown()
	SIGNAL_HANDLER

	return COOLDOWN_FINISHED(src, next_sexual_interaction)

/datum/component/interactable/proc/get_interactions_with(datum/component/interactable/user)
	. = list()
	for(var/thing in GLOB.name_to_interaction_datum)
		var/datum/interaction/interact = GLOB.name_to_interaction_datum[thing]
		//we want to display interactions even if we are on cooldown
		if(interact.allow_interaction(user, src, TRUE, FALSE))
			. |= interact

/datum/component/interactable/proc/clear_user_interaction()
	last_interaction_as_user = null

/datum/component/interactable/proc/clear_target_interaction()
	last_interaction_as_target = null
