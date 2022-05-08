/obj/structure/closet/secure_closet/medical1
	name = "medicine closet"
	desc = "Filled to the brim with medical junk."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/secure_closet/medical1/PopulateContents()
	..()
	new /obj/item/reagent_containers/glass/beaker(src)
	new /obj/item/reagent_containers/glass/beaker(src)
	new /obj/item/reagent_containers/dropper(src)
	new /obj/item/reagent_containers/dropper(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/reagent_containers/glass/bottle/toxin(src)
	new /obj/item/reagent_containers/glass/bottle/morphine(src)
	new /obj/item/reagent_containers/glass/bottle/morphine(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/glass/bottle/epinephrine(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/glass/bottle/charcoal(src)
	new /obj/item/storage/box/rxglasses(src)

/obj/structure/closet/secure_closet/medical2
	name = "anesthetic closet"
	desc = "Used to knock people out."
	req_access = list(ACCESS_SURGERY)

/obj/structure/closet/secure_closet/medical2/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/tank/internals/anesthetic(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/breath/medical(src)

/obj/structure/closet/secure_closet/medical3
	name = "medical doctor's locker"
	req_access = list(ACCESS_SURGERY)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/medical3/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/clothing/glasses/hud/health(src)
	return

/obj/structure/closet/secure_closet/psychology
	name = "psychology locker"
	req_access = list(ACCESS_PSYCHOLOGY)
	icon_state = "cabinet"

/obj/structure/closet/secure_closet/psychology/PopulateContents()
	..()
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/under/suit/black/skirt(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/radio/headset/headset_srvmed(src)
	new /obj/item/clipboard(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/ears/earmuffs(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/clothing/glasses/sunglasses/blindfold(src)

/obj/structure/closet/secure_closet/paramedic
    name = "paramedic's locker"
    req_access = list(ACCESS_MEDICAL)
    icon_state = "paramed_secure"

/obj/structure/closet/secure_closet/paramedic/PopulateContents()
    ..()
    new /obj/item/clothing/suit/toggle/labcoat/paramedic(src)
    new /obj/item/clothing/under/rank/medical/paramedic(src)
    new /obj/item/clothing/under/rank/medical/paramedic/skirt(src)
    new /obj/item/radio/headset/headset_med(src)
    new /obj/item/defibrillator/loaded(src)
    new /obj/item/clothing/gloves/color/latex/nitrile(src)
    new /obj/item/storage/belt/medical(src)
    new /obj/item/clothing/glasses/hud/health(src)
    new /obj/item/pinpointer/crew(src)
    new /obj/item/sensor_device(src)
    return

/obj/structure/closet/secure_closet/CMO
	name = "\proper chief medical officer's locker"
	req_access = list(ACCESS_CMO)
	icon_state = "cmo"

/obj/structure/closet/secure_closet/CMO/PopulateContents()
	..()
	new /obj/item/storage/bag/garment/chief_medical(src)
	new /obj/item/storage/backpack/duffelbag/med(src)
	new /obj/item/clothing/suit/bio_suit/cmo(src)
	new /obj/item/clothing/head/bio_hood/cmo(src)
	new /obj/item/cartridge/cmo(src)
	new /obj/item/radio/headset/heads/cmo(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/storage/hypospraykit/cmo(src)
	new /obj/item/autosurgeon/cmo(src)
	new /obj/item/door_remote/chief_medical_officer(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/storage/belt/medical/surgery_belt_adv/cmo(src)
	new /obj/item/wallframe/defib_mount(src)
	new /obj/item/circuitboard/machine/techfab/department/medical(src)
	new /obj/item/storage/photo_album/CMO(src)
	new	/obj/item/storage/lockbox/medal/medical(src)

/obj/structure/closet/secure_closet/animal
	name = "animal control"
	req_access = list(ACCESS_SURGERY)

/obj/structure/closet/secure_closet/animal/PopulateContents()
	..()
	new /obj/item/assembly/signaler(src)
	for(var/i in 1 to 3)
		new /obj/item/electropack(src)

/obj/structure/closet/secure_closet/chemical
	name = "chemical closet"
	desc = "Store dangerous chemicals in here."
	icon_door = "chemical"

/obj/structure/closet/secure_closet/chemical/PopulateContents()
	..()
	new /obj/item/storage/box/pillbottles(src)
	new /obj/item/storage/box/pillbottles(src)
	new /obj/item/storage/box/medsprays(src)
	new /obj/item/storage/box/medsprays(src)
