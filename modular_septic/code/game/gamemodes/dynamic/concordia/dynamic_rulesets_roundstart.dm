
//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/concordia/traitor
	name = "Traitors"
	persistent = TRUE
	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor
	minimum_required_age = 0
	protected_roles = list("Prisoner","Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	restricted_roles = list("AI", "Cyborg")
	required_candidates = 1
	weight = 5
	cost = 8 // Avoid raising traitor threat above this, as it is the default low cost ruleset.
	scaling_cost = 9
	requirements = list(8,8,8,8,8,8,8,8,8,8)
	antag_cap = list("denominator" = 24)
	var/autotraitor_cooldown = (15 MINUTES)
	COOLDOWN_DECLARE(autotraitor_cooldown_check)

/datum/dynamic_ruleset/roundstart/concordia/traitor/pre_execute(population)
	. = ..()
	COOLDOWN_START(src, autotraitor_cooldown_check, autotraitor_cooldown)
	var/num_traitors = get_antag_cap(population) * (scaled_times + 1)
	for (var/i = 1 to num_traitors)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.special_role = ROLE_TRAITOR
		M.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += M.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/concordia/traitor/rule_process()
	if (COOLDOWN_FINISHED(src, autotraitor_cooldown_check))
		COOLDOWN_START(src, autotraitor_cooldown_check, autotraitor_cooldown)
		log_game("DYNAMIC: Checking if we can turn someone into a traitor.")
		mode.picking_specific_rule(/datum/dynamic_ruleset/midround/autotraitor)
