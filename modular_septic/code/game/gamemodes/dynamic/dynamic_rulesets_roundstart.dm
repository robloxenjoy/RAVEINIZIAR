/datum/dynamic_ruleset/roundstart/warwar
	name = "Warwar"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/warwar/acceptable(population, threat_level)
	return TRUE

/datum/dynamic_ruleset/roundstart/warwar/ready(population, forced)
	return TRUE

/datum/dynamic_ruleset/roundstart/warwar/pre_execute()
	. = ..()
	message_admins("Starting a round of WARWAR!")
	log_game("DYNAMIC: Starting a round of Warwar.")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: WARWAR ruleset set threat to 0."
	var/soundfile = "modular_septic/sound/voice/valario/valario[rand(1,11)].ogg"
	var/sound/valario = sound(soundfile, FALSE, 0, CHANNEL_ADMIN, 100)
	SEND_SOUND(world, valario)
	var/datum/job_department/kador/kador_department
	var/datum/job_department/ladax/ladax_department
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		if(istype(department, /datum/job_department/kador))
			kador_department = department
		else if(istype(department, /datum/job_department/ladax))
			ladax_department = department
		else
			SSjob.joinable_departments -= department
	kador_department = new /datum/job_department/kador()
	ladax_department = new /datum/job_department/ladax()
	SSjob.joinable_departments += kador_department
	SSjob.joinable_departments_by_type[kador_department.type] = kador_department
	SSjob.joinable_departments += ladax_department
	SSjob.joinable_departments_by_type[ladax_department.type] = ladax_department
	for(var/datum/job/job as anything in SSjob.all_occupations)
		if(istype(job, /datum/job/kador))
			SSjob.name_occupations[job.title] = job
			kador_department.add_job(job)
			kador_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 64
			job.spawn_positions = 64
			SSjob.joinable_occupations += job
			SSjob.set_overflow_role(job.title)
		else if(istype(job, /datum/job/ladax))
			SSjob.name_occupations[job.title] = job
			ladax_department.add_job(job)
			ladax_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 64
			job.spawn_positions = 64
			SSjob.joinable_occupations += job
		else
			SSjob.joinable_occupations -= job