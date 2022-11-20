/proc/healthscan(mob/user, mob/living/M, mode = SCANNER_VERBOSE, advanced = FALSE)
	if(user.incapacitated())
		return

	// the final list of strings to render
	var/render_list = list()

	// Damage specifics
	var/is_literate = user.is_literate()
	var/is_advanced = (advanced || M.has_reagent(/datum/reagent/inverse/technetium))
	var/oxy_loss = M.getOxyLoss()
	var/tox_loss = M.getToxLoss()
	var/fire_loss = M.getFireLoss()
	var/brute_loss = M.getBruteLoss()
	var/mob_status = (M.stat == DEAD ? "<span class='alert'><b>Braindead.</b></span>" : "<b>[round(M.health/M.maxHealth,0.01)*100]%</b>")

	if(HAS_TRAIT(M, TRAIT_FAKEDEATH) && !is_advanced)
		mob_status = "<span class='alert'><b>Braindead.</b></span>"
	if(!is_literate)
		mob_status = replacetext(mob_status, "Braindead", "HUUUUH?")

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.undergoing_cardiac_arrest() && H.stat < DEAD)
			if(is_literate)
				render_list += "<span class='alert'>Subject suffering cardiac arrest: Apply defibrillation or other electric shock immediately!</span>\n"
			else
				render_list += "<span class='alert'>BMMCBMK MBFUWOIPKF OJGNSFGOSNG NGJSDONGON: OADSFOAFIWASFG AIFJOIFIOASGOIASGOIJ GIDGIOASFIOJA!</span>\n"

	if(is_literate)
		render_list += "<span class='info'>Analyzing results for [M]:</span>\n"
		render_list += "<span class='info ml-1'>Brain activity: [mob_status]</span>\n"
	else
		render_list += "<span class='info'>AAAAA GNGDNJVJDSMAKSF FIK [M]:</span>\n"
		render_list += "<span class='info ml-1'>GESENGN FASNJGJNG: [mob_status]</span>\n"
	var/overall_damage = M.get_physical_damage()
	if(overall_damage  <= 10)
		overall_damage = "<span class='green'>[overall_damage]</span>"
	else if(overall_damage >= 50)
		overall_damage = "<span class='alert'>[overall_damage]</span>"
	if(is_literate)
		render_list += "<span class='info ml-1'>Accumulated damage: [overall_damage]</span>\n"
	else
		render_list += "<span class='info ml-1'>AAAAAHHHH UGHHHHHH: [overall_damage]</span>\n"

	// Brain not added to carbon/human check because it's funny to get to bully simple mobs
	if(!M.getorganslot(ORGAN_SLOT_BRAIN))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject is anencephalic and lacks higher brain function.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUUHBBNN AANIJGCNJNB JIAIGGHO PIJFIJASGJI HJHNJHNJ.</span>\n"

	// Husk detection
	if(is_advanced && HAS_TRAIT_FROM(M, TRAIT_HUSK, BURN))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been husked by severe burns.</span>\n"
		else
			render_list += "<span class='alert ml-1'>AAAHGGHNGNG HANVDNJBI IKDOGOAGOKOHH.</span>\n"
	else if (is_advanced && HAS_TRAIT_FROM(M, TRAIT_HUSK, CHANGELING_DRAIN))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been husked by dessication.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUGHGHG HANGJNNJG AOGOOGGIKGI GDEJVBNNJNJ.</span>\n"
	else if(HAS_TRAIT(M, TRAIT_HUSK))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been husked.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUGHGGHG NJBNJBNJHNBJO AGKGGJ.</span>\n"

	// Disfigurement detection
	if(is_advanced && HAS_TRAIT_FROM(M, TRAIT_DISFIGURED, BRUTE))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been disfigured by severe brute trauma.</span>\n"
		else
			render_list += "<span class='alert ml-1'>HHJDFUDHFHAUFAUH AAHHHH BHGHBGHBE HBGBGN BRHHG AAGNDJN.</span>\n"
	else if(is_advanced && HAS_TRAIT_FROM(M, TRAIT_DISFIGURED, BURN))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been disfigured by severe burns.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUSUUHGH GHGDHUUHDG HGUHGUGHAGBNCBN GNANHGNJWSA AGNJWGNJ.</span>\n"
	else if(is_advanced && HAS_TRAIT_FROM(M, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been disfigured by necrosis.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUUHHGHGUG GUASHfUF HUGUASUHGUASH GAISDIJDIJASFIiGANJNJNJ.</span>\n"
	else if(HAS_TRAIT(M, TRAIT_DISFIGURED))
		if(is_literate)
			render_list += "<span class='alert ml-1'>Subject has been disfigured.</span>\n"
		else
			render_list += "<span class='alert ml-1'>SUUGHGHDFDANS ASHAHASBHF BSAHASGANJ AHBHASHB.</span>\n"

	SEND_SIGNAL(M, COMSIG_LIVING_HEALTHSCAN, render_list, advanced, user, mode, is_literate)

	// Damage descriptions
	if(brute_loss >= 10)
		if(is_literate)
			render_list += "<span class='alert ml-1'>[brute_loss >= 50 ? "Severe" : "Minor"] physical trauma detected.</span>\n"
		else
			render_list += "<span class='alert ml-1'>[brute_loss >= 50 ? "AAWDBBB" : "DBSVFSDF"] DGNUIDIGUNANI GABHGIHSABH GABHBGH.</span>\n"
	if(fire_loss >= 10)
		if(is_literate)
			render_list += "<span class='alert ml-1'>[fire_loss >= 50 ? "Severe" : "Minor"] burn damage detected.</span>\n"
		else
			render_list += "<span class='alert ml-1'>[fire_loss >= 50 ? "AAWDBBB" : "DBSVFSDF"] ADUHGAUHGUAHSU GADISANIG IHGASI.</span>\n"
	if(oxy_loss >= 10)
		if(is_literate)
			render_list += "<span class='info ml-1'><span class='alert'>[oxy_loss >= 50 ? "Severe" : "Minor"] oxygen deprivation detected.</span>\n"
		else
			render_list += "<span class='info ml-1'><span class='alert'>[oxy_loss >= 50 ? "AAWDBBB" : "DBSVFSDF"] OOUBUDSUGUGHU AGNDHVFADH BHAWGHABHG.</span>\n"
	if(tox_loss >= 10)
		if(is_literate)
			render_list += "<span class='alert ml-1'>[tox_loss >= 50 ? "Severe" : "Minor"] amount of toxin damage detected.</span>\n"
		else
			render_list += "<span class='alert ml-1'>[tox_loss >= 50 ? "AAWDBBB" : "DBSVFSDF"] GINDIGNNGANJGN GAGHISGNII GANISGNISAING.</span>\n"
	if(M.getCloneLoss())
		if(is_advanced)
			if(is_literate)
				render_list += "<span class='info ml-1'>Cellular Damage Level: [M.getCloneLoss()].</span>\n"
			else
				render_list += "<span class='info ml-1'>CUUUUHSDGHU GUUHAGSHG NGNJDNGJ: [M.getCloneLoss()].</span>\n"
		else
			if(is_literate)
				render_list += "<span class='alert ml-1'>Subject appears to have [M.getCloneLoss() >= 30 ? "severe" : "minor"] cellular damage.</span>\n"
			else
				render_list += "<span class='alert ml-1'>GNDGNJNGAS SHGUAGHAUH AU HGAUGHUUAS [M.getCloneLoss() >= 30 ? "AAWDBBB" : "DBSVFSDF"] UUCCUHCUHCUH AGONAGSNJAG.</span>\n"
	if(M.getStaminaLoss())
		if(is_advanced)
			if(is_literate)
				render_list += "<span class='info ml-1'>Fatigue Level: [M.getStaminaLoss()/M.maxHealth * 100]%.</span>\n"
			else
				render_list += "<span class='info ml-1'>AHUGDHG GHHGHBGBH: [M.getStaminaLoss()/M.maxHealth * 100]%.</span>\n"
		else
			if(is_literate)
				render_list += "<span class='alert ml-1'>Subject appears to be suffering from fatigue.</span>\n"
			else
				render_list += "<span class='alert ml-1'>DBUHGVSHGHIA GHAGUAUSGUH GUUHGSAUHG UAHIGHSAGIUGASHI.</span>\n"

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(LAZYLEN(C.get_traumas()))
			var/list/trauma_text = list()
			for(var/thing in C.get_traumas())
				var/datum/brain_trauma/B = thing
				var/trauma_desc = ""
				if(is_literate)
					switch(B.resilience)
						if(TRAUMA_RESILIENCE_SURGERY)
							trauma_desc += "severe "
						if(TRAUMA_RESILIENCE_LOBOTOMY)
							trauma_desc += "deep-rooted "
						if(TRAUMA_RESILIENCE_WOUND)
							trauma_desc += "trauma-derived "
						if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
							trauma_desc += "permanent "
				else
					switch(B.resilience)
						if(TRAUMA_RESILIENCE_SURGERY)
							trauma_desc += "GHHGHH "
						if(TRAUMA_RESILIENCE_LOBOTOMY)
							trauma_desc += "PAGIOELJIGDGOJ "
						if(TRAUMA_RESILIENCE_WOUND)
							trauma_desc += "OJFAVSFOIJFWIAO "
						if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
							trauma_desc += "UAGOPWPOQPOWPOQ "
				if(is_literate)
					trauma_desc += B.scan_desc
					trauma_text += trauma_desc
				else
					trauma_desc += "SUGJGAGPP????!!!"
					trauma_text += "GOOOOOOOPPMHE"
			if(LAZYLEN(trauma_text))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Cerebral traumas detected: subject appears to be suffering from [english_list(trauma_text)].</span>\n"
				else
					render_list += "<span class='alert ml-1'>AUHVAUUU UHGIAUGIU ASIHUGAUSGIU: GNASGASBUYI GAHISGHISIUH IGASHGSAIUH GAGAG [english_list(trauma_text, "", "GNN")].</span>\n"
		if(length(C.quirks))
			if(is_literate)
				render_list += "<span class='info ml-1'>Subject Major Disabilities: [C.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY)].</span>\n"
			else
				render_list += "<span class='info ml-1'>AUGUAHGH GUASUHGUH NGAJNNJGS: HHHHDSGFVG.</span>\n"
			if(is_advanced)
				if(is_literate)
					render_list += "<span class='info ml-1'>Subject Minor Disabilities: [C.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY)].</span>\n"
				else
					render_list += "<span class='info ml-1'>GADNBGN ASNGI NIG NNG: HHHHDSGFVG.</span>\n"

	var/datum/component/irradiated/uranium_fever = M.GetComponent(/datum/component/irradiated)
	if(uranium_fever)
		if(advanced)
			var/sickness_stage = uranium_fever.radiation_sickness
			switch(sickness_stage)
				if(0 to RADIATION_SICKNESS_STAGE_1)
					sickness_stage = 0
				if(RADIATION_SICKNESS_STAGE_1 to RADIATION_SICKNESS_STAGE_2)
					sickness_stage = 1
				if(RADIATION_SICKNESS_STAGE_2 to RADIATION_SICKNESS_STAGE_3)
					sickness_stage = 2
				if(RADIATION_SICKNESS_STAGE_3 to RADIATION_SICKNESS_STAGE_4)
					sickness_stage = 3
				if(RADIATION_SICKNESS_STAGE_4 to RADIATION_SICKNESS_STAGE_5)
					sickness_stage = 4
				if(RADIATION_SICKNESS_STAGE_5 to RADIATION_SICKNESS_STAGE_6)
					sickness_stage = 5
				if(RADIATION_SICKNESS_STAGE_6 to RADIATION_SICKNESS_STAGE_7)
					sickness_stage = 6
				if(RADIATION_SICKNESS_STAGE_7 to RADIATION_SICKNESS_STAGE_8)
					sickness_stage = 7
				if(RADIATION_SICKNESS_STAGE_8 to RADIATION_SICKNESS_STAGE_9)
					sickness_stage = 8
				if(RADIATION_SICKNESS_STAGE_9 to INFINITY)
					sickness_stage = 9
			if(is_literate)
				render_list += "<span class='alert ml-1'>Subject is irradiated. Radiation sickness stage: [sickness_stage]</span>\n"
			else
				render_list += "<span class='alert ml-1'>WQGIOAGAWOI GIJOAGJIOS JSAJGNAJS. ANGNSNASJNG NAGSNGJNG SJNGNJAOWQ: [sickness_stage]</span>\n"
			if(uranium_fever.radiation_sickness >= RADIATION_SICKNESS_UNHEALABLE)
				if(is_literate)
					render_list += "<span class='alert ml-1'><b>Stem cell injections necessary.</b></span>\n"
				else
					render_list += "<span class='alert ml-1'><b>HDAHKIAPKPAP AGNSNAG ASGNAGNN.</b></span>\n"
		else
			if(is_literate)
				render_list += "<span class='alert ml-1'>Subject is irradiated.</span>\n"
			else
				render_list += "<span class='alert ml-1'>WQGIOAGAWOI GIJOAGJIOS JSAJGNAJS.</span>\n"

	if(is_advanced && M.hallucinating())
		if(is_literate)
			render_list += "<span class='info ml-1'>Subject is hallucinating.</span>\n"
		else
			render_list += "<span class='info ml-1'>SDGUHIAGIGI AHUIGHUISAG UGIASIUHGI.</span>\n"

	if(iscarbon(M) && mode == SCANNER_VERBOSE)
		var/mob/living/carbon/C = M
		var/list/damaged = (C.get_damaged_bodyparts(TRUE, TRUE) | C.get_infected_bodyparts())
		// Body part damage/infection report
		if(length(damaged) > 0 || oxy_loss > 0 || tox_loss > 0 || fire_loss > 0)
			var/dmgreport = "<span class='info ml-1'>Bodypart status</span>\
							<table class='ml-2'>\
							<tr><font face='Verdana'>\
							<td style='width:7em;'><font color='#ff0000'><b>Damage</b></font></td>\
							<td style='width:5em;'><font color='#ff3333'><b>Brute</b></font></td>\
							<td style='width:4em;'><font color='#ff9933'><b>Burn</b></font></td>\
							<td style='width:4em;'><font color='#00cc66'><b>Toxin</b></font></td>\
							<td style='width:8em;'><font color='#00cccc'><b>Suffocation</b></font></td>\
							<td style='width:8em;'><font color='#85007e'><b>Germ</b></font></td>\
							</tr>\
							<tr>\
							<td><font color='#ff3333'><b>Overall</b></font></td>\
							<td><font color='#ff3333'><b>[CEILING(brute_loss,1)]</b></font></td>\
							<td><font color='#ff9933'><b>[CEILING(fire_loss,1)]</b></font></td>\
							<td><font color='#00cc66'><b>[CEILING(tox_loss,1)]</b></font></td>\
							<td><font color='#33ccff'><b>[CEILING(oxy_loss,1)]</b></font></td>\
							<td></td>\
							</tr>"
			if(!is_literate)
				dmgreport = "<span class='info ml-1'>Bodypart status</span>\
							<table class='ml-2'>\
							<tr><font face='Verdana'>\
							<td style='width:7em;'><font color='#ff0000'><b>DDBGHG</b></font></td>\
							<td style='width:5em;'><font color='#ff3333'><b>ENANWA</b></font></td>\
							<td style='width:4em;'><font color='#ff9933'><b>GNAGSG</b></font></td>\
							<td style='width:4em;'><font color='#00cc66'><b>GADGJN</b></font></td>\
							<td style='width:8em;'><font color='#00cccc'><b>VOVPAO</b></font></td>\
							<td style='width:8em;'><font color='#85007e'><b>JUQIIQ</b></font></td>\
							</tr>\
							<tr>\
							<td><font color='#ff3333'><b>NHGGNJG</b></font></td>\
							<td><font color='#ff3333'><b>[CEILING(brute_loss,1)]</b></font></td>\
							<td><font color='#ff9933'><b>[CEILING(fire_loss,1)]</b></font></td>\
							<td><font color='#00cc66'><b>[CEILING(tox_loss,1)]</b></font></td>\
							<td><font color='#33ccff'><b>[CEILING(oxy_loss,1)]</b></font></td>\
							<td></td>\
							</tr>"
			for(var/o in damaged)
				var/obj/item/bodypart/org = o //head, left arm, right arm, etc.
				if(is_literate)
					dmgreport += "<tr><td><font color='#cc3333'>[capitalize_like_old_man(org.name)]</font></td>\
									<td><font color='#cc3333'>[CEILING(org.brute_dam,1)]</font></td>\
									<td><font color='#ff9933'>[CEILING(org.burn_dam,1)]</font></td>\
									<td></td>\
									<td></td>\
									<td><font color='#85007e'>[CEILING(org.germ_level/INFECTION_LEVEL_THREE*100,1)]%</font></td>\
									</tr>"
				else
					dmgreport += "<tr><td><font color='#cc3333'>[malbolge_string(org.name)]</font></td>\
									<td><font color='#cc3333'>[CEILING(org.brute_dam,1)]</font></td>\
									<td><font color='#ff9933'>[CEILING(org.burn_dam,1)]</font></td>\
									<td></td>\
									<td></td>\
									<td><font color='#85007e'>[CEILING(org.germ_level/INFECTION_LEVEL_THREE*100,1)]%</font></td>\
									</tr>"
			dmgreport += "</font></table>"
			render_list += dmgreport // tables do not need extra linebreak

		// Organ damage report
		if(LAZYLEN(C.internal_organs))
			var/render = FALSE
			var/toReport = "<span class='info ml-1'>Organ status</span>\
				<table class='ml-2'>\
				<tr>\
				<td style='width:6em;'><font color='#ff0000'><b>Organ</b></font></td>\
				[is_advanced ? "<td style='width:6em;'><font color='#ff0000'><b>Damage</b></font></td>" : ""]\
				<td style='width:12em;'><font color='#ff0000'><b>Status</b></font></td>\
				<td style='width:8em;'><font color='#85007e'><b>Germ</b></font></td>\
				</tr>"
			if(!is_literate)
				toReport = "<span class='info ml-1'>OOOO JANNNJA</span>\
					<table class='ml-2'>\
					<tr>\
					<td style='width:6em;'><font color='#ff0000'><b>OGNHHN</b></font></td>\
					[is_advanced ? "<td style='width:6em;'><font color='#ff0000'><b>JNGJNG</b></font></td>" : ""]\
					<td style='width:12em;'><font color='#ff0000'><b>GNJNJG</b></font></td>\
					<td style='width:8em;'><font color='#85007e'><b>AOGKO</b></font></td>\
					</tr>"

			for(var/thing in C.internal_organs)
				var/obj/item/organ/organ = thing
				var/status = ""
				if(organ.is_necrotic())
					if(is_literate)
						status = "<font color='#85007e'>Necrotic</font>"
					else
						status = "<font color='#85007e'>GNJGNJNJ</font>"
				else if(organ.is_dead())
					if(is_literate)
						status = "<font color='#a50000'>Destroyed</font>"
					else
						status = "<font color='#a50000'>DNGDANJGN</font>"
				else if(organ.is_failing())
					if(is_literate)
						status = "<font color='#cc3333'>Failing</font>"
					else
						status = "<font color='#cc3333'>GIJGAIJ</font>"
				else if(organ.damage >= organ.high_threshold)
					if(is_literate)
						status = "<font color='#ff9933'>Severely Damaged</font>"
					else
						status = "<font color='#ff9933'>AGJIGIJN GANGNNA</font>"
				else if(organ.damage >= organ.low_threshold)
					if(is_literate)
						status = "<font color='#ffcc33'>Mildly Damaged</font>"
					else
						status = "<font color='#ffcc33'>JGNJGN AKMKFMK</font>"
				else if(organ.damage && is_advanced)
					if(is_literate)
						status = "<font color='#b2e400'>Minorly Damaged</font>"
					else
						status = "<font color='#b2e400'>AGDGNGD JNJSFANJ</font>"
				if(status)
					render = TRUE
					if(is_literate)
						toReport += "<tr>\
							<td><font color='#cc3333'>[capitalize_like_old_man(organ.name)]:</font></td>\
							[is_advanced ? "<td><font color='#ff3333'>[CEILING(organ.damage,1)]</font></td>" : ""]\
							<td>[status]</td>\
							<td>[CEILING(organ.germ_level/INFECTION_LEVEL_THREE*100,1)]%</td>\
							</tr>"
					else
						toReport += "<tr>\
							<td><font color='#cc3333'>[malbolge_string(organ.name)]:</font></td>\
							[is_advanced ? "<td><font color='#ff3333'>[CEILING(organ.damage,1)]</font></td>" : ""]\
							<td>[status]</td>\
							<td>[CEILING(organ.germ_level/INFECTION_LEVEL_THREE*100,1)]%</td>\
							</tr>"

			if(render)
				render_list += toReport + "</table>" // tables do not need extra linebreak

	if(ishuman(M))
		var/mob/living/carbon/human/the_dude = M
		var/datum/species/the_dudes_species = the_dude.dna.species
		if(!(NOBLOOD in the_dudes_species.species_traits))
			if(!the_dude.getorganslot(ORGAN_SLOT_HEART))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Subject lacks a heart.</span>\n"
				else
					render_list += "<span class='alert ml-1'>SUHDAGUU NNJAN B NJGNJNJ.</span>\n"
			if(!the_dude.getorganslot(ORGAN_SLOT_SPLEEN))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Subject lacks a spleen.</span>\n"
				else
					render_list += "<span class='alert ml-1'>SUAGUHU UGHU L AGDGG.</span>\n"
		var/list/lungs = the_dude.getorganslotlist(ORGAN_SLOT_LUNGS)
		var/lacklungs = max(0, 2 - length(lungs))
		if(!(TRAIT_NOBREATH in the_dudes_species.inherent_traits))
			switch(lacklungs)
				if(1)
					if(is_literate)
						render_list += "<span class='alert ml-1'>Subject lacks one of [the_dude.p_their()] lungs.</span>\n"
					else
						render_list += "<span class='alert ml-1'>SUUGUHHU KANGNJN NJGNJ NGJN NJGNJ.</span>\n"
				if(2)
					if(is_literate)
						render_list += "<span class='alert ml-1'>Subject lacks both lungs.</span>\n"
					else
						render_list += "<span class='alert ml-1'>SAGMMM APPF NASN NSAJG.</span>\n"
		if(!(TRAIT_NOMETABOLISM in the_dudes_species.inherent_traits))
			if(!the_dude.getorganslot(ORGAN_SLOT_LIVER))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Subject lacks a liver.</span>\n"
				else
					render_list += "<span class='alert ml-1'>SGNJGNJ NGJNJ L GNGNE.</span>\n"
			var/list/kidneys = the_dude.getorganslotlist(ORGAN_SLOT_KIDNEYS)
			var/lackkidneys = max(0, 2 - length(kidneys))
			switch(lackkidneys)
				if(1)
					if(is_literate)
						render_list += "<span class='alert ml-1'>Subject lacks one of [the_dude.p_their()] kidneys.</span>\n"
					else
						render_list += "<span class='alert ml-1'>HGUHUHH HGHGS OEJ GP GNGNJ AGMPPZE.</span>\n"
				if(2)
					if(is_literate)
						render_list += "<span class='alert ml-1'>Subject lacks both kidneys.</span>\n"
					else
						render_list += "<span class='alert ml-1'>AGUGAI GIJGIJI JGJGAN GNNJGA.</span>\n"
		if(!(NOSTOMACH in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_STOMACH))
			if(is_literate)
				render_list += "<span class='alert ml-1'>Subject lacks a stomach.</span>\n"
			else
				render_list += "<span class='alert ml-1'>SAUGUUH HGHUG Z IGAJGN.</span>\n"

		// Ear status
		var/list/ears = the_dude.getorganslotlist(ORGAN_SLOT_EARS)
		var/lackears = max(0, 2 - length(ears))
		var/ear_message = "\n<span class='alert ml-1'>Subject lacks both ears.</span>\n"
		if(!is_literate)
			ear_message = "\n<span class='alert ml-1'>GANJGJN NJGNJ NNGN NENES.</span>\n"
		if(length(ears))
			ear_message = ""
			if(lackears)
				if(is_literate)
					ear_message += "\n<span class='alert ml-1'>Subject lacks one of [the_dude.p_their()] ears.</span>\n"
				else
					ear_message += "\n<span class='alert ml-1'>ADGJJG ASKXPZ AON QP MGPPL AGNJG.</span>\n"
			if(is_advanced && HAS_TRAIT_FROM(the_dude, TRAIT_DEAF, GENETIC_MUTATION))
				if(is_literate)
					ear_message += "\n<span class='alert ml-1'>Subject is genetically deaf.</span>\n"
				else
					ear_message += "\n<span class='alert ml-1'>SBOPPO JA PAOGGNE DKAP.</span>\n"
			else if(is_advanced && HAS_TRAIT_FROM(the_dude, TRAIT_DEAF, EAR_DAMAGE))
				if(is_literate)
					ear_message += "\n<span class='alert ml-1'>Subject is deaf from ear damage.</span>\n"
				else
					ear_message += "\n<span class='alert ml-1'>SDAJGM PA PQWP SZNN EAN DDPADG.</span>\n"
			else if(HAS_TRAIT(the_dude, TRAIT_DEAF))
				if(is_literate)
					ear_message += "\n<span class='alert ml-1'>Subject is deaf.</span>\n"
				else
					ear_message += "\n<span class='alert ml-1'>GDNJGN NN OAPZ.</span>\n"
			else
				var/ear_maxhealth = 0
				var/ear_damage = 0
				var/ear_deaf = 0
				for(var/thing in ears)
					var/obj/item/organ/ears/ear = thing
					ear_maxhealth += ear.maxHealth
					if(ear.is_dead())
						ear_damage += ear.maxHealth
						ear_deaf += 1
					else
						ear_damage += ear.damage
						ear_deaf += ear.deaf
				if(ear_damage)
					if(is_literate)
						ear_message += "\n<span class='alert ml-1'>Subject has [ear_damage >= ear_maxhealth ? "permanent": "mild"] ear damage.</span>\n"
					else
						ear_message += "\n<span class='alert ml-1'>GKOGOKG HNG [ear_damage >= ear_maxhealth ? "GGJGJGAG": "GAGDG"] GKM GDFSZ.</span>\n"
				if(ear_deaf >= length(ears))
					if(is_literate)
						ear_message += "\n<span class='alert ml-1'>Subject is [ear_damage >= ear_maxhealth ? "permanently": "temporarily"] deaf.</span>\n"
					else
						ear_message += "\n<span class='alert ml-1'>GKOGOKG HNG [ear_damage >= ear_maxhealth ? "AHDGNNZN": "GDMSGK"] DGII.</span>\n"
		if(ear_message && (ear_message != ""))
			render_list += ear_message

		// Eye status
		var/list/eyes = the_dude.getorganslotlist(ORGAN_SLOT_EYES)
		var/lackeyes = max(0, 2 - length(eyes))
		var/eye_message = "\n<span class='alert ml-2'>Subject lacks both eyes.</span>\n"
		if(!is_literate)
			eye_message = "\n<span class='alert ml-2'>SNJANJG NGJJN APOQ ZFME.</span>\n"
		if(length(eyes))
			eye_message = ""
			if(lackeyes)
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject lacks one of [the_dude.p_their()] eyes.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>ANBJADN LALAS OPZ NG JAOKI NEJD</span>\n"
			if(the_dude.is_blind())
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject is blind.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>GMAMKM IP APKGN.</span>\n"
			if(HAS_TRAIT(the_dude, TRAIT_NEARSIGHT))
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject is nearsighted.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>SAOOM JN ZPZAOEND.</span>\n"
			var/eye_damage = 0
			var/eye_maxhealth = 0
			for(var/thing in eyes)
				var/obj/item/organ/eyes/eye = thing
				eye_damage += eye.damage
				eye_maxhealth += eye.maxHealth
			if(eye_damage >= eye_maxhealth/2)
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject has severe eye damage.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>NHNHNJZ AHN SPPOON ZLX DDZNNE.</span>\n"
			else if(eye_damage >= eye_maxhealth/3)
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject has significant eye damage.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>AGMGNSN JAJ AOSKEJNNNT AZP EMFMMS.</span>\n"
			else if(eye_damage)
				if(is_literate)
					eye_message += "\n<span class='alert ml-2'>Subject has minor eye damage.</span>\n"
				else
					eye_message += "\n<span class='alert ml-2'>AGNJNJ PFK PZGMK ENJ ZPGOEFN.</span>\n"
		if(eye_message && (eye_message != ""))
			render_list += eye_message

		// GENITALS AHHHHHHH
		var/list/peepee_organs = list(ORGAN_SLOT_PENIS, ORGAN_SLOT_TESTICLES, ORGAN_SLOT_VAGINA, ORGAN_SLOT_WOMB, ORGAN_SLOT_BREASTS, ORGAN_SLOT_ANUS)
		for(var/peepee in peepee_organs)
			if(the_dude.should_have_genital(peepee) && !the_dude.getorganslot(peepee))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Subject lacks [prefix_a_or_an(peepee)] [peepee].</span>\n"
				else
					render_list += "<span class='alert ml-1'>GASGJOP NASGN T [malbolge_string(peepee)].</span>\n"

		// Genetic damage
		if(is_advanced && the_dude.has_dna())
			if(is_literate)
				render_list += "<span class='info ml-1'>Genetic Stability: [the_dude.dna.stability]%.</span>\n"
			else
				render_list += "<span class='info ml-1'>GAPMKGN JNANSNNMP: [the_dude.dna.stability]%.</span>\n"

		// Species and body temperature
		var/datum/species/the_species = the_dude.dna.species
		var/mutant = (the_dude.dna.check_mutation(HULK) \
			|| the_species.mutantlungs != initial(the_species.mutantlungs) \
			|| the_species.mutantbrain != initial(the_species.mutantbrain) \
			|| the_species.mutantheart != initial(the_species.mutantheart) \
			|| the_species.mutantheart != initial(the_species.mutantheart) \
			|| the_species.mutanteyes != initial(the_species.mutanteyes) \
			|| the_species.mutantears != initial(the_species.mutantears) \
			|| the_species.mutanthands != initial(the_species.mutanthands) \
			|| the_species.mutanttongue != initial(the_species.mutanttongue) \
			|| the_species.mutantliver != initial(the_species.mutantliver) \
			|| the_species.mutantkidneys != initial(the_species.mutantkidneys) \
			|| the_species.mutantstomach != initial(the_species.mutantstomach) \
			|| the_species.mutantappendix != initial(the_species.mutantappendix) \
			|| the_species.flying_species != initial(the_species.flying_species) \
			|| the_species.reagent_processing != initial(the_species.reagent_processing) \
			|| the_species.limbs_icon != initial(the_species.limbs_icon))
		if(is_literate)
			render_list += "<span class='info ml-1'>Species: [the_species.name][mutant ? "-derived mutant" : ""]</span>\n"
			render_list += "<span class='info ml-1'>Core temperature: [round(the_dude.coretemperature-T0C,0.1)] &deg;C ([round(the_dude.coretemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
		else
			render_list += "<span class='info ml-1'>GAGAGGX: [malbolge_string(the_species.name)][mutant ? "-[malbolge_string("derived mutant")]" : ""]</span>\n"
			render_list += "<span class='info ml-1'>ANGNGGN GNJANNGNE: [round(the_dude.coretemperature-T0C,0.1)] &deg;C ([round(the_dude.coretemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
	if(is_literate)
		render_list += "<span class='info ml-1'>Body temperature: [round(M.bodytemperature-T0C,0.1)] &deg;C ([round(M.bodytemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
	else
		render_list += "<span class='info ml-1'>ANHO PQOENJGEN: [round(M.bodytemperature-T0C,0.1)] &deg;C ([round(M.bodytemperature*1.8-459.67,0.1)] &deg;F)</span>\n"

	// Time of death
	if(M.tod && (M.stat == DEAD || (HAS_TRAIT(M, TRAIT_FAKEDEATH) && !is_advanced)))
		if(is_literate)
			render_list += "<span class='info ml-1'>Time of Death: [M.tod]</span>\n"
			var/tdelta = round(world.time - M.timeofdeath)
			render_list += "<span class='alert ml-1'><b>Subject died [DisplayTimeText(tdelta)] ago.</b></span>\n"
		else
			render_list += "<span class='info ml-1'>BBDN PZ GMMME: [M.tod]</span>\n"
			var/tdelta = round(world.time - M.timeofdeath)
			render_list += "<span class='alert ml-1'><b>ZPOMNE DNEP [DisplayTimeText(tdelta)] AZN.</b></span>\n"

	// Wounds
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/list/wounded_parts = C.get_wounded_bodyparts()
		for(var/i in wounded_parts)
			var/obj/item/bodypart/wounded_part = i
			if(is_literate)
				render_list += "<span class='alert ml-1'><b>Warning: Physical trauma[LAZYLEN(wounded_part.wounds) > 1? "s" : ""] detected in [wounded_part.name]</b>"
				for(var/k in wounded_part.wounds)
					var/datum/wound/W = k
					render_list += "<div class='ml-2'>Type: [W.name]\nSeverity: [W.severity_text()]\nRecommended Treatment: [W.treat_text]</div>\n" // less lines than in woundscan() so we don't overload people trying to get basic med info
				render_list += "</span>"
			else
				render_list += "<span class='alert ml-1'><b>DSMKMP: PAISJNEN UABFSN ADGGG PP [malbolge_string(wounded_part.name)]</b>"
				for(var/k in wounded_part.wounds)
					var/datum/wound/W = k
					render_list += "<div class='ml-2'>PZOK: [malbolge_string(W.name)]\nAOZGPLME: [W.severity_text()]\nASNJNGNJG MSAGKMZP: [malbolge_string(W.treat_text)]</div>\n" // less lines than in woundscan() so we don't overload people trying to get basic med info
				render_list += "</span>"

	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(!(D.visibility_flags & HIDDEN_SCANNER))
			if(is_literate)
				render_list += "<span class='alert ml-1'>\
				<b>Warning: [D.form] detected</b>\n\
				<div class='ml-2'>\
				Name: [D.name].\nType: [D.spread_text].\n\
				Stage: [D.stage]/[D.max_stages].\n\
				Possible Cure: [D.cure_text]\
				</div>\
				</span>" // divs do not need extra linebreak
			else
				render_list += "<span class='alert ml-1'>\
				<b>ANJZPO: [malbolge_string(D.form)] ADJIPPON</b>\n\
				<div class='ml-2'>\
				NAAN: [malbolge_string(D.name)].\nAPSGO: [malbolge_string(D.spread_text)].\n\
				APGKS: [D.stage]/[D.max_stages].\n\
				ASNGNJN FSAN: [malbolge_string(D.cure_text)]\
				</div>\
				</span>" // divs do not need extra linebreak

	// Blood and pulse
	if(M.has_dna())
		var/mob/living/carbon/C = M
		var/blood_id = C.get_blood_id()
		if(blood_id)
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				if(H.is_bleeding())
					if(is_literate)
						render_list += "<span class='alert ml-1'><b>Subject is bleeding!</b></span>\n"
					else
						render_list += "<span class='alert ml-1'><b>ANSANJN PO SHABHZLE!</b></span>\n"
			var/blood_type = C.dna.blood_type
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			if(is_literate)
				render_list += "<span class='info ml-1'>Blood type: [blood_type]</span>\n"
			else
				render_list += "<span class='info ml-1'>AALFM OPSO: [blood_type]</span>\n"
			var/pulse = C.get_pulse(is_advanced ? GETPULSE_ADVANCED : GETPULSE_BASIC)
			if(is_literate)
				render_list += "<span class='info ml-1'>Pulse: [pulse]</span>\n"
			else
				render_list += "<span class='info ml-1'>NNZOP: [pulse]</span>\n"
			var/normal_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_NORMAL, C.total_blood_req)
			if(is_literate)
				render_list += "<span class='info ml-1'>Ideal blood volume: [normal_volume]cl</span>\n"
			else
				render_list += "<span class='info ml-1'>PPOOO BLZNE PAONEM: [normal_volume]cl</span>\n"
			var/okay_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_OKAY, C.total_blood_req)
			var/safe_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_SAFE, C.total_blood_req)
			var/blood_volume = C.blood_volume
			var/blood_volume_percent = FLOOR((blood_volume/normal_volume)*100, 1)
			var/blood_circulation = C.get_blood_circulation()
			var/blood_circulation_percent =  FLOOR((blood_circulation/normal_volume)*100, 1)
			var/blood_oxygenation = C.get_blood_oxygenation()
			var/oxygenation_percent = FLOOR((blood_oxygenation/normal_volume)*100, 1)
			if((blood_volume <= safe_volume) && (blood_volume >= okay_volume))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood volume: LOW [blood_volume_percent]%, [blood_volume]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>ANGNJ ADGAPE: PZO [blood_volume_percent]%, [blood_volume]cl</span>\n"
			else if(blood_volume < okay_volume)
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood volume: <b>CRITICAL [blood_volume_percent]%</b>, [blood_volume]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>GNHcB GGAGPZ: <b>ADNJFNE [blood_volume_percent]%</b>, [blood_volume]cl</span>\n"
			else
				if(is_literate)
					render_list += "<span class='info ml-1'>Blood circulation: [blood_volume_percent]%, [blood_volume]cl</span>\n"
				else
					render_list += "<span class='info ml-1'>ZPOOJ PZODONNE: [blood_volume_percent]%, [blood_volume]cl</span>\n"
			if((blood_circulation <= safe_volume) && (blood_circulation >= okay_volume))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood circulation: LOW [blood_circulation_percent]%, [blood_circulation]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>ANGNJ PAGOSKKE: PZO [blood_circulation_percent]%, [blood_circulation]cl</span>\n"
			else if(blood_circulation < okay_volume)
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood circulation: <b>CRITICAL [blood_circulation_percent]%</b>, [blood_circulation]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>GNHcB AIGIJGJIIJ: <b>ADNJFNE [blood_circulation_percent]%</b>, [blood_circulation]cl</span>\n"
			else
				if(is_literate)
					render_list += "<span class='info ml-1'>Blood circulation: [blood_circulation_percent]%, [blood_circulation]cl</span>\n"
				else
					render_list += "<span class='info ml-1'>ZPOOJ PZODONNE: [blood_circulation_percent]%, [blood_circulation]cl</span>\n"
			if((blood_oxygenation <= safe_volume) && (blood_oxygenation >= okay_volume))
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood oxygenation: LOW [oxygenation_percent]%, [blood_oxygenation]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>ANGNJ PAOGNNJEEW: PZO [oxygenation_percent]%, [blood_oxygenation]cl</span>\n"
			else if(blood_oxygenation < okay_volume)
				if(is_literate)
					render_list += "<span class='alert ml-1'>Blood oxygenation: <b>CRITICAL [oxygenation_percent]%</b>, [blood_oxygenation]cl</span>\n"
				else
					render_list += "<span class='alert ml-1'>GNHCB ADHPEONELS: <b>ADNJFNE [oxygenation_percent]%</b>, [blood_oxygenation]cl</span>\n"
			else
				if(is_literate)
					render_list += "<span class='info ml-1'>Blood oxygenation: [oxygenation_percent]%, [blood_oxygenation]cl</span>\n"
				else
					render_list += "<span class='info ml-1'>ZPOOJ GAEGPENWENE: [oxygenation_percent]%, [blood_oxygenation]cl</span>\n"

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/cyberimp_detect
		for(var/obj/item/organ/cyberimp/CI in C.internal_organs)
			if(CI.status == ORGAN_ROBOTIC && !CI.scanner_hidden)
				if(is_literate)
					var/examine_string = CI.get_examine_string(user)
					cyberimp_detect += "[!cyberimp_detect ? "[examine_string]" : ", [examine_string]"]"
				else
					var/nonsense = malbolge_string(CI.get_examine_string(user))
					cyberimp_detect += "[!cyberimp_detect ? "[nonsense]" : ", [nonsense]"]"
		if(cyberimp_detect)
			if(is_literate)
				render_list += "<span class='notice ml-1'>Detected cybernetic modifications:</span>\n"
			else
				render_list += "<span class='notice ml-1'>DNGAJNNJ PAGNNNJGNN MAMKFKFKMPOS:</span>\n"
			render_list += "<span class='notice ml-2'>[cyberimp_detect]</span>\n"

	to_chat(user, div_infobox(jointext(render_list, "")), trailing_newline = FALSE) // we handled the last <br> so we don't need handholding

