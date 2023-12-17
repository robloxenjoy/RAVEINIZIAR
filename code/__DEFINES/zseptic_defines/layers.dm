//Defines for atom layers and planes
//KEEP THESE IN A NICE ASCENDING ORDER, PLEASE

//NEVER HAVE ANYTHING BELOW THIS PLANE ADJUST IF YOU NEED MORE SPACE
#define LOWEST_EVER_PLANE -200

#define CLICKCATCHER_PLANE -99

#define PLANE_SPACE -95
#define SPACE_LAYER 1.8

#define PLANE_SPACE_PARALLAX -90

#define WEATHER_OVERLAY_PLANE -80 //MOJAVE MODULE OUTDOOR_EFFECTS
#define WEATHER_RENDER_TARGET "*WEATHER_OVERLAY_PLANE" //MOJAVE MODULE OUTDOOR_EFFECTS

#define WEATHER_EFFECT_PLANE -30 //MOJAVE MODULE OUTDOOR_EFFECTS

// RANDOM EFFECT PLANES (?)
#define GRAVITY_PULSE_PLANE -27
#define GRAVITY_PULSE_RENDER_TARGET "*GRAVPULSE_RENDER_TARGET"

// BLOCKER PLANES
#define FRILL_BLOCKER_PLANE -26
#define FRILL_BLOCKER_RENDER_TARGET "FRILL_BLOCKER_PLANE"
#define POLLUTION_BLOCKER_PLANE -25
#define POLLUTION_BLOCKER_RENDER_TARGET "POLLUTION_BLOCKER_PLANE"
#define FIELD_OF_VISION_BLOCKER_PLANE -24
#define FIELD_OF_VISION_BLOCKER_RENDER_TARGET "FIELD_OF_VISION_BLOCKER_PLANE"

//Openspace plane below all turfs
#define OPENSPACE_PLANE -23
#define OPENSPACE_PLANE_RENDER_TARGET "OPENSPACE_PLANE"
//Openspace layer over all
#define OPENSPACE_LAYER 600
//Black square just over openspace plane to guaranteed cover all in openspace turf
#define OPENSPACE_BACKDROP_PLANE -22
//Transparent floors that should display above openspace
#define TRANSPARENT_FLOOR_PLANE -21

#define FLOOR_PLANE -20
#define FLOOR_PLANE_RENDER_TARGET "FLOOR_PLANE"
#define FLOOR_PLANE_FOV_HIDDEN -19
#define GAME_PLANE -18
#define GAME_PLANE_BLOOM -17
#define GAME_PLANE_WINDOW -16
#define GAME_PLANE_ABOVE_WINDOW -15 //this hurts me profoundly, but it's necessary
#define GAME_PLANE_FOV_HIDDEN -14
#define GAME_PLANE_UPPER -13
#define GAME_PLANE_UPPER_BLOOM -12
#define GAME_PLANE_UPPER_FOV_HIDDEN -11
#define GAME_PLANE_OBJECT_PERMANENCE -10
#define ABOVE_GAME_PLANE -9
#define POLLUTION_PLANE -8
#define RIPPLE_PLANE -7
#define FRILL_PLANE_WINDOW -6
#define FRILL_PLANE_LOW -5
#define FRILL_PLANE -4
#define FRILL_RENDER_TARGET "FRILL_PLANE"
#define ABOVE_FRILL_PLANE -3
#define ABOVE_FRILL_PLANE_BLOOM -2

/// Yeah, FoV does require quite a few planes to work with 513 filters to a decent degree.
#define FIELD_OF_VISION_MASK_PLANE -1
#define FIELD_OF_VISION_MASK_RENDER_TARGET "FIELD_OF_VISION_MASK_PLANE"
#define FIELD_OF_VISION_MASK_LAYER 20

#define BLACKNESS_PLANE 0 //To keep from conflicts with SEE_BLACKNESS internals

//#define AREA_LAYER 1 //For easy recordkeeping; this is a byond define
//#define TURF_LAYER 2 //For easy recordkeeping; this is a byond define

#define TURF_LAYER_WATER 2
#define TURF_LAYER_MOB_WATER 1.95
#define TURF_LAYER_WATER_UNDER 1.94
#define TURF_LAYER_WATER_BASE 1.93

