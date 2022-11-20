///Validate the client's mob has a valid zone selected
/client/check_has_body_select()
	return mob?.hud_used?.zone_select && istype(mob.hud_used.zone_select, /atom/movable/screen/zone_sel)


//bodypart selection verbs - Cyberboss
//9: r_eye - l_eye
//8: head - face - r_eye - l_eye - mouth
//7: mouth - face
//4: r_arm - r_hand
//5: chest - neck
//6: l_arm - l_hand
//1: r_leg - r_foot
//2: groin
//3: l_leg - l_foot

///Hidden verb to target the head, bound to 8
/client/verb/body_toggle_head()
	set name = "body-toggle-head"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/next_in_line
	switch(mob.zone_selected)
		if(BODY_ZONE_HEAD)
			next_in_line = BODY_ZONE_PRECISE_FACE
		if(BODY_ZONE_PRECISE_FACE)
			next_in_line = BODY_ZONE_PRECISE_R_EYE
		if(BODY_ZONE_PRECISE_R_EYE)
			next_in_line = BODY_ZONE_PRECISE_L_EYE
		if(BODY_ZONE_PRECISE_L_EYE)
			next_in_line = BODY_ZONE_PRECISE_MOUTH
		else
			next_in_line = BODY_ZONE_HEAD

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(next_in_line, mob)

///Hidden verb to target the eyes, bound to 7
/client/verb/body_eyes()
	set name = "body-eyes"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_PRECISE_R_EYE ? BODY_ZONE_PRECISE_L_EYE : BODY_ZONE_PRECISE_R_EYE, mob)

///Hidden verb to target the mouth, bound to 9
/client/verb/body_mouth()
	set name = "body-mouth"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_PRECISE_FACE ? BODY_ZONE_PRECISE_MOUTH : BODY_ZONE_PRECISE_FACE, mob)

///Hidden verb to target the chest, bound to 5
/client/verb/body_chest()
	set name = "body-chest"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_CHEST ? BODY_ZONE_PRECISE_NECK : BODY_ZONE_CHEST, mob)

///Hidden verb to target the groin, bound to 2
/client/verb/body_groin()
	set name = "body-groin"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_PRECISE_VITALS ? BODY_ZONE_PRECISE_GROIN : BODY_ZONE_PRECISE_VITALS, mob)

///Hidden verb to target the right arm, bound to 4
/client/verb/body_r_arm()
	set name = "body-r-arm"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_R_ARM ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_R_ARM, mob)

///Hidden verb to target the left arm, bound to 6
/client/verb/body_l_arm()
	set name = "body-l-arm"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_L_ARM ? BODY_ZONE_PRECISE_L_HAND : BODY_ZONE_L_ARM, mob)

///Hidden verb to target the right leg, bound to 1
/client/verb/body_r_leg()
	set name = "body-r-leg"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_R_LEG ? BODY_ZONE_PRECISE_R_FOOT : BODY_ZONE_R_LEG, mob)

///Hidden verb to target the left leg, bound to 3
/client/verb/body_l_leg()
	set name = "body-l-leg"
	set hidden = TRUE

	if(!check_has_body_select())
		return

	var/atom/movable/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(mob.zone_selected == BODY_ZONE_L_LEG ? BODY_ZONE_PRECISE_L_FOOT : BODY_ZONE_L_LEG, mob)
