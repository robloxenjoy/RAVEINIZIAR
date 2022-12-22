/proc/ui_equip_position(mob/M)
	return "WEST+11,SOUTH+1"

/proc/ui_swaphand_position(mob/M, which = 1)
	return "WEST+11,SOUTH+1"

/proc/ui_hand_position(i, pixel_x = 0) //values based on old hand ui positions (CENTER:-/+16,SOUTH:5)
	var/x_off = (i % 2)
	if(pixel_x)
		return"WEST+[11+x_off]:[pixel_x],SOUTH"
	else
		return"WEST+[11+x_off],SOUTH"

//Non-widescreen defines
#define ui_boxstorage1 "WEST,SOUTH+1"
#define ui_boxstorage2 "WEST+1,SOUTH+1"
#define ui_boxgloves "WEST+4,SOUTH"
#define ui_boxneck "WEST+5,SOUTH"
#define ui_boxglasses "WEST+6,SOUTH"
#define ui_boxbookmark_on "WEST+7,SOUTH"
#define ui_boxspecialattack "EAST-3,SOUTH"

//Middle left indicators
#define ui_lingchemdisplay "WEST,CENTER-1"
#define ui_lingstingdisplay "WEST:6,CENTER-3"

//Basically unused
#define ui_combo "CENTER+4,SOUTH"
#define ui_inventory "WEST,SOUTH"
#define ui_give "EAST-1,CENTER+5"
#define ui_safety "EAST-1,CENTER+0"
#define ui_healthdoll "EAST-1,SOUTH+2"
#define ui_sprintbuffer "EAST-1,SOUTH"

//Screentip
#define ui_screentip "CENTER-3,NORTH"

//Lower leftmost right
#define ui_specialattack "EAST-7,SOUTH"
#define ui_combat_style "EAST-6,SOUTH"
#define ui_combat_toggle "EAST-5,SOUTH"
#define ui_intents "EAST-4,SOUTH"
#define ui_acti_alt "EAST,SOUTH" //alternative intent switcher for when the interface is hidden (F12)
#define ui_wield "EAST-3,SOUTH"
#define ui_resist "EAST-3,SOUTH"
#define ui_sprint "EAST-2,SOUTH"
#define ui_movi "EAST-2,SOUTH"
#define ui_dodge_parry "EAST-1,SOUTH"

//Middle right (alerts)
#define ui_alert1 "EAST-1,SOUTH+2"
#define ui_alert2 "EAST-1,SOUTH+3"
#define ui_alert3 "EAST-1,SOUTH-4"
#define ui_alert4 "EAST-1,SOUTH-5"
#define ui_alert5 "EAST-1,SOUTH-6"

//Lower middle right
#define ui_filler "EAST-1,SOUTH+4"
#define ui_throw "EAST-3,SOUTH+1"
#define ui_drop "EAST-3,SOUTH+1"
#define ui_sleep "EAST-2,SOUTH+1"
#define ui_teach "EAST-2,SOUTH+1"
#define ui_pull "EAST-1,SOUTH+1"
#define ui_rest "EAST-1,SOUTH+1"

//Right (status indicators)
#define ui_stats "EAST,SOUTH+14"
#define ui_spacesuit "EAST,SOUTH+13"
#define ui_surrender "EAST,SOUTH+13"
#define ui_pressure "EAST,SOUTH+12"
#define ui_internal "EAST,SOUTH+12"
#define ui_fixeye "EAST,SOUTH+11"
#define ui_lookup "EAST,SOUTH+10"
#define ui_lookdown "EAST,SOUTH+10"
#define ui_fatigue "EAST,SOUTH+9"
#define ui_nutrition "EAST,SOUTH+8"
#define ui_hydration "EAST,SOUTH+8"
#define ui_mood "EAST,SOUTH+7"
#define ui_skills "EAST,SOUTH+6"
#define ui_crafting "EAST,SOUTH+6"
#define ui_language_menu "EAST,SOUTH+6"
#define ui_building "EAST,SOUTH+6"
#define ui_pain	"EAST,SOUTH+5"
#define ui_temperature "EAST,SOUTH+4"
#define ui_bodytemperature "EAST,SOUTH+4"
#define ui_pulse "EAST,SOUTH+3"
#define ui_breath "EAST,SOUTH+3"
#define ui_enhancesel "EAST,SOUTH+2"
#define ui_zonesel "EAST,SOUTH"

