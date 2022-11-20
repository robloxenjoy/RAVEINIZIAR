//////////////////////////////////////////////
//                                          //
//            MIDROUND RULESETS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/concordia // Can be drafted once in a while during a round
	ruletype = "Midround Concordia"
	/// If the ruleset should be restricted from ghost roles.
	restrict_ghost_roles = TRUE
	/// What mob type the ruleset is restricted to.
	required_type = /mob/living/carbon/human
	list/living_players = list()
	list/living_antags = list()
	list/dead_players = list()
	list/list_observers = list()

/datum/dynamic_ruleset/midround/concordia/from_ghosts
	weight = 0
	required_type = /mob/dead/observer
	/// Whether the ruleset should call generate_ruleset_body or not.
	var/makeBody = TRUE
	/// The rule needs this many applicants to be properly executed.
	var/required_applicants = 1

/datum/dynamic_ruleset/midround/concordia/trim_candidates()
	living_players = trim_list(GLOB.alive_player_list)
	living_antags = trim_list(GLOB.current_living_antags)
	dead_players = trim_list(GLOB.dead_player_list)
	list_observers = trim_list(GLOB.current_observers_list)

/datum/dynamic_ruleset/midround/concordia/trim_list(list/L = list())
	var/list/trimmed_list = L.Copy()
	for(var/mob/M in trimmed_list)
		if (!istype(M, required_type))
			trimmed_list.Remove(M)
			continue
		if (!M.client) // Are they connected?
			trimmed_list.Remove(M)
			continue
		if(M.client.get_remaining_days(minimum_required_age) > 0)
			trimmed_list.Remove(M)
			continue
		if (!((antag_preference || antag_flag) in M.client.prefs.be_special))
			trimmed_list.Remove(M)
			continue
		if (is_banned_from(M.ckey, list(antag_flag_override || antag_flag, ROLE_SYNDICATE)))
			trimmed_list.Remove(M)
			continue
		if (M.mind)
			if (restrict_ghost_roles && (M.mind.assigned_role.title in GLOB.exp_specialmap[EXP_TYPE_SPECIAL])) // Are they playing a ghost role?
				trimmed_list.Remove(M)
				continue
			if (M.mind.assigned_role.title in restricted_roles) // Does their job allow it?
				trimmed_list.Remove(M)
				continue
			if ((exclusive_roles.len > 0) && !(M.mind.assigned_role.title in exclusive_roles)) // Is the rule exclusive to their job?
				trimmed_list.Remove(M)
				continue
	return trimmed_list

// You can then for example prompt dead players in execute() to join as strike teams or whatever
// Or autotator someone

// IMPORTANT, since /datum/dynamic_ruleset/midround/concordia may accept candidates from both living, dead, and even antag players, you need to manually check whether there are enough candidates
// (see /datum/dynamic_ruleset/midround/concordia/autotraitor/ready(forced = FALSE) for example)
/datum/dynamic_ruleset/midround/concordia/ready(forced = FALSE)
	if (!forced)
		var/job_check = 0
		if (enemy_roles.len > 0)
			for (var/mob/M in GLOB.alive_player_list)
				if (M.stat == DEAD || !M.client)
					continue // Dead/disconnected players cannot count as opponents
				if (M.mind && (M.mind.assigned_role.title in enemy_roles) && (!(M in candidates) || (M.mind.assigned_role.title in restricted_roles)))
					job_check++ // Checking for "enemies" (such as sec officers). To be counters, they must either not be candidates to that rule, or have a job that restricts them from it

		var/threat = round(mode.threat_level/10)
		if (job_check < required_enemies[threat])
			return FALSE
	return TRUE

/datum/dynamic_ruleset/midround/concordia/from_ghosts/execute()
	var/list/possible_candidates = list()
	possible_candidates.Add(dead_players)
	possible_candidates.Add(list_observers)
	send_applications(possible_candidates)
	if(assigned.len > 0)
		return TRUE
	else
		return FALSE