// FLOOR_PLANE layers
#define CULT_OVERLAY_LAYER 2.01
#define MID_TURF_LAYER 2.02
#define HIGH_TURF_LAYER 2.03
#define TURF_PLATING_DECAL_LAYER 2.031
#define TURF_DECAL_LAYER 2.035 //Makes turf decals appear in DM how they will look inworld.
#define ABOVE_OPEN_TURF_LAYER 2.04
#define CLOSED_TURF_LAYER 2.05
#define BULLET_HOLE_LAYER 2.06
#define LIQUID_LAYER 2.07
#define SHADOW_LAYER 2.075

// GAME_PLANE layers
#define ABOVE_NORMAL_TURF_LAYER 2.08
#define LATTICE_LAYER 2.2
#define DISPOSAL_PIPE_LAYER 2.3
#define GAS_PIPE_HIDDEN_LAYER 2.35 //layer = initial(layer) + piping_layer / 1000 in atmospherics/update_icon() to determine order of pipe overlap
#define WIRE_LAYER 2.4
#define WIRE_BRIDGE_LAYER 2.44
#define WIRE_TERMINAL_LAYER 2.45
#define GAS_SCRUBBER_LAYER 2.46
#define GAS_PIPE_VISIBLE_LAYER 2.47 //layer = initial(layer) + piping_layer / 1000 in atmospherics/update_icon() to determine order of pipe overlap
#define GAS_FILTER_LAYER 2.48
#define GAS_PUMP_LAYER 2.49
#define LOW_OBJ_LAYER 2.5
///catwalk overlay of /turf/open/floor/plating/catwalk_floor
#define CATWALK_LAYER 2.51
#define LOW_SIGIL_LAYER 2.52
#define SIGIL_LAYER 2.54
#define HIGH_PIPE_LAYER 2.55
///anything aboe this layer is not "on" a turf for the purposes of washing - I hate this life of ours
#define FLOOR_CLEAN_LAYER 2.55
#define PROJECTILE_HIT_THRESHHOLD_LAYER 2.6 //projectiles won't hit objects at or below this layer if possible
#define TABLE_LAYER 2.7
#define GATEWAY_UNDERLAY_LAYER 2.8
#define BELOW_OBJ_LAYER 2.9
#define LOW_ITEM_LAYER 2.95
//#define OBJ_LAYER 3 //For easy recordkeeping; this is a byond define
#define ABOVE_OBJ_LAYER 3
#define SIGN_LAYER 3.1
#define CORGI_ASS_PIN_LAYER 3.2
#define NOT_HIGH_OBJ_LAYER 3.3
#define HIGH_OBJ_LAYER 3.4
#define BELOW_MOB_LAYER 3.5

// GAME_PLANE_BLOOM layers
#define LIQUID_FIRE_LAYER 3.51
#define TURF_FIRE_LAYER 3.52

// GAME_PLANE_WINDOW layers
#define WINDOW_FULLTILE_LAYER 3.53
#define ABOVE_WINDOW_FULLTILE_LAYER 3.54

// GAME_PLANE_ABOVE_WINDOW layers
#define WINDOW_LOW_LAYER 3.55
#define GRILLE_LAYER 3.57
#define ABOVE_GRILLE_LAYER 3.59
#define WINDOW_GRILLE_LAYER 3.6
#define ABOVE_WINDOW_GRILLE_LAYER 3.61
#define BELOW_OPEN_DOOR_LAYER 3.62
#define OPEN_DOOR_LAYER 3.63
#define BLASTDOOR_LAYER 3.64
#define CLOSED_DOOR_LAYER 3.65
#define CLOSED_BLASTDOOR_LAYER 3.66
#define CLOSED_FIREDOOR_LAYER 3.67
#define SHUTTER_LAYER 3.68 // HERE BE DRAGONS
#define WINDOW_MIDDLE_LAYER 3.69
#define DOOR_HELPER_LAYER 3.7 //keep this above OPEN_DOOR_LAYER
#define ABOVE_DOOR_LAYER 3.71
#define GIRDER_LAYER 3.72