//Middle of the screen stuff
#define ui_fullscreen "WEST+4,SOUTH+1"
#define ui_fov "WEST+4,SOUTH+1"

//Expand inventory bookmark
#define ui_bookmark_off "WEST,SOUTH+1"
#define ui_bookmark_on "WEST+6,SOUTH+1"

//Pop-up inventory
#define ui_shoes "WEST,SOUTH"
#define ui_iclothing "WEST+1,SOUTH"
#define ui_oclothing "WEST+2,SOUTH"
#define ui_gloves "WEST+3,SOUTH"
#define ui_mask "WEST+4,SOUTH"
#define ui_head "WEST+5,SOUTH"
#define ui_id "WEST+6,SOUTH"
#define ui_belt "WEST+7,SOUTH"
#define ui_sstore1 "WEST+8,SOUTH"
#define ui_back "WEST+9,SOUTH"
#define ui_storage2 "WEST+10,SOUTH" //right pocket
#define ui_storage1 "WEST+13,SOUTH" //left pocket
#define ui_neck "WEST,SOUTH+1"
#define ui_glasses "WEST+1,SOUTH+1"
#define ui_ears "WEST+2,SOUTH+1"
#define ui_ears_extra "WEST+3,SOUTH+1"
#define ui_wrists "WEST+4,SOUTH+1"

//Generic living
#define ui_living_pull "EAST-1:28,CENTER-3:15"
#define ui_living_healthdoll "EAST-1:28,CENTER-1:15"

//Monkeys
#define ui_monkey_head "CENTER-5:13,SOUTH:5"
#define ui_monkey_mask "CENTER-4:14,SOUTH:5"
#define ui_monkey_neck "CENTER-3:15,SOUTH:5"
#define ui_monkey_back "CENTER-2:16,SOUTH:5"

//Drones
#define ui_drone_drop "CENTER+1:18,SOUTH:5"
#define ui_drone_pull "CENTER+2:2,SOUTH:5"
#define ui_drone_storage "CENTER-2:14,SOUTH:5"
#define ui_drone_head "CENTER-3:14,SOUTH:5"

//Cyborgs
#define ui_borg_health "EAST-1:28,CENTER-1:15"
#define ui_borg_pull "EAST-2:26,SOUTH+1:7"
#define ui_borg_radio "EAST-1:28,SOUTH+1:7"
#define ui_borg_intents "EAST-2:26,SOUTH:5"
#define ui_borg_lamp "CENTER-3:16, SOUTH:5"
#define ui_borg_tablet "CENTER-4:16, SOUTH:5"
#define ui_inv1 "CENTER-2:16,SOUTH:5"
#define ui_inv2 "CENTER-1  :16,SOUTH:5"
#define ui_inv3 "CENTER  :16,SOUTH:5"
#define ui_borg_module "CENTER+1:16,SOUTH:5"
#define ui_borg_store "CENTER+2:16,SOUTH:5"
#define ui_borg_camera "CENTER+3:21,SOUTH:5"
#define ui_borg_alerts "CENTER+4:21,SOUTH:5"
#define ui_borg_language_menu "CENTER+4:19,SOUTH+1:6"

//Aliens
#define ui_alien_health "EAST,CENTER-1"
#define ui_alienplasmadisplay "EAST,CENTER-2"
#define ui_alien_queen_finder "EAST,CENTER-3"
#define ui_alien_storage_r "CENTER+1,SOUTH"
#define ui_alien_language_menu "EAST-4,SOUTH"

