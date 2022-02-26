/obj/structure/chair/bouncer
	name = "bouncer"
	desc = "For big babies to bounce in!"
	icon = 'icons/incon/bouncy.dmi'
	icon_state = "boun"
	buildstacktype = /obj/item/stack/sheet/cloth
	buildstackamount = 3
	item_chair = null
	var/bouncey = 0
	var/basey = 0
	var/bounceoverlay = null
	var/bounceoverlaySOUTH = null
	var/bounceoverlayBAG = null
	var/bounceoverlayBAG2 = null
	var/list/MA = list()

/obj/structure/chair/bouncer/proc/bounceranimation(mob/living/M)
	spawn(6)
		if(has_buckled_mobs())
			bouncey = bouncey + 2
			if(bouncey >= 4)
				bouncey = 0
			var/currenty = basey + bouncey
			if(bouncey == 0)
				icon_state = "boun"
				if(iscarbon(M))
					var/mob/living/carbon/N = M
					if(N.stinkiness > 0)
						to_chat(M,"<span class='warning'>Squish!</span>")
			else
				icon_state = "boun2"
			M.pixel_y = currenty
			src.pixel_y = currenty
			bounceranimation(M)

/obj/structure/chair/bouncer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/tieddir)

/obj/structure/chair/bouncer/handle_layer()
	layer = OBJ_LAYER

/obj/structure/chair/bouncer/post_buckle_mob(mob/living/M)
	. = ..()
	basey = M.pixel_y
	bounceoverlay = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun")
	bounceoverlaySOUTH = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun", -BOUNCER_FRONT_LAYER)
	bounceoverlayBAG = null
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		bounceoverlayBAG2 = H.overlays_standing[BACK_LAYER]
		H.update_chair_overlay()
	else
		M.overlays += bounceoverlay
		M.update_overlays()
	bounceranimation(M)
	bouncerrotation(M)

/obj/structure/chair/bouncer/proc/bouncerrotation(mob/living/M)
	if(has_buckled_mobs())
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.update_chair_overlay()
		else
			M.overlays -= bounceoverlay
			M.update_overlays()
		if(bouncey == 0)
			bounceoverlay = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun")
			bounceoverlaySOUTH = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun", -BOUNCER_FRONT_LAYER)
		else
			bounceoverlay = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun2")
			bounceoverlaySOUTH = mutable_appearance('icons/incon/bounceroverlay.dmi',"boun2", -BOUNCER_FRONT_LAYER)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.update_chair_overlay()
		else
			M.overlays += bounceoverlay
			M.update_overlays()
		spawn(1)
		bouncerrotation(M)

/obj/structure/chair/bouncer/post_unbuckle_mob(mob/living/M)
	. = ..()
	src.pixel_y = 0
	M.pixel_y = 0
	basey = 0
	bouncey = 0
	M.overlays -= bounceoverlay
	M.update_overlays()
	bounceoverlay = null
	bounceoverlaySOUTH = null
	bounceoverlayBAG = bounceoverlayBAG2
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.update_chair_overlay()
	icon_state = "boun"

