/proc/translate_knob_size(size)
	if(istext(size))
		size = text2num(size)
	return "[size]cm"

/proc/detranslate_knob_size(size)
	return text2num(size)

/proc/translate_gonad_size(size)
	switch(text2num(size))
		if(-INFINITY to 0)
			return "small"
		if(1)
			return "average sized"
		if(2)
			return "big"
		if(3)
			return "huge"
		if(4 to INFINITY)
			return "balls of steel sized"
		else
			return "average sized"

/proc/detranslate_gonad_size(size)
	size = lowertext(size)
	switch(size)
		if("small")
			return 0
		if("average sized")
			return 1
		if("big")
			return 2
		if("huge")
			return 3
		if("balls of steel sized")
			return 4
		else
			return 1

/proc/translate_jug_size(size)
	switch(text2num(size))
		if(-INFINITY to 0)
			return "a"
		if(1)
			return "b"
		if(2)
			return "c"
		if(3)
			return "d"
		if(4)
			return "e"
		if(5)
			return "f"
		if(6)
			return "g"
		if(7 to INFINITY)
			return "h"
		else
			return "a"

/proc/detranslate_jug_size(size)
	size = lowertext(size)
	switch(size)
		if("a")
			return 0
		if("b")
			return 1
		if("c")
			return 2
		if("d")
			return 3
		if("e")
			return 4
		if("f")
			return 5
		if("g")
			return 6
		if("h")
			return 7
		else
			return 0
