#undef COLOR_INPUT_DISABLED
#undef COLOR_INPUT_ENABLED
#define COLOR_INPUT_DISABLED "#202020"
#define COLOR_INPUT_ENABLED "#505050"

#define COLOR_THEME_CODEC_GREEN "#5D9B79"
#define COLOR_THEME_CODEC_BLUE "#8AC4C3"

#define COLOR_THEME_QUAKE_GREEN "#97EDCA"
#define COLOR_THEME_QUAKE_BLUE "#4DBEFF"

#define COLOR_RED_ARTERY "#9b5455"
#define COLOR_RED_BLOODY "#cc0f0f"

#define COLOR_BROWN_SHIT "#815131"
#define COLOR_YELLOW_PISS "#d6d33396"
#define COLOR_WHITE_CUM "#fffae8e6"
#define COLOR_WHITE_FEMCUM "#fffcf058"
#define COLOR_BLUE_WATER "#d4f1f9"

#define CLOTHING_RED			"#a32121"
#define CLOTHING_PURPLE			"#8747b1"
#define CLOTHING_BLACK			"#414143"
#define CLOTHING_BROWN			"#685542"
#define CLOTHING_GREEN			"#428138"
#define CLOTHING_BLUE			"#537bc6"
#define CLOTHING_YELLOW			"#b5b004"
#define CLOTHING_TEAL			"#249589"
#define CLOTHING_WHITE			"#ffffff"
#define CLOTHING_ORANGE			"#bd6606"
#define CLOTHING_MAJENTA		"#962e5c"

#define CLOTHING_COLOR_NAMES	list("Red","Purple","Black","Brown","Green","Blue","Yellow","Teal","White","Orange","Majenta")

/proc/clothing_color2hex(input)
	switch(input)
		if("Red")
			return CLOTHING_RED
		if("Purple")
			return CLOTHING_PURPLE
		if("Black")
			return CLOTHING_BLACK
		if("Brown")
			return CLOTHING_BROWN
		if("Green")
			return CLOTHING_GREEN
		if("Blue")
			return CLOTHING_BLUE
		if("Yellow")
			return CLOTHING_YELLOW
		if("Teal")
			return CLOTHING_TEAL
		if("White")
			return CLOTHING_WHITE
		if("Orange")
			return CLOTHING_ORANGE
		if("Majenta")
			return CLOTHING_MAJENTA