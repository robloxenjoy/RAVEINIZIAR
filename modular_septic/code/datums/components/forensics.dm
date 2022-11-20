/datum/component/forensics
	//i hate this i hate this i HATE this FUCK
	var/list/shit_DNA //assoc dna = bloodtype
	var/list/cum_DNA //assoc dna = bloodtype
	var/list/femcum_DNA //assoc dna = bloodtype

//Use of | and |= being different here is INTENTIONAL
/datum/component/forensics/InheritComponent(datum/component/forensics/F, original)
	shit_DNA = LAZY_LISTS_OR(shit_DNA, F.shit_DNA)
	cum_DNA = LAZY_LISTS_OR(cum_DNA, F.cum_DNA)
	femcum_DNA = LAZY_LISTS_OR(femcum_DNA, F.femcum_DNA)
	check_shit()
	check_cum()
	check_femcum()
	return ..()

/datum/component/forensics/Initialize(new_fingerprints, \
									new_hiddenprints, \
									new_blood_DNA, \
									new_fibers, \
									new_shit_DNA, \
									new_cum_DNA, \
									new_femcum_DNA)
	if(!isatom(parent) || isarea(parent))
		return COMPONENT_INCOMPATIBLE
	fingerprints = new_fingerprints
	hiddenprints = new_hiddenprints
	blood_DNA = new_blood_DNA
	fibers = new_fibers
	shit_DNA = new_shit_DNA
	cum_DNA = new_cum_DNA
	femcum_DNA = new_femcum_DNA
	check_blood()
	check_shit()
	check_cum()
	check_femcum()

/datum/component/forensics/RegisterWithParent()
	check_blood()
	check_shit()
	check_cum()
	check_femcum()
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, .proc/clean_act)

/datum/component/forensics/add_blood_DNA(list/dna) //list(dna_enzymes = type)
	if(!length(dna))
		return
	. = length(blood_DNA)
	if(!.)
		var/atom/parent_atom = parent
		parent_atom.adjust_germ_level(INFECTION_LEVEL_ONE)
	LAZYINITLIST(blood_DNA)
	for(var/i in dna)
		blood_DNA[i] = dna[i]
	check_blood()
	return TRUE

/datum/component/forensics/wipe_blood_DNA()
	blood_DNA = null
	wipe_shit_DNA()
	wipe_cum_DNA()
	wipe_femcum_DNA()
	return TRUE

/datum/component/forensics/proc/add_shit_DNA(list/dna) //list(dna_enzymes = type)
	if(!length(dna))
		return
	. = length(blood_DNA)
	if(!.)
		var/atom/parent_atom = parent
		parent_atom.adjust_germ_level(INFECTION_LEVEL_ONE)
	LAZYINITLIST(shit_DNA)
	for(var/i in dna)
		shit_DNA[i] = dna[i]
	check_shit()
	return TRUE

/datum/component/forensics/proc/wipe_shit_DNA()
	shit_DNA = null
	return TRUE

/datum/component/forensics/proc/check_shit()
	if(!isitem(parent))
		return
	if(!length(shit_DNA))
		return
	parent.AddElement(/datum/element/decal/shit)

/datum/component/forensics/proc/add_cum_DNA(list/dna) //list(dna_enzymes = type)
	if(!length(dna))
		return
	. = length(blood_DNA)
	if(!.)
		var/atom/parent_atom = parent
		parent_atom.adjust_germ_level(INFECTION_LEVEL_ONE)
	LAZYINITLIST(cum_DNA)
	for(var/i in dna)
		cum_DNA[i] = dna[i]
	check_cum()
	return TRUE

/datum/component/forensics/proc/wipe_cum_DNA()
	cum_DNA = null
	return TRUE

/datum/component/forensics/proc/check_cum()
	if(!isitem(parent))
		return
	if(!length(cum_DNA))
		return
	parent.AddElement(/datum/element/decal/cum)

/datum/component/forensics/proc/add_femcum_DNA(list/dna) //list(dna_enzymes = type)
	if(!length(dna))
		return
	LAZYINITLIST(cum_DNA)
	for(var/i in dna)
		cum_DNA[i] = dna[i]
	check_femcum()
	return TRUE

/datum/component/forensics/proc/wipe_femcum_DNA()
	femcum_DNA = null
	return TRUE

/datum/component/forensics/proc/check_femcum()
	if(!isitem(parent))
		return
	if(!length(femcum_DNA))
		return
	parent.AddElement(/datum/element/decal/femcum)