// GAME_PLANE_FOV_HIDDEN layers
#define LOW_MOB_LAYER 3.75
#define LYING_MOB_LAYER 3.8
#define VEHICLE_LAYER 3.9
#define MOB_BELOW_PIGGYBACK_LAYER 3.95
//#define MOB_LAYER 4 //For easy recordkeeping; this is a byond define
#define MOB_SHIELD_LAYER 4.05
#define MOB_ABOVE_PIGGYBACK_LAYER 4.1
#define MOB_UPPER_LAYER 4.12
#define HITSCAN_PROJECTILE_LAYER 4.13 //above all mob but still hidden by FoV

// GAME_PLANE_UPPER layers
#define ABOVE_MOB_LAYER 4.15
#define WINDOW_HIGH_LAYER 4.16
#define ABOVE_WINDOW_HIGH_LAYER 4.17
#define WALL_OBJ_LAYER 4.18
#define EDGED_TURF_LAYER 4.2
#define ON_EDGED_TURF_LAYER 4.3
#define SPACEVINE_LAYER  4.4

// GAME_PLANE_UPPER_BLOOM layers
#define LARGE_LIQUID_FIRE_LAYER 4.45
#define LARGEST_LIQUID_FIRE_LAYER 4.46
#define LARGE_TURF_FIRE_LAYER 4.47
#define LARGEST_TURF_FIRE_LAYER 4.48

// GAME_PLANE_UPPER_FOV_HIDDEN layers
#define BLOOD_PROJECTILE_LAYER 4.49
#define LARGE_MOB_LAYER 4.5
#define SPACEVINE_MOB_LAYER 4.6

// Intermediate layer used by both GAME_PLANE_UPPER_FOV_HIDDEN and ABOVE_GAME_PLANE
#define ABOVE_ALL_MOB_LAYER 4.7

// ABOVE_GAME_PLANE layers
//#define FLY_LAYER 5 //For easy recordkeeping; this is a byond define
#define GASFIRE_LAYER 5.1

// POLLUTION_PLANE layers
#define POLLUTION_LAYER 5.2

// RIPPLE_PLANE layers
#define RIPPLE_LAYER 5.3

// FRILL_PLANE_WINDOW layers
#define WINDOW_FRILL_LAYER 5.4

// FRILL_PLANE_LOW layers
#define LOW_FRILL_LAYER 5.5
#define GRILLE_FRILL_LAYER 5.6
#define WINDOW_CAP_LOW_LAYER 5.7
#define WINDOW_CAP_MID_LAYER 5.8
#define WINDOW_CAP_HIGH_LAYER 5.9
#define WINDOW_GRILLE_FRILL_LAYER 6

// FRILL_PLANE layers
#define FRILL_LAYER 6.1

// ABOVE_FRILL_PLANE layers
#define ABOVE_FRILL_LAYER 6.2

#define LANDMARK_PLANE 50
#define LOW_LANDMARK_LAYER 1
#define MID_LANDMARK_LAYER 2
#define HIGH_LANDMARK_LAYER 3

#define AREA_PLANE 60
#define MASSIVE_OBJ_PLANE 70
#define GHOST_PLANE 80
#define POINT_PLANE 85

#define RAD_TEXT_PLANE 90

//---------- LIGHTING -------------

//MOJAVE MODULE OUTDOOR_EFFECTS -- BEGIN
// This is not rendered, a fullscreen effect uses the render_target as a layer filter to display on the lighting plane
#define SUNLIGHTING_PLANE 99
#define SUNLIGHTING_RENDER_TARGET "*SUNLIGHT_PLANE"
//MOJAVE MODULE OUTDOOR_EFFECTS -- END

///Normal 1 per turf dynamic lighting objects
#define LIGHTING_PLANE 100

///Lighting objects that are "free floating"
#define O_LIGHTING_VISUAL_PLANE 110
#define O_LIGHTING_VISUAL_RENDER_TARGET "O_LIGHT_VISUAL_PLANE"

///Things that should render ignoring lighting
#define ABOVE_LIGHTING_PLANE 120

#define LIGHTING_PRIMARY_LAYER 14 //The layer for the main lights of the station
#define LIGHTING_PRIMARY_DIMMER_LAYER 15 //The layer that dims the main lights of the station
#define LIGHTING_SECONDARY_LAYER 16	//The colourful, usually small lights that go on top

///visibility + hiding of things outside of light source range
#define BYOND_LIGHTING_PLANE 130
//---------- LIGHTING -------------

//---------- EMISSIVES -------------
//Layering order of these is not particularly meaningful.
//Important part is the seperation of the planes for control via plane_master

