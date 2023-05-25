//flags for outfits that have mutant variants: Most of these require additional sprites to work.
#define STYLE_DIGITIGRADE (1<<0) //jumpsuits, suits and shoes
#define STYLE_MUZZLE (1<<1) //hats or masks
#define STYLE_TAUR_SNAKE (1<<2) //snake taur friendly suits
#define STYLE_TAUR_PAW (1<<3) //paw taur friendly suits
#define STYLE_TAUR_HOOF (1<<4) //hoof taur friendly suits
#define STYLE_TAUR_ALL (STYLE_TAUR_SNAKE|STYLE_TAUR_PAW|STYLE_TAUR_HOOF)

//ITEM INVENTORY SLOT BITMASKS
/// Suit slot (armors, costumes, space suits, etc.)
#define ITEM_SLOT_OCLOTHING (1<<0)
/// Jumpsuit slot
#define ITEM_SLOT_ICLOTHING (1<<1)
/// Pants slot
#define ITEM_SLOT_PANTS (1<<2)
/// Oversuit slot
#define ITEM_SLOT_OVERSUIT (1<<3)
/// Glove slot
#define ITEM_SLOT_GLOVES (1<<4)
/// Glasses slot
#define ITEM_SLOT_EYES (1<<5)
/// Left ear slot
#define ITEM_SLOT_LEAR (1<<6)
/// Right ear slot
#define ITEM_SLOT_REAR (1<<7)
/// Wrists slot
#define ITEM_SLOT_WRISTS (1<<8)
/// Mask slot
#define ITEM_SLOT_MASK (1<<9)
/// Head slot (helmets, hats, etc.)
#define ITEM_SLOT_HEAD (1<<10)
/// Shoe slot
#define ITEM_SLOT_FEET (1<<11)
/// ID slot
#define ITEM_SLOT_ID (1<<12)
/// Belt slot
#define ITEM_SLOT_BELT (1<<13)
/// Back slot
#define ITEM_SLOT_BACK (1<<14)
/// Dextrous simplemob "hands" (used for Drones and Dextrous Guardians)
#define ITEM_SLOT_DEX_STORAGE (1<<15)
/// Neck slot (ties, bedsheets, scarves)
#define ITEM_SLOT_NECK (1<<16)
/// A character's hand slots
#define ITEM_SLOT_HANDS (1<<17)
/// Inside of a character's backpack
#define ITEM_SLOT_BACKPACK (1<<18)
/// Suit Storage slot
#define ITEM_SLOT_SUITSTORE (1<<19)
/// Left Pocket slot
#define ITEM_SLOT_LPOCKET (1<<20)
/// Right Pocket slot
#define ITEM_SLOT_RPOCKET (1<<21)
/// Handcuff slot
#define ITEM_SLOT_HANDCUFFED (1<<22)
/// Legcuff slot (bolas, beartraps)
#define ITEM_SLOT_LEGCUFFED (1<<23)

/// Total amount of slots
#define SLOTS_AMT 23 // Keep this up to date!

//SLOT GROUP HELPERS
#define ITEM_SLOT_POCKETS (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET)
#define ITEM_SLOT_EARS (ITEM_SLOT_LEAR|ITEM_SLOT_REAR)

/// Item slots that if you equip an item on, it'll try to filthify you
#define DIRTY_ITEM_SLOTS (ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING||ITEM_SLOT_PANTS||ITEM_SLOT_OVERSUIT|ITEM_SLOT_WRISTS|ITEM_SLOT_GLOVES|ITEM_SLOT_EYES|ITEM_SLOT_LEAR|ITEM_SLOT_REAR|ITEM_SLOT_HEAD|ITEM_SLOT_FEET|ITEM_SLOT_BELT|ITEM_SLOT_BACK)
