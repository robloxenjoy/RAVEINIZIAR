///from base of obj/item/bodypart/apply_splint(): (obj/item/stack/splint)
#define COMSIG_BODYPART_SPLINTED "bodypart_splinted"
///from base of obj/item/bodypart/remove_splint(): (drop_splint)
#define COMSIG_BODYPART_SPLINT_DESTROYED "bodypart_unsplinted"

///from base of obj/item/embedded(): (atom/embedded_target, obj/item/bodypart/part)
#define COMSIG_ITEM_EMBEDDED "item_embedded"
///from base of obj/item/unembedded(): (atom/embedded_target, obj/item/bodypart/part)
#define COMSIG_ITEM_UNEMBEDDED "item_unembedded"

///from base of obj/item/hit_reaction()
	#define COMPONENT_HIT_REACTION_CANCEL (1<<1)

///from base of obj/projectile/process_hit(): (turf/T, atom/target, atom/bumped, hit_something = FALSE)
#define COMSIG_PROJECTILE_TRY_EMBED "projectile_try_embed"
///from base of mob/living/carbon/clear_wound_message():
#define COMSIG_CARBON_CLEAR_WOUND_MESSAGE "clear_wound_message"
///from base of mob/living/carbon/add_to_wound_message(): (new_message, clear_message)
#define COMSIG_CARBON_ADD_TO_WOUND_MESSAGE "add_to_wound_message"

///from base of mob/living/set_combat_mode(): (new_mode, silent)
#define COMSIG_LIVING_SET_COMBAT_MODE "set_combat_mode"

///from base of mob/living/Daze(): (amount, update, ignore)
#define COMSIG_LIVING_STATUS_DAZE "living_daze"
///from base of mob/living/Stumble(): (amount, update, ignore)
#define COMSIG_LIVING_STATUS_STUMBLE "living_stumble"
///from base of mob/living/HeadRape(): (amount, update, ignore)
#define COMSIG_LIVING_STATUS_HEADRAPE "living_headrape"

///from base of atom/attack_foot(): (mob/user, modifiers)
#define COMSIG_MOB_ATTACK_FOOT "mob_attack_foot"
///from base of atom/attack_jaw(): (mob/user, modifiers)
#define COMSIG_MOB_ATTACK_JAW "mob_attack_jaw"
///from base of /obj/item/attack(): (mob/M, mob/user)
#define COMSIG_MOB_ITEM_ATTACK_OBJ "mob_item_attack_obj"

// ~field of vision
///from base of client/change_view(): (client, old_view, view)
#define COMSIG_MOB_CLIENT_CHANGE_VIEW "mob_client_change_view"
///from base of mob/reset_perspective(): (atom/target)
#define COMSIG_MOB_RESET_PERSPECTIVE "mob_reset_perspective"
///from base of atom/ShiftClick(): (atom/A) - for return values, see COMSIG_CLICK_SHIFT
#define COMSIG_MOB_CLICKED_SHIFT "mob_shift_click_on"
///from base of mob/visible_atoms(): (list/visible_atoms)
#define COMSIG_MOB_FOV_VIEW "mob_visible_atoms"
	#define COMPONENT_NO_EXAMINATE (1<<0) //cancels examinate completely
	#define COMPONENT_EXAMINATE_BLIND (1<<1) //outputs the "something is there but you can't see it" message.
///from base of get_actual_viewers(): (atom/center, depth, viewers_list)
#define COMSIG_MOB_FOV_VIEWER "mob_is_viewer"
///from base of atom/visible_message(): (atom/A, msg, range, ignored_mobs)
#define COMSIG_MOB_VISIBLE_MESSAGE "mob_get_visible_message"
	#define COMPONENT_NO_VISIBLE_MESSAGE (1<<0) //cancels visible message completely
	#define COMPONENT_VISIBLE_MESSAGE_BLIND (1<<1) //outputs blind message instead
///from base of mob/alt_click_on_secodary(): (atom/A)
#define COMSIG_MOB_ALTCLICKON_TERTIARY "mob_altclickon_tertiary"

///from base of atom/topic_examine(): (mob/user)
#define COMSIG_ATOM_TOPIC_EXAMINE "atom_topic_examine"
///from base of atom/attack_foot(): (mob/user, modifiers)
#define COMSIG_ATOM_ATTACK_FOOT "atom_attack_foot"
///from base of atom/attack_jaw(): (mob/user, modifiers)
#define COMSIG_ATOM_ATTACK_JAW "atom_attack_jaw"
///from base of atom/setDir(): (old_dir, new_dir). Called before the direction changes.
	#define COMPONENT_NO_DIR_CHANGE 1
