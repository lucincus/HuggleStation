/obj/structure/chair/highchairwood
	name = "Highchair"
	desc = "A wood highchair for feeding babies in. Now with 100% more carseat straps to keep the little one in place!"
	icon = 'icons/incon/furniture.dmi'
	icon_state = "wooden_highchair"
	layer = OBJ_LAYER
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 2
	var/mutable_appearance/tray

//overlay code//
/obj/structure/chair/highchairwood/Initialize()
	tray = GetTray()
	tray.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/chair/highchairwood/proc/GetTray()
	return mutable_appearance('icons/incon/furniture.dmi', "wooden_highchair_overlay")

/obj/structure/chair/highchairwood/post_buckle_mob(mob/living/M)
	. = ..()
	update_tray()

/obj/structure/chair/highchairwood/proc/update_tray()
	if(has_buckled_mobs())
		add_overlay(tray)
	else
		cut_overlay(tray)

/obj/structure/chair/highchairwood/post_unbuckle_mob()
	. = ..()
	update_tray()

//examine text//
/obj/structure/chair/examine(mob/user)
	. =..()
	. += "<span class='notice'>Hold ctrl+shift and press either W or S to adjust your sprite to be properly sitting in the highchair"
