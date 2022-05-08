	///DIAPERS

/obj/item/diaper
	w_class = 1
	icon = 'icons/incon/diaper.dmi'

/obj/item/wetdiap
	w_class = 1
	name = "wet diaper"
	desc = "Thoroughly soaked."
	icon = 'icons/incon/diaper.dmi'
	hitsound = 'sound/effects/splap.ogg'
	throwhitsound = 'sound/effects/splap.ogg'

/obj/item/poopydiap
	w_class = 1
	name = "poopy diaper"
	desc = "Can be smelled from across the room."
	icon = 'icons/incon/diaper.dmi'
	hitsound = 'sound/effects/splap.ogg'
	throwhitsound = 'sound/effects/splap.ogg'

/obj/item/poopydiap/Initialize()
	. = ..()
	smelly()

/obj/item/poopydiap/proc/smelly()
	if(istype(loc, /obj/structure/closet/crate/diaperpail))
		return

	if(istype(src, /obj/item/poopydiap/atmos))
		return
	var/stinkyturf = get_turf(src)

	// Closed turfs don't have any air in them, so no gas building up
	if(istype(stinkyturf,/turf/open))
		var/turf/open/stink_turf = stinkyturf
		var/datum/gas_mixture/noxious = new
		noxious.set_moles(GAS_DIAPERSMELL,0.75)
		noxious.set_temperature(BODYTEMP_NORMAL)
		stink_turf.assume_air(noxious)
		stink_turf.air_update_turf()

	spawn(20)
		smelly()

/obj/item/useddiap
	w_class = 1
	name = "used diaper"
	desc = "Whoever had this on obviously needed it."
	icon = 'icons/incon/diaper.dmi'
	hitsound = 'sound/effects/splap.ogg'
	throwhitsound = 'sound/effects/splap.ogg'

/obj/item/useddiap/Initialize()
	. = ..()
	stinky()

/obj/item/useddiap/proc/stinky()
	if(istype(loc, /obj/structure/closet/crate/diaperpail))
		return

	if(istype(src, /obj/item/useddiap/atmos))
		return
	var/stinkturf = get_turf(src)

	// Closed turfs don't have any air in them, so no gas building up
	if(istype(stinkturf,/turf/open))
		var/turf/open/stinky_turf = stinkturf
		var/datum/gas_mixture/nox = new
		nox.set_moles(GAS_DIAPERSMELL,0.1)
		nox.set_temperature(BODYTEMP_NORMAL)
		stinky_turf.assume_air(nox)
		stinky_turf.air_update_turf()

	spawn(20)
		stinky()


/obj/item/diaper/plain
	name = "diaper"
	desc = "Keeps accidents at bay!"
	icon_state = "plain"

/obj/item/diaper/attack(mob/living/carbon/human/M as mob, mob/usr as mob)
	if(M == usr && HAS_TRAIT(M,TRAIT_NOCHANGESELF))
		to_chat(usr, "<span class='warning'>You don't know how to change yourself!</span>")
	else if(M.client.prefs.accident_types != "Opt Out")
		playsound(M.loc,'sound/effects/Diapertape.wav',50,1)
		if(do_after_mob(usr,M))
			M.DiaperChange(src)
			M.brand2 = name
			M.DiaperAppearance()
			if (findtext(M.brand, "hyper") != 0)
				M.heftersbonus = 200
			else if (findtext(M.brand, "hefters") != 0 || findtext(M.brand, "_thick") != 0)
				M.heftersbonus = 100
			else if (findtext(M.brand, "trainer") != 0 || findtext(M.brand, "_trainer") != 0)
				M.heftersbonus = -80
			else if (findtext(M.brand, "underwear") != 0 || findtext(M.brand, "_underwear") != 0)
				M.heftersbonus = -140
			else
				M.heftersbonus = 0
			Del()

/obj/item/diaper/attack(mob/living/silicon/robot/M as mob, mob/usr as mob)
	if(M == usr && HAS_TRAIT(M,TRAIT_NOCHANGESELF))
		to_chat(usr, "<span class='warning'>You don't know how to change yourself!</span>")
	else if(M.client.prefs.accident_types != "Opt Out" || M.client == null)
		playsound(M.loc,'sound/effects/Diapertape.wav',50,1)
		if(do_after_mob(usr,M))
			M.DiaperChange(src)
			M.brand2 = name
			M.DiaperAppearance()
			if (findtext(M.brand, "hefters") != 0 || findtext(M.brand, "_thick") != 0)
				M.heftersbonus = 100
			else if (findtext(M.brand, "trainer") != 0 || findtext(M.brand, "_trainer") != 0)
				M.heftersbonus = -80
			else if (findtext(M.brand, "underwear") != 0 || findtext(M.brand, "_underwear") != 0)
				M.heftersbonus = -140
			else
				M.heftersbonus = 0
			Del()