///This plane masks out lighting to create an "emissive" effect, ie for glowing lights in otherwise dark areas
#define EMISSIVE_PLANE 150
#define EMISSIVE_RENDER_TARGET "*EMISSIVE_PLANE"

//---------- EMISSIVES -------------

//---------------- MISC -----------------------
///AI Camera Static
#define CAMERA_STATIC_PLANE 200

///Plane for balloon text (text that fades up)
#define BALLOON_CHAT_PLANE 251

///Debug Atmos Overlays
#define ATMOS_GROUP_PLANE 450
//---------------- MISC -----------------------

///--------------- FULLSCREEN IMAGES ------------
#define FULLSCREEN_PLANE 500
#define FLASH_LAYER 1
#define FULLSCREEN_LAYER 2
#define UI_DAMAGE_LAYER 3
#define BLIND_LAYER 4
#define CRIT_LAYER 5
#define CURSE_LAYER 6
#define PAIN_FLASH_LAYER 7
#define STATIC_FLASH_LAYER 8
#define BLIND_IMAGE_LAYER 9
#define INSIGNIA_LAYER 10
///--------------- FULLSCREEN IMAGES ------------

///Plane for sound hints
#define SOUND_HINT_PLANE 510
#define INSPECTION_IMAGE_LAYER 0
#define SOUND_HINT_LAYER 1

///Popup Chat Messages
#define RUNECHAT_PLANE 525

///Plane exclusively used by noise filter
#define NOISE_PLANE 550
#define NOISE_LAYER 1

//-------------------- HUD ---------------------
//HUD layer defines
#define HUD_PLANE 1000
#define ABOVE_HUD_PLANE 1100

#define RADIAL_BACKGROUND_LAYER 0
#define ADMIN_POPUP_LAYER 1
#define FILLER_LAYER 2
#define SCREEN_LAYER 3
#define GRAB_LAYER 4
#define ALERT_LAYER 5
#define ACTION_LAYER 6
///1000 is an unimportant number, it's just to normalize copied layers
#define RADIAL_CONTENT_LAYER 1000
//-------------------- HUD ---------------------

//-------------------- PEEPER ---------------------
#define PEEPER_PLANE 1200
#define ABOVE_PEEPER_PLANE 1300

//Peeper layer defines
#define PEEPER_BACKGROUND_LAYER 0
#define PEEPER_LOADOUT_RACK_LAYER 1
#define PEEPER_OBJECT_LAYER 2
#define PEEPER_ACTION_LAYER 3
#define PEEPER_ACTION_TOOLTIP_BACKGROUND_LAYER 4
#define PEEPER_ACTION_TOOLTIP_LAYER 5
#define PEEPER_ABOVE_ACTION_TOOLTIP_LAYER 6
#define PEEPER_TAB_LOADOUT_LAYER 7
#define PEEPER_LOADOUT_LAYER 8
#define PEEPER_CLOSER_LAYER 9
//-------------------- PEEPER ---------------------

///Plane of the "splash" icon used that shows on the lobby screen. Nothing should ever be above this.
#define SPLASHSCREEN_PLANE 9900

//-------------------- Rendering ---------------------
#define RENDER_PLANE_GAME 9990
#define RENDER_PLANE_GAME_RENDER_TARGET "RENDER_PLANE_GAME"
#define RENDER_PLANE_GAME_PROCESSING 9991
#define RENDER_PLANE_GAME_POST_PROCESSING 9992
#define RENDER_PLANE_NON_GAME 9995
#define RENDER_PLANE_NON_GAME_RENDER_TARGET "RENDER_PLANE_NON_GAME"
#define RENDER_PLANE_NON_GAME_PROCESSING 9996
#define RENDER_PLANE_NON_GAME_POST_PROCESSING 9997
#define RENDER_PLANE_PEEPER 9998
#define RENDER_PLANE_MASTER 9999
//----------------------------------------------------

#define LOBBY_BACKGROUND_LAYER 3
#define LOBBY_BUTTON_LAYER 4

///cinematics are "below" the splash screen
#define CINEMATIC_LAYER -1

///Plane master controller keys
#define PLANE_MASTERS_GAME "plane_masters_game"

///Alpha of window planes
#define WINDOW_PLANE_ALPHA 128