///from base of atom/setDir(): (old_dir, new_dir). Called after the direction changes.
#define COMSIG_ATOM_POST_DIR_CHANGE "atom_post_dir_change"
///from base of atom/set_smoothed_icon_state(): (new_junction)
#define COMSIG_ATOM_SET_SMOOTHED_ICON_STATE "set_smoothed_icon_state"

///from base of [atom/proc/attackby_tertiary()]: (/obj/item/weapon, /mob/user, params)
#define COMSIG_PARENT_ATTACKBY_TERTIARY "atom_attackby_tertiary"
///from base of [/atom/proc/attack_hand_tertiary]: (mob/user, list/modifiers) - Called when the atom receives a tertiary unarmed attack.
#define COMSIG_ATOM_ATTACK_HAND_TERTIARY "atom_attack_hand_tertiary"
///for any rightclick tool behaviors: (mob/living/user, obj/item/I)
#define COMSIG_ATOM_TERTIARY_TOOL_ACT(tooltype) "tool_tertiary_act_[tooltype]"
	// We have the same returns here as COMSIG_ATOM_TOOL_ACT
	// #define COMPONENT_BLOCK_TOOL_ATTACK (1<<0)
///from base of atom/alt_click_tertiary(): (/mob)
#define COMSIG_CLICK_ALT_TERTIARY "alt_click_tertiary"
	#define COMPONENT_CANCEL_CLICK_ALT_TERTIARY (1<<0)

///from base of obj/item/attack_self_tertiary(): (/mob)
#define COMSIG_ITEM_ATTACK_SELF_TERTIARY "item_attack_self_tertiary"
///from base of [/obj/item/proc/pre_attack_tertiary()]: (atom/target, mob/user, params)
#define COMSIG_ITEM_PRE_ATTACK_TERTIARY "item_pre_attack_tertiary"
	#define COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN (1<<0)
	#define COMPONENT_TERTIARY_CONTINUE_ATTACK_CHAIN (1<<1)
	#define COMPONENT_TERTIARY_CALL_NORMAL_ATTACK_CHAIN (1<<2)
///from base of [/obj/item/proc/attack_tertiary()]: (atom/target, mob/user, params)
#define COMSIG_ITEM_ATTACK_TERTIARY "item_pre_attack_tertiary"
///from base of obj/item/afterattack_tertiary(): (atom/target, mob/user, proximity_flag, click_parameters)
#define COMSIG_ITEM_AFTERATTACK_TERTIARY "item_afterattack_tertiary"
///from base of obj/item/afterattack_tertiary(): (atom/target, mob/user, proximity_flag, click_parameters)
#define COMSIG_MOB_ITEM_AFTERATTACK_TERTIARY "mob_item_afterattack_tertiary"
///from base of mob/ranged_tertiary_attack(): (atom/target, modifiers)
#define COMSIG_MOB_ATTACK_RANGED_TERTIARY "mob_attack_ranged_tertiary"

///from base of turf/handle_fall(): (mob/faller)
#define COMSIG_TURF_MOB_FALL "turf_mob_fall"
///from base of atom/movable/liquid_turf/Initialize(): (atom/movable/liquid_turf/liquids)
#define COMSIG_TURF_LIQUIDS_CREATION "turf_liquids_creation"
	#define COMPONENT_NO_LIQUID_CREATION (1<<0) //cancels the creation of the liquid movable

// ~footstep changer component
///from base of datum/component/footstep_changer/proc/is_footstep_changed(): (turf/open/source, datum/component/footstep_changer)
#define COMSIG_FOOTSTEP_CHANGER_IS_FOOTSTEP_CHANGED "footstep_changer_is_footstep_changed"
///from base of datum/component/footstep_changer/proc/clear_footstep(): (turf/open/source)
#define COMSIG_FOOTSTEP_CHANGER_CLEAR_FOOTSTEP "footstep_changer_clear_footstep"

// ~rope component
///from base of datum/component/rope/proc/is_roped(): (datum/source, datum/component/roped_by)
#define COMSIG_ROPE_CHECK_ROPED "rope_check_roped"

// ~twohanded component
///from base of datum/component/two_handed/proc/wield_check()
#define COMSIG_TWOHANDED_WIELD_CHECK "twohanded_wield_check"