/obj/item/wetdiap/plain
	icon_state = "plain_wet"

/obj/item/poopydiap/plain
	icon_state = "plain_messy"

/obj/item/useddiap/plain
	icon_state = "plain_full"

/obj/item/diaper/classic
	name = "\improper CuddleCom Classic"
	desc = "A diaper from Nanotransen's own design brand. Used ones can be used as fertilizer."
	icon_state = "classics"

/obj/item/wetdiap/classic
	icon_state = "classics_wet"

/obj/item/poopydiap/classic
	icon_state = "classics_messy"

/obj/item/useddiap/classic
	icon_state = "classics_full"

/obj/item/diaper/swaddles
	name = "\improper Star Spawn Swaddlers"
	desc = "Popular among cultists, this diaper is enchanted to protect innocent minds from going insane."
	icon_state = "swaddles"

/obj/item/wetdiap/swaddles
	icon_state = "swaddles_wet"

/obj/item/poopydiap/swaddles
	icon_state = "swaddles_messy"

/obj/item/useddiap/swaddles
	icon_state = "swaddles_full"

/obj/item/diaper/hefters_m
	name = "\improper Hefters"
	desc = "Geared for long-term and night-time use, this brand can handle more accidents."
	icon_state = "hefters_m"

/obj/item/wetdiap/hefters_m
	icon_state = "hefters_m_wet"

/obj/item/poopydiap/hefters_m
	icon_state = "hefters_m_messy"

/obj/item/useddiap/hefters_m
	icon_state = "hefters_m_full"

/obj/item/diaper/hefters_f
	name = "\improper Hefters"
	desc = "Geared for long-term and night-time use, this brand can handle more accidents."
	icon_state = "hefters_f"

/obj/item/wetdiap/hefters_f
	icon_state = "hefters_f_wet"

/obj/item/poopydiap/hefters_f
	icon_state = "hefters_f_messy"

/obj/item/useddiap/hefters_f
	icon_state = "hefters_f_full"

/obj/item/diaper/princess
	name = "\improper SnuggleSpace Princess"
	desc = "A diaper for the elegant and charismatic. You're sure to get a raise if you wear these!"
	icon_state = "Princess"
	custom_price = 50

/obj/item/wetdiap/princess
	icon_state = "Princess_wet"

/obj/item/poopydiap/princess
	icon_state = "Princess_messy"

/obj/item/useddiap/princess
	icon_state = "Princess_full"

/obj/item/diaper/pwrgame
	name = "\improper PwrGame Gamerpants"
	desc = "A diaper for both epic streamers and casual players. Wear this, and any dice you roll are rigged in your favor slightly."
	icon_state = "PwrGame"

/obj/item/wetdiap/pwrgame
	icon_state = "PwrGame_wet"

/obj/item/poopydiap/pwrgame
	icon_state = "PwrGame_messy"

/obj/item/useddiap/pwrgame
	icon_state = "PwrGame_full"

/obj/item/diaper/starkist
	name = "\improper StarKist Nightlights"
	desc = "For little ones afraid of the monsters under their bed. Glows in the dark."
	icon_state = "StarKist"

/obj/item/wetdiap/starkist
	icon_state = "StarKist_wet"

/obj/item/poopydiap/starkist
	icon_state = "StarKist_messy"

/obj/item/useddiap/starkist
	icon_state = "StarKist_full"

/obj/item/diaper/space
	name = "\improper CuddleCom Cadets"
	desc = "For brave babies, unflinchingly facing the void. Reduces your need for oxygen."
	icon_state = "Space"

/obj/item/wetdiap/space
	icon_state = "Space_wet"

/obj/item/poopydiap/space
	icon_state = "Space_messy"

/obj/item/useddiap/space
	icon_state = "Space_full"

/obj/item/diaper/hydro
	name = "\improper GreenBeans"
	desc = "For stinkers with a green thumb."
	icon_state = "Hydroponics"
	custom_price = 10

/obj/item/wetdiap/hydro
	icon_state = "Hydroponics_wet"

/obj/item/poopydiap/hydro
	icon_state = "Hydroponics_messy"

/obj/item/useddiap/hydro
	icon_state = "Hydroponics_full"

/obj/item/wetdiap/hydro/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 5)
		Del()
		return
	. = ..()

/obj/item/poopydiap/hydro/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 10)
		Del()
		return
	. = ..()

