//click cooldowns, in tenths of a second, used for various combat actions
#undef CLICK_CD_GRABBING
#define CLICK_CD_GRABBING 10
#define CLICK_CD_BITING 10
#define CLICK_CD_PULLING 10
#define CLICK_CD_WRENCH 10
#define CLICK_CD_TAKEDOWN 15
#define CLICK_CD_STRANGLE 20
#define CLICK_CD_BITE 10
#define CLICK_CD_JUMP 10
#define CLICK_CD_CLING 15
#define CLICK_CD_READY_WEAPON 10
#define CLICK_CD_INSPECT 10

/// Cooldown before regenerating fatigue again after suffering fatigue loss
#define FATIGUE_REGEN_COOLDOWN_DURATION 2 SECONDS
/// Cooldown before resetting the injury penalty
#define SHOCK_PENALTY_COOLDOWN_DURATION 5 SECONDS
/// Cooldown before our body endorphinates itself again
#define ENDORPHINATION_COOLDOWN_DURATION 2 MINUTES
/// Blocking cooldown (can only try to block once every BLOCKING_COOLDOWN_DURATION)
#define BLOCKING_COOLDOWN_DURATION 1 SECONDS
/// Blocking penalty cooldown (penalties can be applied with feinting)
#define BLOCKING_PENALTY_COOLDOWN_DURATION 2 SECONDS
/// Dodging cooldown (can only try to block once every DODGING_COOLDOWN_DURATION)
#define DODGING_COOLDOWN_DURATION 1 SECONDS
/// Dodging penalty cooldown (penalties can be applied with feinting)
#define DODGING_PENALTY_COOLDOWN_DURATION 2 SECONDS
/// Cooldown before resetting the parrying penalty
#define PARRYING_PENALTY_COOLDOWN_DURATION 2 SECONDS
/// Cooldown for hacking attacks
#define HACKING_ATTACK_COOLDOWN_DURATION 2 SECONDS
/// Cooldown for inserting money, deserting,
#define MONEY_COOLDOWN_DURATION 2 SECONDS


// ~timer cooldown defines
#define COOLDOWN_CARBON_ENDORPHINATION "carbon_endorphination"
#define COOLDOWN_AMMO_BOX_LOAD "ammo_box_load"
#define COOLDOWN_MONEY "money"
