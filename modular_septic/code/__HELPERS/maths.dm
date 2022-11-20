/proc/round_to_nearest(number = 1, precision = 1)
	var/numtext = num2text(number)
	var/last_number = text2num(copytext(numtext, 1+precision, 2+precision))
	if(last_number >= 5)
		return CEILING(number, precision)
	else
		return FLOOR(number, precision)