/obj/item/useddiap/hydro/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 15)
		Del()
		return
	. = ..()

/obj/item/diaper/sci
	name = "\improper SmartiePamps"
	desc = "A diaper for brainy babies."
	icon_state = "Science"

/obj/item/wetdiap/sci
	icon_state = "Science_wet"

/obj/item/poopydiap/sci
	icon_state = "Science_messy"

/obj/item/useddiap/sci
	icon_state = "Science_full"

/obj/item/diaper/atmos
	name = "\improper Gassies"
	desc = "A diaper with exemplary odor locking."
	icon_state = "Atmos"

/obj/item/wetdiap/atmos
	icon_state = "Atmos_wet"

/obj/item/poopydiap/atmos
	icon_state = "Atmos_messy"

/obj/item/useddiap/atmos
	icon_state = "Atmos_full"

/obj/item/diaper/engi
	name = "\improper Girders"
	desc = "Durable diapers that won't come off until you change."
	icon_state = "Engineering"

/obj/item/wetdiap/engi
	icon_state = "Engineering_wet"

/obj/item/poopydiap/engi
	icon_state = "Engineering_messy"

/obj/item/useddiap/engi
	icon_state = "Engineering_full"

/obj/item/diaper/sec
	name = "\improper Briggies"
	desc = "Keeps accidents locked away!"
	icon_state = "Sec"

/obj/item/wetdiap/sec
	icon_state = "Sec_wet"

/obj/item/poopydiap/sec
	icon_state = "Sec_messy"

/obj/item/useddiap/sec
	icon_state = "Sec_full"

/obj/item/diaper/supply
	name = "\improper Packers"
	desc = "Pack cargo without worrying about your packed pants!"
	icon_state = "Supply"

/obj/item/wetdiap/supply
	icon_state = "Supply_wet"

/obj/item/poopydiap/supply
	icon_state = "Supply_messy"

/obj/item/useddiap/supply
	icon_state = "Supply_full"

/obj/item/diaper/service
	name = "\improper GreyWaves"
	desc = "For assistants who need a little help with their accidents."
	icon_state = "Service"

/obj/item/wetdiap/service
	icon_state = "Service_wet"

/obj/item/poopydiap/service
	icon_state = "Service_messy"

/obj/item/useddiap/service
	icon_state = "Service_full"

/obj/item/diaper/med
	name = "\improper Caries"
	desc = "Sometimes, caregivers need help too!"
	icon_state = "Med"

/obj/item/wetdiap/med
	icon_state = "Med_wet"

/obj/item/poopydiap/med
	icon_state = "Med_messy"

/obj/item/useddiap/med
	icon_state = "Med_full"

/obj/item/diaper/nt
	name = "\improper CommandSeats"
	desc = "A diaper with an aura of prestige and command!"
	icon_state = "NT"

/obj/item/wetdiap/nt
	icon_state = "NT_wet"

/obj/item/poopydiap/nt
	icon_state = "NT_messy"

/obj/item/useddiap/nt
	icon_state = "NT_full"

/obj/item/diaper/syndi
	name = "\improper SyndiStinker Chameleons"
	desc = "For when you need to leave no evidence behind. Heals brute damage, and disguises itself as a plain diaper when changed."
	icon_state = "Replica"

/obj/item/diaper/syndi/rep
	name = "\improper SyndiSmeller Chameleons"
	desc = "A replica of the real deal"

/obj/item/diaper/narsie
	name = "\improper Narsmellies"
	desc = "Despite being a blood cult, we hope there isn't any here."
	icon_state = "Cult_Nar"

/obj/item/wetdiap/narsie
	icon_state = "Cult_Nar_wet"

/obj/item/poopydiap/narsie
	icon_state = "Cult_Nar_messy"

/obj/item/useddiap/narsie
	icon_state = "Cult_Nar_full"

/obj/item/diaper/ratvar
	name = "Rat-downs"
	desc = "Tick Tock... looks like you didn't make it!"
	icon_state = "Cult_Clock"

/obj/item/wetdiap/ratvar
	icon_state = "Cult_Clock_wet"

/obj/item/poopydiap/ratvar
	icon_state = "Cult_Clock_messy"

/obj/item/useddiap/ratvar
	icon_state = "Cult_Clock_full"

/obj/item/diaper/jeans
	name = "\improper Jiaper"
	desc = "Pretend you don't pee yourself while still protecting yourself from accidents."
	icon_state = "Jeans"

/obj/item/wetdiap/jeans
	icon_state = "Jeans_wet"

/obj/item/poopydiap/jeans
	icon_state = "Jeans_messy"

