/mob/living
	/// Almost every living mob should have an attribute holder
	attributes = /datum/attribute_holder
	/// Almost every living mob should have a frill blocker
	frill_blocker = /atom/movable/blocker/frill/living
	/// What icon the mob uses for SSD bubbles
	var/ssd_bubble_icon = "default"
	/// Chem effects
	var/list/chem_effects
	/// Intents, selected zones and throw mode are also saved on a hand by hand basis
	var/list/hand_index_to_intent
	var/list/hand_index_to_zone
	var/list/hand_index_to_throw
	/// Sprinting, fixeye, stamina, etc
	var/combat_flags = NONE
	/// Does it have FoV?
	var/has_field_of_vision = FALSE
	/// In case has_field_of_vision = TRUE, this is our fov type
	var/fov_type = FOV_90_DEGREES
	/// Lazy list of FOV traits that will apply a FOV view when handled.
	var/list/fov_traits
	/// How many eyes does this mob have by default. This shouldn't change at runtime.
	var/default_num_eyes = 2
	/// How many eyes does this mob currently have. Should only be changed through set_num_eyes()
	var/num_eyes = 2
	/// How many usable eyes this mob currently has. Should only be changed through set_usable_eyes()
	var/usable_eyes = 2
	/// Used for the cringe filter
	var/bad_ic_count = 0