/// This sends a poll to ghosts if they want to be a ghost spawn from a ruleset.
/datum/dynamic_ruleset/midround/concordia/from_ghosts/send_applications(list/possible_volunteers = list())
	if (possible_volunteers.len <= 0) // This shouldn't happen, as ready() should return FALSE if there is not a single valid candidate
		message_admins("Possible volunteers was 0. This shouldn't appear, because of ready(), unless you forced it!")
		return
	message_admins("Polling [possible_volunteers.len] players to apply for the [name] ruleset.")
	log_game("DYNAMIC: Polling [possible_volunteers.len] players to apply for the [name] ruleset.")

	candidates = poll_ghost_candidates("The mode is looking for volunteers to become [antag_flag] for [name]", antag_flag_override, antag_flag || antag_flag_override, poll_time = 300)

	if(!candidates || candidates.len <= 0)
		mode.dynamic_log("The ruleset [name] received no applications.")
		mode.executed_rules -= src
		attempt_replacement()
		return

	message_admins("[candidates.len] players volunteered for the ruleset [name].")
	log_game("DYNAMIC: [candidates.len] players volunteered for [name].")
	review_applications()

/// Here is where you can check if your ghost applicants are valid for the ruleset.
/// Called by send_applications().
/datum/dynamic_ruleset/midround/concordia/from_ghosts/review_applications()
	if(candidates.len < required_applicants)
		mode.executed_rules -= src
		return
	for (var/i = 1, i <= required_candidates, i++)
		if(candidates.len <= 0)
			break
		var/mob/applicant = pick(candidates)
		candidates -= applicant
		if(!isobserver(applicant))
			if(applicant.stat == DEAD) // Not an observer? If they're dead, make them one.
				applicant = applicant.ghostize(FALSE)
			else // Not dead? Disregard them, pick a new applicant
				i--
				continue

		if(!applicant)
			i--
			continue

		var/mob/new_character = applicant

		if (makeBody)
			new_character = generate_ruleset_body(applicant)

		finish_setup(new_character, i)
		assigned += applicant
		notify_ghosts("[new_character] has been picked for the ruleset [name]!", source = new_character, action = NOTIFY_ORBIT, header="Something Interesting!")

/datum/dynamic_ruleset/midround/concordia/from_ghosts/generate_ruleset_body(mob/applicant)
	var/mob/living/carbon/human/new_character = make_body(applicant)
	new_character.dna.remove_all_mutations()
	return new_character

/datum/dynamic_ruleset/midround/concordia/from_ghosts/finish_setup(mob/new_character, index)
	var/datum/antagonist/new_role = new antag_datum()
	setup_role(new_role)
	new_character.mind.add_antag_datum(new_role)
	new_character.mind.special_role = antag_flag

/datum/dynamic_ruleset/midround/concordia/from_ghosts/setup_role(datum/antagonist/new_role)
	return

/// Fired when there are no valid candidates. Will spawn a sleeper agent or latejoin traitor.
/datum/dynamic_ruleset/midround/concordia/from_ghosts/attempt_replacement()
	var/datum/dynamic_ruleset/midround/concordia/autotraitor/sleeper_agent = new

	// Otherwise, it has a chance to fail. We don't want that, since this is already pretty unlikely.
	sleeper_agent.has_failure_chance = FALSE

	mode.configure_ruleset(sleeper_agent)

	if (!mode.picking_specific_rule(sleeper_agent))
		return

	mode.picking_specific_rule(/datum/dynamic_ruleset/latejoin/infiltrator)

//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/concordia/autotraitor
	name = "Sleeper Agent"
	antag_datum = /datum/antagonist/traitor
	antag_flag = ROLE_SLEEPER_AGENT
	antag_flag_override = ROLE_TRAITOR
	protected_roles = list("Head of Security", "Captain")
	restricted_roles = list("Cyborg", "AI", "Positronic Brain")
	required_candidates = 1
	weight = 7
	cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	repeatable = TRUE

	/// Whether or not this instance of sleeper agent should be randomly acceptable.
	/// If TRUE, then this has a threat level% chance to succeed.
	var/has_failure_chance = TRUE

