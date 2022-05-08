/datum/component/tieddir/Initialize(...)
	. = ..()
	RegisterSignal(parent, COMSIG_BUCKLED_MOB_DIRECTION, .proc/matchdir)

/datum/component/tieddir/proc/matchdir(obj/structure/chair/source, mob/living/babbu)
	if(babbu.buckled == source)
		source.setDir(babbu.dir)

/datum/component/diaperswitch/Initialize(...)
	. = ..()
	RegisterSignal(parent, COMSIG_DIAPERCHANGE, .proc/changeundies)

/datum/component/diaperswitch/proc/changeundies(source, ckey)
	if(ishuman(parent))
		var/mob/living/carbon/human/butt = parent
		var/piss = copytext_char(ckey,1,2)
		var/underwear
		var/undie_color
		var/default_slot = 1
		if(fexists("data/player_saves/[piss]/[ckey]/preferences.sav"))
			var/savefile/S = new/savefile("data/player_saves/[piss]/[ckey]/preferences.sav")
			S.cd = "/"
			S["default_slot"] >> default_slot
			S.cd = "/character[default_slot]"
			S["underwear"] >> underwear
			S["undie_color"] >> undie_color
			sanitize_inlist(underwear, GLOB.underwear_list)
			sanitize_hexcolor(undie_color)
		else
			underwear = butt.baseunderwear
			undie_color = butt.undie_color
		if((HAS_TRAIT(butt,TRAIT_INCONTINENT) || HAS_TRAIT(butt,TRAIT_FULLYINCONTINENT) || HAS_TRAIT(butt,TRAIT_POTTYREBEL) || HAS_TRAIT(butt,BABYBRAINED_TRAIT) || HAS_TRAIT(butt,TRAIT_DIAPERUSE)))
			butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper()
			switch(butt.brand)
				if("plain")
					butt.undie_color = undie_color
				if("classic")
					butt.undie_color = "66FF66"
				if("thirteen")
					butt.undie_color = undie_color
				if("swaddles")
					butt.undie_color = "3399CC"
				if("cloth")
					butt.undie_color = "FFFFFF"
				if("hefters_m")
					butt.undie_color = "EEEEFF"
				if("hefters_f")
					butt.undie_color = "FFDDEE"
				if("princess")
					butt.undie_color = "FF99FF"
				if("pwrgame")
					butt.undie_color = "8833FF"
				if("starkist")
					butt.undie_color = "FF9933"
				if("space")
					butt.undie_color = "3366CC"
				if("syndi")
					butt.undie_color = "CC0000"
				if("service")
					butt.undie_color = "999999"
				if("supply")
					butt.undie_color = "DDBB22"
				if("hydro")
					butt.undie_color = "00FF00"
				if("sec")
					butt.undie_color = "111111"
				if("engi")
					butt.undie_color = "FFEE00"
				if("atmos")
					butt.undie_color = "FFEE00"
				if("sci")
					butt.undie_color = "660099"
				if("med")
					butt.undie_color = "4488AA"
				if("miner")
					butt.undie_color = "777777"
				if("miner_thick")
					butt.undie_color = "777777"
				if("jeans")
					butt.undie_color = "587890"
				if("jeans_thick")
					butt.undie_color = "587890"
				if("circuit")
					butt.undie_color = "003300"
				if("pink")
					butt.undie_color = "FFC0CB"
				if("pink_thick")
					butt.undie_color = "FFC0CB"
				if("punk")
					butt.undie_color = "000000"
				if("punk_thick")
					butt.undie_color = "000000"
				if("fish")
					butt.undie_color = "ABCDEF"
				if("SMWind")
					butt.undie_color = "0BDA51"
				if("ratvar")
					butt.undie_color = "B8860B"
				if("narsie")
					butt.undie_color = "3D0000"
				if("ashwalker")
					butt.undie_color = "DAA520"
				if("camo")
					butt.undie_color = "568203"
				if("alien")
					butt.undie_color = "563C5C"
				if("greentext")
					butt.undie_color = "46DA3E"
				if("scalies")
					butt.undie_color = "46DA3E"
				if("blackcat")
					butt.undie_color = "FFFFFF"
				if("goldendog")
					butt.undie_color = "000000"
				if("leafy")
					butt.undie_color = "698B57"
				if("slime")
					butt.undie_color = "83639D"
				if("skunk")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/skunk()
				if("bee")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/bee()
				if("rainbow")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/rainbow()
				if("rainbow_thick")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/rainbow_thick()
				if("matri")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/matri()
				if("ringading")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/ringading()
				if("hawaiir")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/hawaiir()
				if("hawaiib")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/hawaiib()
				if("pumpkin")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/pumpkin()
				if("jacko")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/halloween()
				if("blue_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
				if("pink_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "FFC0CB"
				if("green_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
				if("skunk_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
				if("water_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "ABCDEF"
				if("space_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "3366CC"
				if("sky_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "587890"
				if("gmr_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "8833FF"
				if("underwear")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/briefs()
				if("hyper")
					if(butt.stinkiness < 150)
						butt.undie_color = "EEEEFF"
					else
						butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/hyper()
		else
			butt.underwear = underwear
			butt.undie_color = undie_color
		butt.update_body()
	if(iscyborg(parent))
		var/mob/living/silicon/robot/butt = parent
		if(butt.incontinent == TRUE)
			butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper()
			switch(butt.brand)
				if("plain")
					butt.undie_color = "FFFFFF"
				if("classic")
					butt.undie_color = "66FF66"
				if("thirteen")
					butt.undie_color = "FFFFFF"
				if("swaddles")
					butt.undie_color = "3399CC"
				if("cloth")
					butt.undie_color = "FFFFFF"
				if("hefters_m")
					butt.undie_color = "EEEEFF"
				if("hefters_f")
					butt.undie_color = "FFDDEE"
				if("princess")
					butt.undie_color = "FF99FF"
				if("pwrgame")
					butt.undie_color = "8833FF"
				if("starkist")
					butt.undie_color = "FF9933"
				if("space")
					butt.undie_color = "3366CC"
				if("syndi")
					butt.undie_color = "CC0000"
				if("service")
					butt.undie_color = "999999"
				if("supply")
					butt.undie_color = "DDBB22"
				if("hydro")
					butt.undie_color = "00FF00"
				if("sec")
					butt.undie_color = "111111"
				if("engi")
					butt.undie_color = "FFEE00"
				if("atmos")
					butt.undie_color = "FFEE00"
				if("sci")
					butt.undie_color = "660099"
				if("med")
					butt.undie_color = "4488AA"
				if("miner")
					butt.undie_color = "777777"
				if("miner_thick")
					butt.undie_color = "777777"
				if("jeans")
					butt.undie_color = "587890"
				if("jeans_thick")
					butt.undie_color = "587890"
				if("circuit")
					butt.undie_color = "003300"
				if("pink")
					butt.undie_color = "FFC0CB"
				if("pink_thick")
					butt.undie_color = "FFC0CB"
				if("punk")
					butt.undie_color = "000000"
				if("punk_thick")
					butt.undie_color = "000000"
				if("fish")
					butt.undie_color = "ABCDEF"
				if("SMWind")
					butt.undie_color = "0BDA51"
				if("ratvar")
					butt.undie_color = "B8860B"
				if("narsie")
					butt.undie_color = "3D0000"
				if("ashwalker")
					butt.undie_color = "DAA520"
				if("camo")
					butt.undie_color = "568203"
				if("alien")
					butt.undie_color = "563C5C"
				if("greentext")
					butt.undie_color = "46DA3E"
				if("scalies")
					butt.undie_color = "46DA3E"
				if("blackcat")
					butt.undie_color = "FFFFFF"
				if("goldendog")
					butt.undie_color = "000000"
				if("leafy")
					butt.undie_color = "698B57"
				if("slime")
					butt.undie_color = "83639D"
				if("skunk")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/skunk()
				if("bee")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/bee()
				if("rainbow")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/rainbow()
				if("rainbow_thick")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/rainbow_thick()
				if("matri")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/matri()
				if("ringading")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/ringading()
				if("hawaiir")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/hawaiir()
				if("hawaiib")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/hawaiib()
				if("pumpkin")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/pumpkin()
				if("jacko")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/halloween()
				if("blue_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "33CCFF"
				if("pink_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "FFC0CB"
				if("green_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "99FF66"
				if("skunk_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "141414"
				if("water_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "ABCDEF"
				if("space_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "3366CC"
				if("sky_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "587890"
				if("gmr_trainer")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/diaper/trainer()
					butt.undie_color = "8833FF"
				if("underwear")
					butt.underwear = new /datum/sprite_accessory/underwear/bottom/briefs()
		butt.update_body()