/obj/item/useddiap/jeans
	icon_state = "Jeans_full"

/obj/item/diaper/jeans_thick
	name = "\improper Hyper Jiaper"
	desc = "Pretend you don't pee yourself while still protecting yourself from accidents."
	icon_state = "Jeans_thicc"

/obj/item/wetdiap/jeans_thick
	icon_state = "Jeans_wet"

/obj/item/poopydiap/jeans_thick
	icon_state = "Jeans_messy"

/obj/item/useddiap/jeans_thick
	icon_state = "Jeans_full"

/obj/item/diaper/ashwalker
	name = "\improper Ashwaddlers"
	desc = "Unga Bunga. What's a toilet?"
	icon_state = "Ashwalker"

/obj/item/wetdiap/ashwalker
	icon_state = "Ashwalker_wet"

/obj/item/poopydiap/ashwalker
	icon_state = "Ashwalker_messy"

/obj/item/useddiap/ashwalker
	icon_state = "Ashwalker_messy"

/obj/item/diaper/alien
	name = "\improper High Tech MAG"
	desc = "Even in absorbancy garments the aliens use the highest tech."
	icon_state = "alien"

/obj/item/wetdiap/alien
	icon_state = "alien_wet"

/obj/item/poopydiap/alien
	icon_state = "alien_messy"

/obj/item/useddiap/alien
	icon_state = "alien_full"

/obj/item/diaper/miner
	name = "\improper Diamondpers"
	desc = "Extra hard to protect your crotch."
	icon_state = "Miner"

/obj/item/wetdiap/miner
	icon_state = "Miner_wet"

/obj/item/poopydiap/miner
	icon_state = "Miner_messy"

/obj/item/useddiap/miner
	icon_state = "Miner_full"

/obj/item/diaper/miner_thick
	name = "\improper Diamondpers Ultra"
	desc = "Extra hard to protect your crotch."
	icon_state = "Miner_thick"

/obj/item/wetdiap/miner_thick
	icon_state = "Miner_wet"

/obj/item/poopydiap/miner_thick
	icon_state = "Miner_messy"

/obj/item/useddiap/miner_thick
	icon_state = "Miner_full"

/obj/item/diaper/punk
	name = "\improper Lacquer Pacquer"
	desc = "Punk's not dead! Though it may smell like it."
	icon_state = "Punk"

/obj/item/wetdiap/punk
	icon_state = "Punk_wet"

/obj/item/poopydiap/punk
	icon_state = "Punk_messy"

/obj/item/useddiap/punk
	icon_state = "Punk_full"

/obj/item/diaper/punk_thick
	name = "\improper Lacquer Pacquer EXTRA"
	desc = "Punk's not dead! Though it may smell like it."
	icon_state = "Punk_thick"

/obj/item/wetdiap/punk_thick
	icon_state = "Punk_wet"

/obj/item/poopydiap/punk_thick
	icon_state = "Punk_messy"

/obj/item/useddiap/punk_thick
	icon_state = "Punk_full"

/obj/item/diaper/pink
	name = "\improper Pink Dreams"
	desc = "Pink's not dead! See what I did there?"
	icon_state = "Pink"

/obj/item/wetdiap/pink
	icon_state = "Pink_wet"

/obj/item/poopydiap/pink
	icon_state = "Pink_messy"

/obj/item/useddiap/pink
	icon_state = "Pink_messy"

/obj/item/diaper/pink_thick
	name = "\improper Pink Fantasies"
	desc = "Pink's not dead! See what I did there?"
	icon_state = "Pink_thick"

/obj/item/wetdiap/pink_thick
	icon_state = "Pink_wet"

/obj/item/poopydiap/pink_thick
	icon_state = "Pink_messy"

/obj/item/useddiap/pink_thick
	icon_state = "Pink_messy"

/obj/item/diaper/thirteen
	name = "\improper Limited Edition Thirteen"
	desc = "It's a plain diaper but this one has a number on it. Riveting!"
	icon_state = "13"

/obj/item/wetdiap/thirteen
	icon_state = "plain_wet"

/obj/item/poopydiap/thirteen
	icon_state = "plain_messy"

/obj/item/useddiap/thirteen
	icon_state = "plain_full"

/obj/item/diaper/bee
	name = "\improper Beepers"
	desc = "Bees communicate by dancing. YOU communicate with a potty dance!"
	icon_state = "bee"

/obj/item/wetdiap/bee
	icon_state = "bee_wet"

/obj/item/poopydiap/bee
	icon_state = "bee_messy"

/obj/item/useddiap/bee
	icon_state = "bee_full"