/datum/dynamic_ruleset/midround/concordia/autotraitor/acceptable(population = 0, threat = 0)
	var/player_count = GLOB.alive_player_list.len
	var/antag_count = GLOB.current_living_antags.len
	var/max_traitors = round(player_count / 10) + 1

	// adding traitors if the antag population is getting low
	var/too_little_antags = antag_count < max_traitors
	if (!too_little_antags)
		log_game("DYNAMIC: Too many living antags compared to living players ([antag_count] living antags, [player_count] living players, [max_traitors] max traitors)")
		return FALSE

	if (has_failure_chance && !prob(mode.threat_level))
		log_game("DYNAMIC: Random chance to roll autotraitor failed, it was a [mode.threat_level]% chance.")
		return FALSE

	return ..()

/datum/dynamic_ruleset/midround/concordia/autotraitor/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
		else if(is_centcom_level(player.z))
			living_players -= player // We don't autotator people in CentCom
		else if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't autotator people with roles already

/datum/dynamic_ruleset/midround/concordia/autotraitor/ready(forced = FALSE)
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/concordia/autotraitor/execute()
	var/mob/M = pick(living_players)
	assigned += M
	living_players -= M
	var/datum/antagonist/traitor/newTraitor = new
	M.mind.add_antag_datum(newTraitor)
	message_admins("[ADMIN_LOOKUPFLW(M)] was selected by the [name] ruleset and has been made into a midround traitor.")
	log_game("DYNAMIC: [key_name(M)] was selected by the [name] ruleset and has been made into a midround traitor.")
	return TRUE

//////////////////////////////////////////////
//                                          //
//          NUCLEAR OPERATIVES (MIDROUND)   //
//                                          //
//////////////////////////////////////////////
/* SEPTIC EDIT POSTPONE
/datum/dynamic_ruleset/midround/concordia/from_ghosts/nuclear
	name = "Nuclear Assault"
	antag_flag = ROLE_OPERATIVE_MIDROUND
	antag_flag_override = ROLE_OPERATIVE
	antag_datum = /datum/antagonist/nukeop
	enemy_roles = list("AI", "Cyborg", "Security Officer", "Warden","Detective","Head of Security", "Captain")
	required_enemies = list(3,3,3,3,3,2,1,1,0,0)
	required_candidates = 5
	weight = 5
	cost = 35
	requirements = list(90,90,90,80,60,40,30,20,10,10)
	var/list/operative_cap = list(2,2,3,3,4,5,5,5,5,5)
	var/datum/team/nuclear/nuke_team
	flags = HIGH_IMPACT_RULESET

/datum/dynamic_ruleset/midround/concordia/from_ghosts/nuclear/acceptable(population=0, threat=0)
	if (locate(/datum/dynamic_ruleset/roundstart/nuclear) in mode.executed_rules)
		return FALSE // Unavailable if nuke ops were already sent at roundstart
	indice_pop = min(operative_cap.len, round(living_players.len/5)+1)
	required_candidates = operative_cap[indice_pop]
	return ..()

/datum/dynamic_ruleset/midround/concordia/from_ghosts/nuclear/ready(forced = FALSE)
	if (required_candidates > (dead_players.len + list_observers.len))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/concordia/from_ghosts/nuclear/finish_setup(mob/new_character, index)
	new_character.mind.set_assigned_role(SSjob.GetJobType(/datum/job/nuclear_operative))
	new_character.mind.special_role = ROLE_NUCLEAR_OPERATIVE
	if (index == 1) // Our first guy is the leader
		var/datum/antagonist/nukeop/leader/new_role = new
		nuke_team = new_role.nuke_team
		new_character.mind.add_antag_datum(new_role)
	else
		return ..()

*/
