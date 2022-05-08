/datum/export/diaper
	k_elasticity = 0

/datum/export/diaper/clean
	cost = 10
	unit_name = "medical sanitary supplies"
	export_types = list(/obj/item/diaper)

/datum/export/diaper/used
	cost = 5
	unit_name = "used sanitary supplies"
	export_types = list(/obj/item/wetdiap, /obj/item/poopydiap, /obj/item/useddiap)