/obj/item/diaper/camo
	name = "\improper Peekers"
	desc = "Diaper? Which diaper?"
	icon_state = "Camo"

/obj/item/wetdiap/camo
	icon_state = "Camo_wet"

/obj/item/poopydiap/camo
	icon_state = "Camo_messy"

/obj/item/useddiap/camo
	icon_state = "Camo_messy"

/obj/item/diaper/circuit
	name = "\improper CoderPants"
	desc = "Looks very advanced with all the circuits."
	icon_state = "circuit"

/obj/item/wetdiap/circuit
	icon_state = "circuit_wet"

/obj/item/poopydiap/circuit
	icon_state = "circuit_messy"

/obj/item/useddiap/circuit
	icon_state = "circuit_messy"

/obj/item/diaper/matri
	name = "\improper The Source"
	desc = "01010011 01110100 01101001 01101110 01101011 01111001 00001010."
	icon_state = "matrix"

/obj/item/wetdiap/matri
	icon_state = "matrix_wet"

/obj/item/poopydiap/matri
	icon_state = "matrix_messy"

/obj/item/useddiap/matri
	icon_state = "matrix_messy"

/obj/item/diaper/rainbow
	name = "\improper DiaPride"
	desc = "RAINBOOOOOOW!"
	icon_state = "rainbow"

/obj/item/wetdiap/rainbow
	icon_state = "rainbow_wet"

/obj/item/poopydiap/rainbow
	icon_state = "rainbow_messy"

/obj/item/useddiap/rainbow
	icon_state = "rainbow_messy"

/obj/item/diaper/rainbow_thick
	name = "\improper DiaPride Special Edition"
	desc = "The special edition. Said to hold more without being thicker."
	icon_state = "rainbowse"

/obj/item/wetdiap/rainbow_thick
	icon_state = "rainbow_wet"

/obj/item/poopydiap/rainbow_thick
	icon_state = "rainbow_messy"

/obj/item/useddiap/rainbow_thick
	icon_state = "rainbow_messy"

/obj/item/diaper/fish
	name = "\improper Sharkies"
	desc = "Gums Unleashed. Smells kinda fishy."
	icon_state = "fish"

/obj/item/wetdiap/fish
	icon_state = "fish_wet"

/obj/item/poopydiap/fish
	icon_state = "fish_messy"

/obj/item/useddiap/fish
	icon_state = "fish_full"

/obj/item/diaper/skunk
	name = "\improper Skunkies"
	desc = "They can contain skunk spray. Mostly."
	icon_state = "skunk"

/obj/item/wetdiap/skunk
	icon_state = "skunk_wet"

/obj/item/poopydiap/skunk
	icon_state = "skunk_messy"

/obj/item/useddiap/skunk
	icon_state = "skunk_full"

/obj/item/diaper/ringading
	name = "\improper Ringadings"
	desc = "Ringadings for your Dingalings."
	icon_state = "ringading"

/obj/item/wetdiap/ringading
	icon_state = "ringading_wet"

/obj/item/poopydiap/ringading
	icon_state = "ringading_messy"

/obj/item/useddiap/ringading
	icon_state = "ringading_messy"

/obj/item/diaper/greentext
	name = "\improper Greentexts"
	desc = "For some reason people really want these."
	icon_state = "greentext"

/obj/item/wetdiap/greentext
	icon_state = "greentext_wet"

/obj/item/poopydiap/greentext
	icon_state = "greentext_messy"

/obj/item/useddiap/greentext
	icon_state = "greentext_messy"

/obj/item/diaper/hawaiir
	name = "\improper Hawaiian Diapers (Red)"
	desc = "For that summer feeling."
	icon_state = "hawaiir"

/obj/item/wetdiap/hawaiir
	icon_state = "hawaiir_wet"

/obj/item/poopydiap/hawaiir
	icon_state = "hawaiir_messy"

/obj/item/useddiap/hawaiir
	icon_state = "hawaiir_messy"

/obj/item/diaper/hawaiib
	name = "\improper Hawaiian Diapers (Blue)"
	desc = "For that summer feeling."
	icon_state = "hawaiib"

/obj/item/wetdiap/hawaiib
	icon_state = "hawaiib_wet"

/obj/item/poopydiap/hawaiib
	icon_state = "hawaiib_messy"

/obj/item/useddiap/hawaiib
	icon_state = "hawaiib_messy"

/obj/item/diaper/blackcat
	name = "\improper Black Cats"
	desc = "Bad luck? Not with these. Unless they leak."
	icon_state = "blackcat"

/obj/item/wetdiap/blackcat
	icon_state = "blackcat_wet"

