// ~pain levels when using the custom_pain proc and shit
#define PAIN_EMOTE_MINIMUM 10
#define PAIN_LEVEL_1 0
#define PAIN_LEVEL_2 10
#define PAIN_LEVEL_3 40
#define PAIN_LEVEL_4 70

// ~shock stages
#define SHOCK_STAGE_1 10
#define SHOCK_STAGE_2 30
#define SHOCK_STAGE_3 40
#define SHOCK_STAGE_4 60 // "Softcrit"
#define SHOCK_STAGE_5 80
#define SHOCK_STAGE_6 120 // "Hardcrit"
#define SHOCK_STAGE_7 150
#define SHOCK_STAGE_8 200
#define SHOCK_STAGE_MAX SHOCK_STAGE_8

// ~shock modifiers
#define SHOCK_MOD_BRUTE 0.7
#define SHOCK_MOD_BURN 0.8
#define SHOCK_MOD_TOXIN 1
#define SHOCK_MOD_CLONE 1.25

#define SHOCK_PENALTY_CAP 4

/// Above or equal this pain, affect DX and stuff intermittently
#define PAIN_SHOCK_PENALTY 25
/// Above or equal this pain, we cannot sleep intentionally
#define PAIN_NO_SLEEP 30
/// Above or equal this pain, we halve move and dodge
#define PAIN_HALVE_MOVE 45
/// Above or equal this pain, we give in
#define PAIN_GIVES_IN 100
/// Above or equal to this amount of pain, we can only speak in whispers
#define PAIN_NO_SPEAK 125

/// Divisor used in several pain calculations
#define PAINKILLER_DIVISOR 4

#define PAIN_KNOCKDOWN_MESSAGE "<span class='bolddanger'>gives in to the pain!</span>"
#define PAIN_KNOCKDOWN_MESSAGE_SELF "<span class='animatedpain'>I give in to the pain!</span>"
#define PAIN_KNOCKOUT_MESSAGE "<span class='bolddanger'>caves in to the pain!</span>"
#define PAIN_KNOCKOUT_MESSAGE_SELF "<span class='animatedpain'>OH HRUMKA! The PAIN!</span>"
