//proc for switching combat styles
/mob/living/proc/switch_combat_style(new_style, silent = FALSE)
	if(new_style == combat_style)
		return
	combat_style = new_style
	if(!silent)
		print_combat_style(combat_style)
	return TRUE

//proc for printing info about a combat style
/mob/living/proc/print_combat_style(print_style = combat_style)
	var/message = "<span class='infoplain'><div class='infobox'>"
	switch(print_style)
		if(CS_NONE)
			message += span_largeinfo("Ничего")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ не совершит специальную атаку.")
		if(CS_FEINT)
			message += span_largeinfo("Финт")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для совершения финта. \
								В случае успеха враг преждевременно парирует удар, оставляя его открытым для настоящей атаки.\n\
								Цена: Независимо от успеха, моя защита остается открытой.")
		if(CS_DUAL)
			message += span_largeinfo("Дуал")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для атаки второй рукой.\n\
								Цена: Никакая.")
		if(CS_GUARD)
			message += span_largeinfo("Стража")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ в боевом режиме для стражи ближайшей местности. \
								Переключение на другую специальную атаку сбросит стражу.\n\
								Цена: Никакая.")
		if(CS_DEFEND)
			message += span_largeinfo("Защита")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Возможности уклониться и парировать возвышены.\n\
								Цена: Ослабление урона.")
		if(CS_STRONG)
			message += span_largeinfo("Сплеча")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для нанесения большего урона чем обычно.\n\
								Цена: Повышение траты выносливости + защита остаётся открытой.")
		if(CS_FURY)
			message += span_largeinfo("Ярость")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для ускоренной атаки.\n\
								Цена: Повышение шанса проебаться.")
		if(CS_AIMED)
			message += span_largeinfo("Прицелом")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для прицельной атаки.\n\
								Цена: Атака медленнее + защита остаётся открытой.")
		if(CS_WEAK)
			message += span_largeinfo("Слабо")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("ПКМ для ослабленной атаки. \
								Уменьшение траты выносливости.\n\
								Цена: УМЕНЬШЕННЫЙ УРОН!")
	message += "</div></span>"
	to_chat(src, message)
