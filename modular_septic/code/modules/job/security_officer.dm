/datum/job/security_officer
	title = "Ordinator"
	outfit = /datum/outfit/job/security/zoomtech

/datum/job/security_officer/setup_department(mob/living/carbon/human/spawning, client/player_client)
	return

/datum/outfit/job/security/zoomtech
	name = "Ordinator"

	head = /obj/item/clothing/head/helmet/ordinator
	mask = /obj/item/clothing/mask/gas/ordinator
	neck = /obj/item/clothing/neck/ordinator
	suit = /obj/item/clothing/suit/armor/vest/alt/discrete
	uniform = /obj/item/clothing/under/rank/security/ordinator
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(/obj/item/melee/truncheon=1)

	skillchips = null