//this should not handle the time of the day please
/proc/random_time_in_year()
	return rand(0, 365) * 24 HOURS

//worst proc name of all time right here
/proc/st_nd_rd_th(number = 0)
	var/numbertext = "[number]"
	var/last_two = copytext(numbertext, length(numbertext)-1)
	var/static/list/every_rule_has_an_exception = list("11", "12", "13")
	if(last_two in every_rule_has_an_exception)
		return "th"
	var/last_one = copytext(numbertext, length(numbertext))
	switch(last_one)
		if("1")
			return "st"
		if("2")
			return "nd"
		if("3")
			return "rd"
		else
			return "th"

/proc/days_in_month(month = JANUARY)
	switch(month)
		if(JANUARY)
			return 31
		if(FEBRUARY)
			return 28
		if(MARCH)
			return 31
		if(APRIL)
			return 30
		if(MAY)
			return 31
		if(JUNE)
			return 30
		if(JULY)
			return 31
		if(AUGUST)
			return 31
		if(SEPTEMBER)
			return 30
		if(OCTOBER)
			return 31
		if(NOVEMBER)
			return 30
		if(DECEMBER)
			return 31

/proc/month_numeric(month = "January")
	switch(lowertext(month))
		if("january")
			return JANUARY
		if("february")
			return FEBRUARY
		if("march")
			return MARCH
		if("april")
			return APRIL
		if("may")
			return MAY
		if("june")
			return JUNE
		if("july")
			return JULY
		if("august")
			return AUGUST
		if("september")
			return SEPTEMBER
		if("october")
			return OCTOBER
		if("november")
			return NOVEMBER
		if("december")
			return DECEMBER

/proc/month_text(month = JANUARY)
	switch(month)
		if(JANUARY)
			return "january"
		if(FEBRUARY)
			return "february"
		if(MARCH)
			return "march"
		if(APRIL)
			return "april"
		if(MAY)
			return "may"
		if(JUNE)
			return "june"
		if(JULY)
			return "july"
		if(AUGUST)
			return "august"
		if(SEPTEMBER)
			return "september"
		if(OCTOBER)
			return "october"
		if(NOVEMBER)
			return "november"
		if(DECEMBER)
			return "december"
