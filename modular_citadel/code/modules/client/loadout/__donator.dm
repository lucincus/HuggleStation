//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.")

/datum/gear/donator/bs_diaper_bag
	name = "bluespace diaper bag"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/backpack/diaper_bag/bluespace
	donator_group_id = PATREON_DONATOR
