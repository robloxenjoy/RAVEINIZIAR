/datum/dynamic_ruleset/roundstart/efn
	name = "Escape from Nevado"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/efn/acceptable(population, threat_level)
	return TRUE

/datum/dynamic_ruleset/roundstart/efn/ready(population, forced)
	return TRUE

/datum/dynamic_ruleset/roundstart/efn/pre_execute()
	. = ..()
	message_admins("Starting a round of podpol!")
	log_game("DYNAMIC: Starting a round of podpol.")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: Podpol ruleset set threat to 0."
	var/soundfile = "modular_septic/sound/voice/valario/valario[rand(1,11)].ogg"
	var/sound/valario = sound(soundfile, FALSE, 0, CHANNEL_ADMIN, 100)
	SEND_SOUND(world, valario)
/*
	var/datum/job_department/gaksters/gakster_department
	var/datum/job_department/inborns/inborn_department
	var/datum/job_department/denominators/denominator_department
*/
	var/datum/job_department/outer/outer_department
	var/datum/job_department/inner/inner_department
	var/datum/job_department/sinisters/sinisters_department
	var/datum/job_department/fauna/fauna_department

	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		if(istype(department, /datum/job_department/outer))
			outer_department = department
		else if(istype(department, /datum/job_department/inner))
			inner_department = department
		else if(istype(department, /datum/job_department/sinisters))
			sinisters_department = department
		else if(istype(department, /datum/job_department/fauna))
			fauna_department = department
		else
			SSjob.joinable_departments -= department
/*
	gakster_department = new /datum/job_department/gaksters()
	inborn_department = new /datum/job_department/inborns()
	denominator_department = new /datum/job_department/denominators()
*/
	outer_department = new /datum/job_department/outer()
	inner_department = new /datum/job_department/inner()
	sinisters_department = new /datum/job_department/sinisters()
	fauna_department = new /datum/job_department/fauna()

	SSjob.joinable_departments += outer_department
	SSjob.joinable_departments_by_type[outer_department.type] = outer_department
	SSjob.joinable_departments += inner_department
	SSjob.joinable_departments_by_type[inner_department.type] = inner_department
	SSjob.joinable_departments += sinisters_department
	SSjob.joinable_departments_by_type[sinisters_department.type] = sinisters_department
	SSjob.joinable_departments += fauna_department
	SSjob.joinable_departments_by_type[fauna_department.type] = fauna_department
	for(var/datum/job/job as anything in SSjob.joinable_occupations)
/*
		if(istype(job, /datum/job/gakster))
			SSjob.name_occupations[job.title] = job
			gakster_department.add_job(job)
			gakster_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 64
			job.spawn_positions = 64
			SSjob.set_overflow_role(job.title)
*/
		if(istype(job, /datum/job/venturer))
			SSjob.name_occupations[job.title] = job
			outer_department.add_job(job)
			outer_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 64
			job.spawn_positions = 64
/*
		else if(istype(job, /datum/job/inner))
			SSjob.name_occupations[job.title] = job
			inner_department.add_job(job)
			inner_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 10
			job.spawn_positions = 10
		else if(istype(job, /datum/job/sinisters))
			SSjob.name_occupations[job.title] = job
			sinisters_department.add_job(job)
			sinisters_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 5
			job.spawn_positions = 5
		else if(istype(job, /datum/job/fauna))
			SSjob.name_occupations[job.title] = job
			fauna_department.add_job(job)
			fauna_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 10
			job.spawn_positions = 10
*/
/*
		else if(istype(job, /datum/job/denominator))
			SSjob.name_occupations[job.title] = job
			denominator_department.add_job(job)
			denominator_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 5
			job.spawn_positions = 5
		else if(istype(job, /datum/job/inborn))
			if(prob(0.01))
				job.title = "Creatura"
			SSjob.name_occupations[job.title] = job
			inborn_department.add_job(job)
			inborn_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 4
			job.spawn_positions = 4
*/
		else
			SSjob.joinable_occupations -= job
