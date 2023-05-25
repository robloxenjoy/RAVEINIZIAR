#define MUTATIONS_LAYER 42 //Mutations that appear behind the body - headglows, cold resistance glow, etc
#define BODYPARTS_EXTENSION_BEHIND_LAYER 41 //Essentially, tits and the infamous dixel
#define BODY_BEHIND_LAYER 40 //Certain mutantrace features (tail when looking south) that must appear behind the body parts
#define BODYPARTS_LAYER 39 //Initially "AUGMENTS", this was repurposed to be a catch-all bodyparts flag
#define BODYPARTS_EXTENSION_LAYER 38 //Essentially, tits and the infamous dixel
#define BODY_ADJ_LAYER 37 //certain mutantrace features (snout, body markings) that must appear above the body parts
#define BODY_LAYER 36 //underwear, undershirts, socks, eyes, lips(makeup)
#define FRONT_MUTATIONS_LAYER 35 //mutations that should appear above body, body_adj and bodyparts layer (e.g. laser eyes)
#define DAMAGE_LAYER 34 //damage indicators (cuts and burns)
#define UNIFORM_LAYER 33
#define ID_LAYER 32
#define ID_CARD_LAYER 31
#define LOWER_MEDICINE_LAYER 30 //Medicine, like gauze and tourniquets
#define HANDS_PART_LAYER 29
#define HANDS_ADJ_LAYER 28
#define UPPER_DAMAGE_LAYER 27 //damage indicators for the hands
#define UPPER_MEDICINE_LAYER 26 //medicine, like gauze and tourniquets, for the hands
#define WRISTS_LAYER 25
#define GLOVES_LAYER 24
#define SHOES_LAYER 23
#define EARS_LAYER 22
#define PANTS_LAYER 21
#define SUIT_LAYER 20
#define OVERSUIT_LAYER 19
#define GLASSES_LAYER 18
#define BELT_LAYER 17 //Possibly make this an overlay of something required to wear a belt?
#define SUIT_STORE_LAYER 16
#define NECK_LAYER 15
#define BACK_LAYER 14
#define HAIR_LAYER 13 //TODO: make part of head layer?
#define GORE_LAYER 12
#define FACEMASK_LAYER 11
#define HEAD_LAYER 10
#define HANDCUFF_LAYER 9
#define LEGCUFF_LAYER 8
#define HANDS_LAYER 7
#define BODY_FRONT_LAYER 6 // Usually used for mutant bodyparts that need to be in front of everything else (e.g. cat ears)
#define ABOVE_BODY_FRONT_GLASSES_LAYER 5 // For the special glasses that actually require to be above the hair (e.g. lifted welding goggles)
#define ABOVE_BODY_FRONT_HEAD_LAYER 4 // For the rare cases where something on the head needs to be above everything else (e.g. flowers)
#define ARTERY_LAYER 3
#define SMELL_LAYER 2
#define HALO_LAYER 1 //blood cult ascended halo, because there's currently no better solution for adding/removing
#define FIRE_LAYER 1 //If you're on fire

#define TOTAL_LAYERS MUTATIONS_LAYER //KEEP THIS UP-TO-DATE OR SHIT WILL BREAK ;_;
