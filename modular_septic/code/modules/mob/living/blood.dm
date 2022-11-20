/// Big blood drips
/mob/living/add_splatter_floor(turf/splatter_turf, small_drip = FALSE)
	if(get_blood_id() != /datum/reagent/blood)
		return

	if(!splatter_turf)
		splatter_turf = get_turf(src)

	var/list/temp_blood_DNA
	// Find existing splatter if possible
	var/obj/effect/decal/cleanable/blood/splatter/splatter = locate() in splatter_turf
	if(small_drip)
		// Only a certain number of drips (or one large splatter) can be on a given turf.
		var/obj/effect/decal/cleanable/blood/drip/drop = locate() in splatter_turf
		if(drop)
			drop.drips++
			if(drop.drips <= 5)
				drop.add_overlay(pick(drop.random_icon_states))
				drop.transfer_mob_blood_dna(src)
				splatter_turf.pollute_turf(/datum/pollutant/metallic_scent, 5)
				return
			else if(drop.drips <= 8)
				drop.transfer_mob_blood_dna(src)
				drop.update_appearance(UPDATE_ICON)
				splatter_turf.pollute_turf(/datum/pollutant/metallic_scent, 5)
				return
			else
				temp_blood_DNA = drop.return_blood_DNA() //we transfer the dna from the drip to the splatter
				qdel(drop)//the drip is replaced by a bigger splatter
		else
			drop = new(splatter_turf, get_static_viruses())
			drop.transfer_mob_blood_dna(src)
			splatter_turf.pollute_turf(/datum/pollutant/metallic_scent, 5)
			return

	// Create a new decal if there is none
	if(QDELETED(splatter))
		splatter = new /obj/effect/decal/cleanable/blood/splatter(splatter_turf, get_static_viruses())
		splatter_turf.pollute_turf(/datum/pollutant/metallic_scent, 30)
	// Since it takes 10 drips to create a splatter, divide by 10
	if(small_drip)
		splatter.bloodiness = min((splatter.bloodiness + BLOOD_AMOUNT_PER_DECAL/10), BLOOD_POOL_MAX)
		splatter.drytime = min(splatter.drytime + 10 SECONDS, 3 MINUTES)
	else
		splatter.bloodiness = min((splatter.bloodiness + BLOOD_AMOUNT_PER_DECAL), BLOOD_POOL_MAX)
		splatter.drytime = min(splatter.drytime + 100 SECONDS, 3 MINUTES)
	if(!temp_blood_DNA)
		temp_blood_DNA = get_blood_dna_list()
	if(temp_blood_DNA)
		splatter.add_blood_DNA(temp_blood_DNA)

/// Blood trails
/mob/living/getTrail()
	var/drag_bleed_amount = bleedDragAmount()
	if(drag_bleed_amount <= 3)
		return pick("ltrails_1", "ltrails_2")
	else if(drag_bleed_amount <= 6)
		return "trails_1"
	else
		return "trails_2"

/mob/living/bleedDragAmount()
	var/brute_ratio = round(((getBruteLoss()+getFireLoss())/(maxHealth/2))*4, 1)
	return brute_ratio