/proc/chemscan(mob/living/user, mob/living/M)
	if(user.incapacitated())
		return

	if(user.is_blind())
		to_chat(user, "<span class='warning'>You realize that your scanner has no accessibility support for the blind!</span>")
		return

	if(istype(M) && M.reagents)
		var/render_list = list()
		if(M.reagents.reagent_list.len)
			render_list += "<span class='notice ml-1'>Subject contains the following reagents in their blood:</span>\n"
			for(var/r in M.reagents.reagent_list)
				var/datum/reagent/reagent = r
				if(reagent.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
					continue
				render_list += "<span class='notice ml-2'>[round(reagent.volume, 0.001)] units of [reagent.name][reagent.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
		else
			render_list += "<span class='notice ml-1'>Subject contains no reagents in their blood.</span>\n"
		var/obj/item/organ/stomach/belly = M.getorganslot(ORGAN_SLOT_STOMACH)
		if(belly)
			if(belly.reagents.reagent_list.len)
				render_list += "<span class='notice ml-1'>Subject contains the following reagents in their stomach:</span>\n"
				for(var/bile in belly.reagents.reagent_list)
					var/datum/reagent/bit = bile
					if(bit.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
						continue
					if(!belly.food_reagents[bit.type])
						render_list += "<span class='notice ml-2'>[round(bit.volume, 0.001)] units of [bit.name][bit.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
					else
						var/bit_vol = bit.volume - belly.food_reagents[bit.type]
						if(bit_vol > 0)
							render_list += "<span class='notice ml-2'>[round(bit_vol, 0.001)] units of [bit.name][bit.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
			else
				render_list += "<span class='notice ml-1'>Subject contains no reagents in their stomach.</span>\n"

		if(LAZYLEN(M.mind?.active_addictions))
			render_list += "<span class='boldannounce ml-1'>Subject is addicted to the following types of drug:</span>\n"
			for(var/datum/addiction/addiction_type as anything in M.mind.active_addictions)
				render_list += "<span class='alert ml-2'>[initial(addiction_type.name)]</span>\n"
		else
			render_list += "<span class='notice ml-1'>Subject is not addicted to any types of drug.</span>\n"

		if(M.has_status_effect(/datum/status_effect/eigenstasium))
			render_list += "<span class='notice ml-1'>Subject is temporally unstable. Stabilising agent is recommended to reduce disturbances.</span>\n"

		to_chat(user, jointext(render_list, ""), trailing_newline = FALSE) // we handled the last <br> so we don't need handholding
