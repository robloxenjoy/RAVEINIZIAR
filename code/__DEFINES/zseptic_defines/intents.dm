//intent defines
#define INTENT_HELP "help"
#define INTENT_GRAB "grab"
#define INTENT_DISARM "disarm"
#define INTENT_HARM "harm"
#define DEFAULT_INTENTS_LIST list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)

//NOTE: INTENT_HOTKEY_* defines are not actual intents!
//they are here to support hotkeys
#define INTENT_HOTKEY_LEFT  "left"
#define INTENT_HOTKEY_RIGHT "right"

//harm intent checks
#define IS_HARM_INTENT(mob, modifiers) (ishuman(mob) ? (mob.a_intent == INTENT_HARM) : (mob.combat_mode && !LAZYACCESS(modifiers, RIGHT_CLICK)))
#define IS_NOT_HARM_INTENT(mob, modifiers) (ishuman(mob) ? (mob.a_intent != INTENT_HARM) : (!mob.combat_mode || LAZYACCESS(modifiers, RIGHT_CLICK)))
#define IS_HELP_INTENT(mob, modifiers) (ishuman(mob) ? (mob.a_intent == INTENT_HELP) : (!mob.combat_mode && !LAZYACCESS(modifiers, RIGHT_CLICK)))
#define IS_DISARM_INTENT(mob, modifiers) (ishuman(mob) ? (mob.a_intent == INTENT_DISARM) : LAZYACCESS(modifiers, RIGHT_CLICK))
#define IS_GRAB_INTENT(mob, modifiers) (ishuman(mob) ? (mob.a_intent == INTENT_GRAB) : LAZYACCESS(modifiers, CTRL_CLICK))

//intent changes
#define SET_HARM_INTENT(mob) (ishuman(mob) ? (mob.a_intent_change(INTENT_HARM)) : (mob.set_combat_mode(TRUE)))
#define SET_HELP_INTENT(mob) (ishuman(mob) ? (mob.a_intent_change(INTENT_HELP)) : (mob.set_combat_mode(FALSE)))