/obj/item/poopydiap/blackcat
	icon_state = "blackcat_messy"

/obj/item/useddiap/blackcat
	icon_state = "blackcat_messy"

/obj/item/diaper/goldendog
	name = "\improper Golden Retrievers"
	desc = "Dogs are loyal. Diapers are loyal too. We put dogs on your diapers."
	icon_state = "goldendog"

/obj/item/wetdiap/goldendog
	icon_state = "goldendog_wet"

/obj/item/poopydiap/goldendog
	icon_state = "goldendog_messy"

/obj/item/useddiap/goldendog
	icon_state = "goldendog_messy"

/obj/item/diaper/pumpkin
	name = "\improper Bum-Kins"
	desc = "Pumpkins for your Bum."
	icon_state = "pumpkin"

/obj/item/wetdiap/pumpkin
	icon_state = "pumpkin_wet"

/obj/item/poopydiap/pumpkin
	icon_state = "pumpkin_messy"

/obj/item/useddiap/pumpkin
	icon_state = "pumpkin_messy"

/obj/item/diaper/jacko
	name = "\improper Jack-O-Pamps"
	desc = "Spoopy."
	icon_state = "jacko"

/obj/item/wetdiap/jacko
	icon_state = "jacko_wet"

/obj/item/poopydiap/jacko
	icon_state = "jacko_messy"

/obj/item/useddiap/jacko
	icon_state = "jacko_messy"

/obj/item/diaper/leafy
	name = "\improper Leafy Diapers"
	desc = "Freshly grown and fully biodegradable."
	icon_state = "leafy"

/obj/item/wetdiap/leafy
	icon_state = "leafy_wet"

/obj/item/poopydiap/leafy
	icon_state = "leafy_messy"

/obj/item/useddiap/leafy
	icon_state = "leafy_messy"

/obj/item/wetdiap/leafy/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 10)
		Del()
		return
	. = ..()

/obj/item/poopydiap/leafy/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 15)
		Del()
		return
	. = ..()

/obj/item/useddiap/leafy/attack_obj(obj/O, mob/living/user)
	if(istype(O,/obj/machinery/hydroponics))
		O.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 20)
		Del()
		return
	. = ..()

/obj/item/diaper/slime
	name = "\improper Squishies"
	desc = "These come pre-squished. I guess, if you like that."
	icon_state = "slime"

/obj/item/wetdiap/slime
	icon_state = "slime_wet"

/obj/item/poopydiap/slime
	icon_state = "slime_messy"

/obj/item/useddiap/slime
	icon_state = "slime_messy"

/obj/item/diaper/scalies
	name = "\improper Scalies"
	desc = "Inspired by dragons and favoured by kobolds."
	icon_state = "scalies"

/obj/item/wetdiap/scalies
	icon_state = "scalies_wet"

/obj/item/poopydiap/scalies
	icon_state = "scalies_messy"

/obj/item/useddiap/scalies
	icon_state = "scalies_messy"

/obj/item/diaper/cloth
	name = "\improper Cloth diaper"
	desc = "Held in place with safety pins. Washable!"
	icon_state = "cloth"

/obj/item/wetdiap/cloth
	icon_state = "cloth_wet"

/obj/item/wetdiap/cloth/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/cloth(loc)
	qdel(src)

/obj/item/poopydiap/cloth
	icon_state = "cloth_messy"

/obj/item/poopydiap/cloth/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/cloth(loc)
	qdel(src)

/obj/item/useddiap/cloth
	icon_state = "cloth_messy"

/obj/item/useddiap/cloth/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/cloth(loc)
	qdel(src)

///TESTING HYPER STUFF HERE!!!!!!

/obj/item/diaper/hyper
	name = "\improper Hyper capacity diaper"
	desc = "This unassuming diaper can hold a surprisingly massive load."
	icon_state = "hefters_m"

/obj/item/wetdiap/hyper
	icon_state = "hefters_m_wet"

/obj/item/poopydiap/hyper
	icon_state = "hefters_m_messy"

/obj/item/useddiap/hyper
	icon_state = "hefters_m_full"

	///TRAINING PANTS & MISC

/obj/item/diaper/underwear
	name = "\improper Plain Underwear"
	desc = "You're a big kid now. May hold like, one tiny bladder wetting but will leak very quickly."
	icon_state = "underwear"

/obj/item/wetdiap/underwear
	name = "puddlepants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "cloth_wet"

/obj/item/poopydiap/underwear
	name = "pottypants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "cloth_messy"

/obj/item/useddiap/underwear
	name = "pottypants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "cloth_messy"

/obj/item/wetdiap/underwear/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/underwear(loc)
	qdel(src)

