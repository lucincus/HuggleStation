/obj/structure/bed/crib
	name = "Crib"
	desc = "A bed with bars to keep babies safe while they sleep."
	icon = 'icons/incon/furniture.dmi'
	icon_state = "crib"
	buildstackamount = 3
	var/mutable_appearance/bars


//overlay code//
/obj/structure/bed/crib/Initialize()
	bars = GetBars()
	bars.layer = ABOVE_MOB_LAYER
	add_overlay(bars)
	return ..()

/obj/structure/bed/crib/proc/GetBars()
	return mutable_appearance('icons/incon/furniture.dmi', "crib_bars")