// ~gunpoint component
///from base of datum/component/two_handed/proc/Initialize(): (mob/living/target, obj/item/gun/weapon)
#define COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED "gun_aim_stress_sounded"
///from base of datum/component/gunpoint/proc/cancel()
#define COMSIG_GUNPOINT_GUN_AIM_STRESS_UNSOUNDED "gun_aim_stress_unsounded"

// ~fov component
///from base of datum/component/field_of_vision/proc/hide_fov()
#define COMSIG_FOV_HIDE "fov_hide"
///from base of datum/component/field_of_vision/proc/show_fovv()
#define COMSIG_FOV_SHOW "fov_show"

// ~fix eye component
///from base of datum/component/fixeye/user_toggle_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_FIXEYE_TOGGLE "fixeye_toggle"
///from base of datum/component/fixeye/check_flags(): (mob/living/source, flags)
#define COMSIG_FIXEYE_CHECK	"fixeye_check"
///from base of datum/component/fixeye/safe_enable_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_FIXEYE_ENABLE "fixeye_enable"
///from base of datum/component/fixeye/safe_disable_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_FIXEYE_DISABLE "fixeye_disable"
///from base of datum/component/fixeye/lock_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_FIXEYE_LOCK "fixeye_lock"
///from base of datum/component/fixeye/unlock_fixeye(): (mob/living/source)
#define COMSIG_FIXEYE_UNLOCK "fixeye_unlock"
///from base of datum/component/fixeye/enable_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_LIVING_FIXEYE_ENABLED "fixeye_enabled"
///from base of datum/component/fixeye/disable_fixeye(): (mob/living/source, silent, forced)
#define COMSIG_LIVING_FIXEYE_DISABLED "fixeye_disabled"

// ~interactable component
///from base of datum/component/interactable/try_interact(): (atom/source, mob/living/user)
#define COMSIG_INTERACTABLE_TRY_INTERACT "interactable_try_interact"
///from base of datum/component/interactable/on_cooldown()
#define COMSIG_INTERACTABLE_COOLDOWN "interactable_cooldown"
///from base of datum/component/interactable/on_sex_cooldown()
#define COMSIG_INTERACTABLE_SEX_COOLDOWN "interactable_sex_cooldown"

// ~pellet cloud component
///from base of datum/component/pellet_cloud/proc/projectile_embedded(): (obj/projectile/source)
#define COMSIG_PELLET_CLOUD_EMBEDDED "pellet_cloud_embedded"
///from base of datum/component/pellet_cloud/proc/projectile_stopped_by_armor(): (obj/projectile/source)
#define COMSIG_PELLET_CLOUD_STOPPED_BY_ARMOR "pellet_cloud_stopped_by_armor"
///from base of datum/component/pellet_cloud/proc/projectile_went_through(): (obj/projectile/source)
#define COMSIG_PELLET_CLOUD_WENT_THROUGH "pellet_cloud_went_through"

// ~storage component
///from base of datum/component/storage/can_user_take(): (mob/user)
#define COMSIG_STORAGE_BLOCK_USER_TAKE "storage_block_user_take"

// ~clingable element
///from base of datum/element/clingable/clingable_check(): (mob/user)
#define COMSIG_CLINGABLE_CHECK "clingable_check"
///from base of datum/element/clingable/play_clinging_sound(): (atom/source)
#define COMSIG_CLINGABLE_CLING_SOUNDING "clingable_cling_sounding"

// ~radioactive element
///from base of datum/element/radioactive/process(): (delta_time)
#define COMSIG_RADIOACTIVE_PULSE_SENT "radioactive_pulse_sent"

// ~conditional destructive element
///from base of datum/element/conditional_destructive/do_break()
#define COMSIG_CONDITIONAL_DESTRUCTIVE_BREAK "conditional_destructive_break"

// ~embed element
///from base of datum/element/embed/checkEmbed()
	#define COMPONENT_EMBED_FAILURE (1<<0)
	#define COMPONENT_EMBED_WENT_THROUGH (1<<2)
	#define COMPONENT_EMBED_STOPPED_BY_ARMOR (1<<3)

/// Mob is trying to open the hacking menu of a target [/atom], from /datum/hacking/interactable(): (mob/user)
#define COMSIG_TRY_HACKING_INTERACT "try_hacking_interact"
	#define COMPONENT_CANT_INTERACT_HACKING (1<<0)