/obj/item/poopydiap/underwear/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/underwear(loc)
	qdel(src)

/obj/item/useddiap/underwear/machine_wash(obj/machinery/washing_machine/WM)
	new /obj/item/diaper/underwear(loc)
	qdel(src)

/obj/item/diaper/blue_trainer
	name = "\improper Training Pants (Blue)"
	desc = "Maybe you're ready. Maybe you are not."
	icon_state = "trainer_blue"

/obj/item/wetdiap/blue_trainer
	name = "wet training pants"
	icon_state = "trainer_blue_wet"

/obj/item/poopydiap/blue_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_blue_messy"

/obj/item/useddiap/blue_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_blue_messy"

/obj/item/diaper/pink_trainer
	name = "\improper Training Pants (Pink)"
	desc = "Maybe you're ready. Maybe you are not."
	icon_state = "trainer_pink"

/obj/item/wetdiap/pink_trainer
	name = "wet training pants"
	icon_state = "trainer_pink_wet"

/obj/item/poopydiap/pink_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_pink_messy"

/obj/item/useddiap/pink_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_pink_messy"

/obj/item/diaper/green_trainer
	name = "\improper Training Pants (Green)"
	desc = "Maybe you're ready. Maybe you are not."
	icon_state = "trainer_green"

/obj/item/wetdiap/green_trainer
	name = "wet training pants"
	icon_state = "trainer_green_wet"

/obj/item/poopydiap/green_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_green_messy"

/obj/item/useddiap/green_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_green_messy"

/obj/item/diaper/skunk_trainer
	name = "\improper Training Pants (Skunk)"
	desc = "Bold of you to assume skunks are ever gonna be ready."
	icon_state = "trainer_skunk"

/obj/item/wetdiap/skunk_trainer
	name = "wet training pants"
	icon_state = "trainer_skunk_wet"

/obj/item/poopydiap/skunk_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_skunk_messy"

/obj/item/useddiap/skunk_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_skunk_messy"

/obj/item/diaper/space_trainer
	name = "\improper Training Pants (Space)"
	desc = "In space nobody can see your accidents. But here we can, the stars fade."
	icon_state = "trainer_space"

/obj/item/wetdiap/space_trainer
	name = "wet training pants"
	icon_state = "trainer_space_wet"

/obj/item/poopydiap/space_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_space_messy"

/obj/item/useddiap/space_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_space_messy"

/obj/item/diaper/sky_trainer
	name = "\improper Training Pants (Sky)"
	desc = "Feat. Rainclouds. Probably also on your potty chart."
	icon_state = "trainer_sky"

/obj/item/wetdiap/sky_trainer
	name = "wet training pants"
	icon_state = "trainer_sky_wet"

/obj/item/poopydiap/sky_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_sky_messy"

/obj/item/useddiap/sky_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_sky_messy"

/obj/item/diaper/water_trainer
	name = "\improper Training Pants (Water)"
	desc = "Feat. Water. Probably also on your potty chart."
	icon_state = "trainer_water"

/obj/item/wetdiap/water_trainer
	name = "wet training pants"
	icon_state = "trainer_water_wet"

/obj/item/poopydiap/water_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_water_messy"

/obj/item/useddiap/water_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_water_messy"

/obj/item/diaper/gmr_trainer
	name = "\improper Gamer Pants (Training)"
	desc = "When gamers don't take breaks they use diapers, you know..."
	icon_state = "trainer_gmr"

/obj/item/wetdiap/gmr_trainer
	name = "wet training pants"
	icon_state = "trainer_gmr_wet"

/obj/item/poopydiap/gmr_trainer
	name = "messy training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_gmr_messy"

/obj/item/useddiap/gmr_trainer
	name = "full training pants"
	desc = "Whoever had this on obviously wasn't ready for it."
	icon_state = "trainer_gmr_messy"

	///DIAPER PACKAGES

/obj/item/diaper_package
	name = "diaper package"
	icon = 'icons/obj/storage.dmi'
	desc = "A package of diapers."
	var/diapersleft = 10
	var/obj/item/diaper/stuffinside = /obj/item/diaper/plain

/obj/item/diaper_package/proc/takeout(stuff, mob/user)
	var/atom/A
	if(ispath(stuff))
		A = new stuff(get_turf(user))
	else
		A = stuff
	if(ishuman(user) && istype(A,/obj/item))
		var/mob/living/carbon/human/H = user
		if(H.put_in_hands(A))
			to_chat(H, "You take a diaper out of the package")
			if(diapersleft == 0)
				icon_state = addtext(icon_state,"-empty")
			return A
	to_chat(user, "You need a free hand to take a diaper out of the package.")
	return null