/mob/living/makeTrail(turf/target_turf, turf/start, direction)
	if(!has_gravity() || !isturf(start) || !blood_volume)
		return

	var/bleed_amount = bleedDragAmount()
	if(!bleed_amount)
		return

	var/start_exists = locate(/obj/effect/decal/cleanable/trail_holder) in start
	var/target_exists = locate(/obj/effect/decal/cleanable/trail_holder) in target_turf

	var/trail_type = getTrail()
	if(!trail_type)
		return

	var/bleed_ratio = round((getBruteLoss() + getFireLoss())/(maxHealth/2), 0.1)
	//Don't leave trail if blood volume is below a threshold
	if(blood_volume <= max(BLOOD_VOLUME_NORMAL * (1 - bleed_ratio), 0))
		return

	adjust_bloodvolume(-bleed_amount)

	var/obj/effect/decal/cleanable/trail_holder/starting_trail = locate(/obj/effect/decal/cleanable/trail_holder) in start
	if(!start_exists)
		starting_trail = new /obj/effect/decal/cleanable/trail_holder(start, get_static_viruses())
	var/obj/effect/decal/cleanable/trail_holder/target_trail = locate(/obj/effect/decal/cleanable/trail_holder) in target_turf
	if(!target_exists)
		target_trail = new /obj/effect/decal/cleanable/trail_holder(target_turf)

	if(!starting_trail.next_trail)
		starting_trail.next_trail = WEAKREF(target_trail)
	if(!target_trail.previous_trail)
		target_trail.previous_trail = WEAKREF(starting_trail)

	var/tainted = FALSE
	var/target_to_start_dir = get_dir(target_turf, start)
	var/newdir = target_to_start_dir

	//redundant trail caused by the first of three move calls in diagonal movement
	if(target_exists && (target_to_start_dir in GLOB.diagonals))
		return

	if(newdir == (NORTH|SOUTH))
		newdir = NORTH
	else if(newdir == (EAST|WEST))
		newdir = EAST

	//cardinal connection (start to target)
	if(!tainted && starting_trail.previous_trail)
		var/obj/effect/decal/cleanable/trail_holder/previous_trail = starting_trail.previous_trail.resolve()
		var/start_to_previous_dir = get_dir(start, get_turf(previous_trail))
		//cardinal connection (previous to start)
		if(start_to_previous_dir in GLOB.cardinals)
			var/start_to_target_dir = get_dir(start, target_turf)
			newdir = start_to_previous_dir|start_to_target_dir
			if(newdir == (NORTH|SOUTH))
				newdir = NORTH
			if(newdir == (EAST|WEST))
				newdir = EAST
			newdir = REVERSE_DIR(newdir)
		//diagonal connection (previous to start) - should not happen but in case it does...
		else
			newdir = REVERSE_DIR(newdir)
	var/holder_length = LAZYLEN(starting_trail.existing_dirs[trail_type])
	var/last_dir = starting_trail.last_dir
	if(newdir in GLOB.diagonals)
		LAZYREMOVE(starting_trail.existing_dirs[trail_type], last_dir)
		starting_trail.overlays.Remove(LAZYLEN(starting_trail.overlays))
		holder_length = LAZYLEN(starting_trail.existing_dirs[trail_type])
	//maximum amount of overlays per type is 16 (all dirs filled)
	if(!(newdir in starting_trail.existing_dirs[trail_type]) && (holder_length < 16))
		LAZYADD(starting_trail.existing_dirs[trail_type], newdir)
		starting_trail.last_dir = newdir
		if(newdir in GLOB.cardinals)
			var/turned_dir = turn(newdir, 180)
			if(!(turned_dir in starting_trail.existing_dirs[trail_type]) && prob(50))
				newdir = turned_dir
		starting_trail.add_overlay(image('modular_septic/icons/effects/blood.dmi', trail_type, dir = newdir))
	starting_trail.transfer_mob_blood_dna(src)
	var/old_beauty = starting_trail.beauty
	starting_trail.beauty = -50
	if(old_beauty != starting_trail.beauty)
		starting_trail.RemoveElement(/datum/element/beauty, old_beauty)
		starting_trail.AddElement(/datum/element/beauty, starting_trail.beauty)

/// Missing a heartbeat, used by carbons to identify hardcrit
/mob/living/proc/is_asystole()
	return

/// Brain is poopy (hardcrit)
/mob/living/proc/undergoing_nervous_system_failure()
	return FALSE

/// Blood gushing
/mob/living/proc/do_hitsplatter(direction = SOUTH, min_range = 1, max_range = 3, splatter_loc = FALSE, instant = FALSE)
	var/turf_loc = get_turf(src)
	if(!((mob_biotypes & MOB_ORGANIC|MOB_HUMANOID) && blood_volume && turf_loc))
		return
	if(splatter_loc)
		add_splatter_floor(turf_loc, FALSE)
	var/obj/effect/decal/cleanable/blood/hitsplatter/hitsplat = new(turf_loc, get_blood_dna_list(), TRUE)
	hitsplat.do_squirt(direction, range = rand(min_range, max_range), instant = instant)

/// Blood gushing (projectile)
/mob/living/proc/do_arterygush(direction = SOUTH, min_range = 2, max_range = 3, spread_min = -25, spread_max = 25, splatter_loc = FALSE)
	var/turf_loc = get_turf(src)
	if(!((mob_biotypes & MOB_ORGANIC|MOB_HUMANOID) && blood_volume && turf_loc))
		return
	if(splatter_loc)
		add_splatter_floor(turf_loc, FALSE)
	var/obj/projectile/blood/spray = new(turf_loc, get_blood_dna_list(), TRUE)
	spray.do_squirt(direction, range = rand(min_range, max_range), spread_min = spread_min, spread_max = spread_max)

/// Blood volume adjust proc
/mob/living/proc/adjust_bloodvolume(amount)
	blood_volume = max(blood_volume + amount, 0)
	return TRUE
