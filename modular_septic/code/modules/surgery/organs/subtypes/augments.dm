/obj/item/organ/cyberimp
	name = "cybernetic implant"
	desc = "A state-of-the-art implant that improves a baseline's functionality."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	needs_processing = FALSE
	emp_vulnerability = 50
	var/implant_overlay_color = "#FFFFFF"
	var/implant_overlay

/obj/item/organ/cyberimp/New(mob/new_owner)
	if(iscarbon(new_owner))
		src.Insert(new_owner)
	update_appearance()
	return ..()

/obj/item/organ/cyberimp/update_overlays()
	. = ..()
	if(implant_overlay)
		var/image/overlay = image(icon, src, implant_overlay)
		overlay.color = implant_overlay_color
		. += overlay

//BOX O' IMPLANTS
/obj/item/storage/box/cyber_implants
	name = "boxed cybernetic implants"
	desc = "A sleek, sturdy box."
	icon_state = "cyber_implants"
	var/list/boxed = list(
		/obj/item/autosurgeon/organ/syndicate/thermal_eyes,
		/obj/item/autosurgeon/organ/syndicate/xray_eyes,
		/obj/item/autosurgeon/organ/syndicate/anti_stun,
		/obj/item/autosurgeon/organ/syndicate/reviver)
	var/amount = 5

/obj/item/storage/box/cyber_implants/PopulateContents()
	var/implant
	while(contents.len <= amount)
		implant = pick(boxed)
		new implant(src)