/obj/item/diaper_package/attack_self(mob/user)
	. = ..()
	if(user.held_items[user.get_inactive_hand_index()] == null)
		if(diapersleft > 0)
			diapersleft--
			takeout(stuffinside, user)
		else
			to_chat(user, "<span class='warning'>The package is out of diapers!</span>")
	else
		to_chat(user, "You need a free hand to take a diaper out of the package.")

/obj/item/diaper_package/plain
	icon_state = "diaperpack-plain"
	custom_price = 50

/obj/item/diaper_package/classic
	icon_state = "diaperpack-classics"
	stuffinside = /obj/item/diaper/classic
	custom_price = 50

/obj/item/diaper_package/hefters_m
	icon_state = "diaperpack-heftm"
	stuffinside = /obj/item/diaper/hefters_m
	custom_price = 100

/obj/item/diaper_package/hefters_f
	icon_state = "diaperpack-heftf"
	stuffinside = /obj/item/diaper/hefters_f
	custom_price = 100

/obj/item/diaper_package/syndi
	icon_state = "diaperpack-syndichameleon"
	stuffinside = /obj/item/diaper/syndi

/obj/item/diaper_package/ratvar
	icon_state = "diaperpack-ratvar"
	stuffinside = /obj/item/diaper/ratvar

/obj/item/diaper_package/narsie
	icon_state = "diaperpack-narsie"
	stuffinside = /obj/item/diaper/narsie

/obj/item/diaper_package/ashwalker
	icon_state = "diaperpack-ashwalker"
	stuffinside = /obj/item/diaper/ashwalker

/obj/item/diaper_package/alien
	icon_state = "diaperpack-alien"
	stuffinside = /obj/item/diaper/alien

/obj/item/diaper_package/jeans
	icon_state = "diaperpack-jeans"
	stuffinside = /obj/item/diaper/jeans
	custom_price = 50

/obj/item/diaper_package/thick_miner
	icon_state = "diaperpack-thickminer"
	stuffinside = /obj/item/diaper/miner_thick

	///DIAPER BAGS

/obj/item/storage/backpack/diaper_bag
	name = "diaper bag"
	desc = "A bag for holding many diapers at once."
	icon_state = "duffel-diap-plain"
	item_state = "duffel"
	custom_price = 80
	color = "#FFFFFF"
	slot_flags = ITEM_SLOT_BELT || ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/diaper_bag/Initialize()
	. = ..()
	var/vek = pick("duffel-diap-plain","duffel-diap-med","duffel-diap-babypink","duffel-diap-babyblue","duffel-diap-rainbow","duffel-diap-butterflies","duffel-diap-peeyellow","duffel-diap-hypno","duffel-diap-seizure")
	icon_state = vek
	var/static/mutable_appearance/bluespacey = mutable_appearance('icons/obj/storage.dmi', "duffel-diap-bluespaceoverlay")
	if (istype(src, /obj/item/storage/backpack/diaper_bag/bluespace))
		add_overlay(bluespacey)

/obj/item/storage/backpack/diaper_bag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.max_combined_w_class = 100
	STR.max_items = 20
	STR.can_hold = typecacheof(list(/obj/item/diaper))

/obj/item/storage/backpack/diaper_bag/PopulateContents()
	. = ..()
	new /obj/item/diaper/plain(src)
	new /obj/item/diaper/plain(src)
	new /obj/item/diaper/thirteen(src)
	new /obj/item/diaper/hefters_m(src)
	new /obj/item/diaper/hefters_f(src)

/obj/item/storage/backpack/diaper_bag/bluespace
	name = "bluespace diaper bag"
	desc = "A bag for holding LIKE SO MANY diapers at once."
	item_state = "duffel"
	custom_price = 500
	color = "#FFFFFF"
	slot_flags = ITEM_SLOT_BELT || ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/diaper_bag/bluespace/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STBS = GetComponent(/datum/component/storage)
	STBS.max_w_class = WEIGHT_CLASS_TINY
	STBS.max_combined_w_class = 200
	STBS.max_items = 40
	STBS.can_hold = typecacheof(list(/obj/item/diaper))

/obj/item/storage/backpack/diaper_bag/bluespace/PopulateContents()
	new /obj/item/diaper/hefters_m(src)
	new /obj/item/diaper/hefters_m(src)
	new /obj/item/diaper/hefters_m(src)
	new /obj/item/diaper/hefters_f(src)
	new /obj/item/diaper/hefters_f(src)
	new /obj/item/diaper/hefters_f(src)
