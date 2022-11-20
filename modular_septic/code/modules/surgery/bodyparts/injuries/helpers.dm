//injury helpers
/obj/item/bodypart/proc/get_injury_type(type, damage)
	if(is_organic_limb())
		switch(type)
			if(WOUND_SLASH)
				switch(damage)
					if(70 to INFINITY)
						return /datum/injury/slash/massive
					if(60 to 70)
						return /datum/injury/slash/gaping_big
					if(50 to 60)
						return /datum/injury/slash/gaping
					if(25 to 50)
						return /datum/injury/slash/flesh
					if(15 to 25)
						return /datum/injury/slash/deep
					if(0 to 15)
						return /datum/injury/slash/small
			if(WOUND_PIERCE)
				switch(damage)
					if(60 to INFINITY)
						return /datum/injury/puncture/massive
					if(50 to 60)
						return /datum/injury/puncture/gaping_big
					if(30 to 50)
						return /datum/injury/puncture/gaping
					if(15 to 30)
						return /datum/injury/puncture/flesh
					if(0 to 15)
						return /datum/injury/puncture/small
			if(WOUND_BLUNT)
				switch(damage)
					if(80 to INFINITY)
						return /datum/injury/bruise/monumental
					if(50 to 80)
						return /datum/injury/bruise/huge
					if(25 to 50)
						return /datum/injury/bruise/large
					if(10 to 25)
						return /datum/injury/bruise/moderate
					if(0 to 10)
						return /datum/injury/bruise/small
			if(WOUND_BURN)
				switch(damage)
					if(50 to INFINITY)
						return /datum/injury/burn/carbonised
					if(40 to 50)
						return /datum/injury/burn/deep
					if(30 to 40)
						return /datum/injury/burn/severe
					if(15 to 30)
						return /datum/injury/burn/large
					if(0 to 15)
						return /datum/injury/burn/moderate
	else
		switch(type)
			if(WOUND_SLASH)
				switch(damage)
					if(70 to INFINITY)
						return /datum/injury/slash/massive/mechanical
					if(60 to 70)
						return /datum/injury/slash/gaping_big/mechanical
					if(50 to 60)
						return /datum/injury/slash/gaping/mechanical
					if(25 to 50)
						return /datum/injury/slash/flesh/mechanical
					if(15 to 25)
						return /datum/injury/slash/deep/mechanical
					if(0 to 15)
						return /datum/injury/slash/small/mechanical
			if(WOUND_PIERCE)
				switch(damage)
					if(60 to INFINITY)
						return /datum/injury/puncture/massive/mechanical
					if(50 to 60)
						return /datum/injury/puncture/gaping_big/mechanical
					if(30 to 50)
						return /datum/injury/puncture/gaping/mechanical
					if(15 to 30)
						return /datum/injury/puncture/flesh/mechanical
					if(0 to 15)
						return /datum/injury/puncture/small/mechanical
			if(WOUND_BLUNT)
				switch(damage)
					if(80 to INFINITY)
						return /datum/injury/bruise/monumental/mechanical
					if(50 to 80)
						return /datum/injury/bruise/huge/mechanical
					if(30 to 50)
						return /datum/injury/bruise/large/mechanical
					if(10 to 20)
						return /datum/injury/bruise/moderate/mechanical
					if(0 to 10)
						return /datum/injury/bruise/small/mechanical
			if(WOUND_BURN)
				switch(damage)
					if(50 to INFINITY)
						return /datum/injury/burn/carbonised/mechanical
					if(40 to 50)
						return /datum/injury/burn/deep/mechanical
					if(30 to 40)
						return /datum/injury/burn/severe/mechanical
					if(15 to 30)
						return /datum/injury/burn/large/mechanical
					if(0 to 15)
						return /datum/injury/burn/moderate/mechanical
	return //no injury