//AI
#define ui_ai_core "SOUTH:6,WEST"
#define ui_ai_camera_list "SOUTH:6,WEST+1"
#define ui_ai_track_with_camera "SOUTH:6,WEST+2"
#define ui_ai_camera_light "SOUTH:6,WEST+3"
#define ui_ai_crew_monitor "SOUTH:6,WEST+4"
#define ui_ai_crew_manifest "SOUTH:6,WEST+5"
#define ui_ai_alerts "SOUTH:6,WEST+6"
#define ui_ai_announcement "SOUTH:6,WEST+7"
#define ui_ai_shuttle "SOUTH:6,WEST+8"
#define ui_ai_state_laws "SOUTH:6,WEST+9"
#define ui_ai_pda_send "SOUTH:6,WEST+10"
#define ui_ai_pda_log "SOUTH:6,WEST+11"
#define ui_ai_take_picture "SOUTH:6,WEST+12"
#define ui_ai_view_images "SOUTH:6,WEST+13"
#define ui_ai_sensor "SOUTH:6,WEST+14"
#define ui_ai_multicam "SOUTH+1:6,WEST+13"
#define ui_ai_add_multicam "SOUTH+1:6,WEST+14"
#define ui_ai_language_menu "SOUTH+1:8,WEST+11:30"

//pAI
#define ui_pai_software "SOUTH,WEST"
#define ui_pai_shell "SOUTH,WEST+1"
#define ui_pai_chassis "SOUTH,WEST+2"
#define ui_pai_rest "SOUTH,WEST+3"
#define ui_pai_light "SOUTH,WEST+4"
#define ui_pai_newscaster "SOUTH,WEST+5"
#define ui_pai_host_monitor "SOUTH,WEST+6"
#define ui_pai_crew_manifest "SOUTH,WEST+7"
#define ui_pai_state_laws "SOUTH,WEST+8"
#define ui_pai_pda_send "SOUTH,WEST+9"
#define ui_pai_pda_log "SOUTH,WEST+10"
#define ui_pai_internal_gps "SOUTH,WEST+11"
#define ui_pai_take_picture "SOUTH,WEST+12"
#define ui_pai_view_images "SOUTH,WEST+13"
#define ui_pai_radio "SOUTH,WEST+14"
#define ui_pai_language_menu "SOUTH+1,WEST+13"


//Ghosts
#define ui_ghost_spawners_menu "SOUTH,CENTER-2"
#define ui_ghost_orbit "SOUTH,CENTER-1"
#define ui_ghost_reenter_corpse "SOUTH,CENTER"
#define ui_ghost_teleport "SOUTH,CENTER+1"
#define ui_ghost_pai "SOUTH,CENTER+2"
#define ui_ghost_minigames "SOUTH,CENTER+3"
#define ui_ghost_language_menu "SOUTH,CENTER+4"

//Blobbernauts
#define ui_blobbernaut_overmind_health "EAST,CENTER"

//Families
#define ui_wanted_lvl "WEST,NORTH-1"

//Peeper
#define ui_peeper_background "statmap:0,0 to 5,3"
#define ui_peeper_loadout "statmap:0,0 to 0,3"
#define ui_peeper_loadout_up "statmap:0,3"
#define ui_peeper_loadout_down "statmap:0,0"
#define ui_peeper_close "statmap:5,3"

#define ui_peeper_emote_help "statmap:5,1:25"
#define ui_peeper_emote_loadout_up "statmap:5,1:16"
#define ui_peeper_emote_loadout_down "statmap:5,1:16"
#define ui_peeper_action_loadout_up "statmap:5,0:-3"
#define ui_peeper_action_loadout_down "statmap:5:10,0:24"
#define ui_peeper_action_tooltip_background "statmap:1,0 to 5,0"
#define ui_peeper_action_tooltip "statmap:1,0"
#define ui_peeper_alert_tooltip_background "statmap:1,2:-16 to 5,2:-16"
#define ui_peeper_alert_tooltip_name "statmap:1,2:-16"
#define ui_peeper_alert_tooltip_desc "statmap:1,0"
#define ui_peeper_alert_smiley "statmap:0,0"
