/mob/living/carbon/var/pee = 0
/mob/living/carbon/var/poop = 0
/mob/living/carbon/var/wetness = 0
/mob/living/carbon/var/stinkiness = 0
/mob/living/carbon/var/fluids = 0
/mob/living/var/max_wetcontinence = 100
/mob/living/var/max_messcontinence = 100
/mob/living/carbon/var/on_purpose = 0
/mob/living/carbon/var/brand = "plain"
/mob/living/carbon/var/brand2 = "diaper"
/mob/living/carbon/var/brand3 = "plain"
/mob/living/carbon/var/heftersbonus = 0
/mob/living/carbon/var/needpee = 0
/mob/living/carbon/var/needpoo = 0
/mob/living/carbon/var/regressiontimer = 0
/mob/living/carbon/var/stinky = FALSE
/mob/living/carbon/var/statusoverlay = null
/mob/living/var/combatoverlay = null
/mob/var/rollbonus = 0
/obj/item/var/soiled = FALSE
/mob/living/carbon/human/var/soiledunderwear = FALSE
/mob/living/carbon/human/var/wearingpoopy = FALSE
/mob/living/silicon/robot/var/onpurpose = 0
/mob/living/silicon/robot/var/pee = 0
/mob/living/silicon/robot/var/on_purpose = 0
/mob/living/silicon/robot/var/wetness = 0
/mob/living/silicon/robot/var/fluids = 0
/mob/living/silicon/robot/var/needpee = 0
/mob/living/silicon/robot/var/brand = "plain"
/mob/living/silicon/robot/var/brand2 = "diaper"
/mob/living/silicon/robot/var/brand3 = "plain"
/mob/living/silicon/robot/var/heftersbonus = 0
/mob/living/silicon/robot/var/statusoverlay = null
/mob/living/silicon/robot/var/incontinent = FALSE
/mob/living/silicon/robot/var/diaperoverlay = null
/mob/living/silicon/robot/var/datum/sprite_accessory/underwear/underwear = new /datum/sprite_accessory/underwear/bottom/diaper()
/mob/living/silicon/robot/var/undie_color = "FFFFFF"
/mob/living/silicon/robot/var/overheattimer = 0
/mob/living/silicon/robot/var/needfluid = 0

/mob/living/silicon/robot/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/diaperswitch)

//This is the SQLite database where all the flavortext is stored
var/database/db = new("code/modules/incon/InconFlavortextDB.db")
//To view it, use a website like https://sqliteonline.com/ or a program like https://sqlitebrowser.org/dl/
//Each row has a "selfmessage" column (what the player will see), an "othersmessage" column (what the other players will see if appropriate), a unique ID, and a whole list of boolean columns that act as flags
//When adding rows to the database, each flag should be set to 0 or 1 depending on if a player with that state/condition/etc should be shown the message
//e.g. the "onpurpose" flag should be 1 if and only if the message should be displayed when the player tries to poop or pee on purpose
//So if you want to add more content, just paste the appropriate messages in the "selfmessage" and "othersmessage" columns in the BYOND-friendly formatting that you would otherwise put in the code,
//go through each of the columns and decide which flags you want to give the message, save the database file, and replace the one in the incon folder
//And that's it!



/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/diaperswitch)



/mob/living/carbon/proc/DisplayFlavortextMessage(messageType) //this proc handles all the flavortext messages for accidents and warnings
															  //the argument is a string that specifies the desired message

	var/pottyState = "notoilet" 	//this variable represents if the player is on a toilet, potty, or similar device
									//valid options here are: notoilet, usingtoilet, usingpotty

	var/purposeState = "notonpurpose"	//this variable represents if the player is using their diaper/potty on purpose, or if it's been forced
										//valid options are: onpurpose, notonpurpose

	var/taurState = "isnottaur"	//this represents if the player is a non-taur, or any kind of taur (with no distinguishing between the types currently)
								//valid options are: istaur, isnottaur

	var/tailState = "notail"	//this represents if the player has any kind of tail, or no tail (with no distinguishing between the types of tails
								//valid options are: hastail, notail
								//right now, we can't check if people have tails; I don't understand how the tails work in this game at the moment

	if(ishuman(src))	//if the player is a human, we check for the taur DNA feature
		var/mob/living/carbon/human/H = src
		if (H.dna.features["taur"] != "None")	//if we find that they're some sort of taur, we set their taurState to the appropriate value
			taurState = "istaur"

	if (istype(src.buckled,/obj/structure/potty)) //if the player is buckled onto a potty or toilet, we set the potty state to the appropriate value
		pottyState = "usingpotty"
	if (istype(src.buckled,/obj/structure/toilet))
		pottyState = "usingtoilet"

	if(on_purpose)	//if the player is pooping/peeing/etc on purpose, we set their purposeState to the appropriate value
		purposeState = "onpurpose"


	// for the folowwing query, we're asking the database to randomly pick exactly one row that was "True" in all the requested column
	// the database is structured so each column functions like a flag, specifying if that message is comparible with a current state: e.g., the "onpotty" colunm is true if and only if that message would make sense to display while a player is sitting on a potty
	// each set of brackets is replaced by a column name specifying different player states: if they're a taur, if they have a tail, if they're having an accident on purpose or not, and if they're on a toilet or potty
	// by supplying each of these column names in the query, the query returns a row that is guarenteed to be applicable to the player's current situation
	var/FlavortextQueryText = text("SELECT * FROM InconFlavortextDB WHERE [] = 1 AND [] = 1 AND [] = 1 AND [] = 1 AND [] = 1 ORDER BY RANDOM() LIMIT 1", pottyState, tailState, taurState, purposeState, messageType)
	//var/database/query/messingQuery = new("SELECT * FROM InconFlavortextDB WHERE ((usingpotty = ?) AND (usingtoilet = ?) AND (onpurpose = ?) AND (poopaccident = 1) AND (? = 1)) ORDER BY RANDOM() LIMIT 1", onPotty, onToilet,on_purpose, taurState)
	var/database/query/FlavortextQuery = new(FlavortextQueryText)

	//if the query does not execute perfectly (and returns a "false"), we display a few error messages in chat for troubleshooting purposes
	if(!FlavortextQuery.Execute(db))
		to_chat(src, "SQL Query Error: " + FlavortextQuery.ErrorMsg() + " Database Error: " + db.ErrorMsg())
	else
		//otherwise, we load the first row, and display the data
		FlavortextQuery.NextRow()
		var/FlavortextQueryResponse = FlavortextQuery.GetRowData()
		src.visible_message(FlavortextQueryResponse["othersmessage"],FlavortextQueryResponse["selfmessage"])

/mob/living/carbon/proc/Wetting()
	if (pee > 0 && stat != DEAD && src.client.prefs != "Poop Only") //this checks if the player actually needs to pee, is alive, and has pee enabled
		needpee = 0	//if we make it this far, we clear the "needpee" flag - we're now peeing

		//first of all, play the pee sound
		if(src.client.prefs.accident_sounds == TRUE)
			playsound(loc, 'sound/effects/pee-diaper.wav', 50, 1)

		//Next we check if the player is on a potty or toilet at the time they pee and, if so, they're rewarded with some extra continence
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (max_wetcontinence < 100)
				max_wetcontinence++
		else
			//if the amount of pee inside a player is higher than the max continence, we knock it down to the max continence
			if(pee > max_wetcontinence)
				pee = max_wetcontinence

			//this block of code allows people to pee on the floor if they're nude (in the future)
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(H.hidden_underwear == TRUE || H.underwear == "Nude")
					pee = 0
					new /obj/effect/decal/cleanable/waste/peepee(loc)


			//this block updates the wetness of the diaper
			//
			//if the "wetness" of the diaper won't be overflowing, even with the pee about to be added, it's added like normal
			//otherwise, the wetness of the diaper is maxed, and a pee puddle is spawned on the floor
			//
			//if leaking occurs, the player is penalized with an extra reduction in continence, unlesss they're already under 25% continent

			if(wetness + pee < 200 + heftersbonus)
				wetness = wetness + pee
				pee = 0
			else
				wetness = 200 + heftersbonus
				new /obj/effect/decal/cleanable/waste/peepee(loc)
			if(max_wetcontinence > 25)
				max_wetcontinence-=1

		//finally, we want to display the actual pee flavortext
		//
		//we start by checkinng if the player is totally incontinent
		//if they are, no message is displayed to anyone
		//this should be changed at some point, but for now, this is the best we can do
		if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			//if the player is not fully incontinent, we call the proc to display the flavortext, specifying the sort of message we want to see
			DisplayFlavortextMessage("peeaccident")

		//Finally, regardless of if the player is on a toilet or not, we set pee to 0 and remove the on_purpose flag.
		pee = 0
		on_purpose = 0
		//and thats the end of the pee action!

	else if (stat == DEAD)
		to_chat(src,"You can't pee, you're dead!")

/mob/living/silicon/robot/proc/Wetting()
	if (pee > 0 && stat != DEAD && incontinent == TRUE)
		needpee = 0
		if(src.client.prefs.accident_sounds == TRUE)
			playsound(loc, 'sound/effects/pee-diaper.wav', 50, 1)
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (istype(src.buckled,/obj/structure/potty))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<spawn class='notice'>[src] pulls [src.p_their()] pants down and pees in the potty like a big kid.</span>","<span class='notice'>You tug your pants down and pee in the potty like a big kid.</span>")
				if (max_wetcontinence < 100)
					max_wetcontinence++
			if (istype(src.buckled,/obj/structure/toilet))
				if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
					src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and pees in the toilet.</span>","<span class='notice'>You pull your pants down, and pee in the toilet.</span>")
				if (max_wetcontinence < 100)
					max_wetcontinence++
		/*if (istype(src.buckled,/obj/structure/toilet))
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				src.visible_message("<span class='notice'>[src] pulls [src.p_their()] pants down, and pees in the toilet.</span>","<span class='notice'>You pull your pants down, and pee in the toilet.</span>")
			if (max_wetcontinence < 100)
				max_wetcontinence++*/
		else
			if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
				if (on_purpose == 1) //pee on purpose
					switch(rand(2))
						if(0)
							src.visible_message("<span class='notice'>[src] scrunches [src.p_their()] legs and lets the floodgates open.</span>","<span class='notice'>You scrunch your legs and let the floodgates open.</span>")
						if(1)
							src.visible_message("<span class='notice'>[src] shifts [src.p_their()] stance and sighs, a soft hiss following.</span>","<span class='notice'>You spread your legs and sigh, releasing the pressure from your bladder into your awaiting diaper. </span>")
						else
							src.visible_message("<span class='notice'>[src] legs shift as [src.p_their()] crotch hisses.</span>","<span class='notice'>Spreading your legs softly, the contents of your bladder trickle out into your awaiting diaper.</span>")

				else
					switch(rand(2))	//pee accident
						if(0)
							src.visible_message("<span class='notice'>[src]'s legs buckle as [src.p_they()] [src.p_are()] unable to stop [src.p_their()] bladder from leaking into [src.p_their()] pants!</span>","<span class='notice'>Your legs buckle as you are unable to stop your bladder from leaking into your pants!</span>")
						if(1)
							src.visible_message("<span class='notice'>[src] freezes up as [src.p_their()] crotch hisses.</span>","<span class='notice'>You freeze up as the strain overwhelms your bladder, flooding your pants </span>")
						else
							src.visible_message("<span class='notice'>[src]'s legs buckle as [src.p_they()] [src.p_are()] unable to keep from wetting [src.p_their()] pants!</span>","<span class='notice'>Your legs buckle as you are unable to keep from wetting your pants!</span>")

			if(pee > max_wetcontinence)
				pee = max_wetcontinence
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(H.hidden_underwear == TRUE || H.underwear == "Nude")
					pee = 0
					new /obj/effect/decal/cleanable/waste/peepee(loc, get_static_viruses())
			if(wetness + pee < 200 + heftersbonus)
				wetness = wetness + pee
				pee = 0
			else
				wetness = 200 + heftersbonus
				new /obj/effect/decal/cleanable/waste/peepee(loc, get_static_viruses())
			if(max_wetcontinence > 25)
				max_wetcontinence-=1
		pee = 0
		on_purpose = 0
	else if (stat == DEAD)
		to_chat(src,"You can't pee, you're dead!")

/mob/living/carbon/proc/Pooping()

	if (poop > 0 && stat != DEAD && src.client.prefs != "Pee Only") //this checks if the player actually needs to poop, is alive, and has poop enabled
		needpoo = 0 //if we make it this far, we clear the "needpoo" flag

		//first of all, play the poop sound
		if(src.client.prefs.accident_sounds == TRUE)
			playsound(loc, 'sound/effects/uhoh.ogg', 50, 1)

		//if the amount of poop inside a player is higher than the max continence, we knock it down to the max continence
		if(poop > max_messcontinence)
			poop = max_messcontinence

		//Next, if the player makes it to a potty or toilet, they are rewarded with an increase in their continence
		if (istype(src.buckled,/obj/structure/potty) || istype(src.buckled,/obj/structure/toilet))
			if (max_messcontinence < 100)
				max_messcontinence++
		else //this removes continence from the player if they use their diaper, unless it is already below 20%
			if(max_messcontinence > 20)
				max_messcontinence-=2


			//this block controls the state of your displayed clothing, and also diaper capacity
			//which makes some sense, I guess
			//I don't 100% understand this code, so I am commenting it less
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if((H.hidden_underwear == TRUE || H.underwear == "Nude") && !H.dna.features["taur"])
					if(H.w_uniform != null)
						H.w_uniform.soiled = TRUE
						H.update_inv_w_uniform()
					else
						if(H.wear_suit != null)
							H.wear_suit.soiled = TRUE
							H.update_inv_wear_suit()
					poop = 0
				if(stinkiness + poop < 150 + heftersbonus) //looks like 150 is the hardcoded default diaper capacity
					stinkiness = stinkiness + poop
					if(H.hidden_underwear == FALSE && H.underwear != "Nude")
						H.soiledunderwear = TRUE
						H.update_body()
				else
					stinkiness = 150 + heftersbonus
					if(H.hidden_underwear == FALSE && H.underwear != "Nude")
						H.soiledunderwear = TRUE
						H.update_body()

			//this block gives you stink lines if you don't already have them, and you meet the criteria
			if(stinkiness > ((150 + heftersbonus) / 2) && stinky == FALSE)
				statusoverlay = mutable_appearance('icons/incon/Effects.dmi',"generic_mob_stink",STINKLINES_LAYER, color = rgb(125, 241, 16))
				overlays += statusoverlay
				stinky = TRUE

		//finally, we want to display the actual pee flavortext
		//
		//we start by checkinng if the player is totally incontinent
		//if they are, no message is displayed to anyone
		//this should be changed at some point, but for now, this is the best we can do
		if (!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		    //if the player is not fully incontinent, we call the proc to display the flavortext, specifying the sort of message we want to see
			DisplayFlavortextMessage("poopaccident")

		//finally, we clear the "on_purpose" flag and set poop to 0
		on_purpose = 0
		poop = 0

	else if (stat == DEAD)
		to_chat(src,"You can't poop, you're dead!")

/mob/living/carbon/proc/PampUpdate()
	if(src.client != null)
		if(src.client.prefs.accident_types != "Opt Out")
			if(src.client.prefs.accident_types != "Poop Only")
				pee = pee + ((20 + rand(0, 10))/100) + (fluids / 3000)
				if(HAS_TRAIT(src, TRAIT_STINKER))
					pee = pee + 0.05
			else
				pee = 0
			if(src.client.prefs.accident_types != "Pee Only")
				poop = poop + ((50 + rand(0,50))/1000) + (nutrition / 5000)
				if(HAS_TRAIT(src, TRAIT_STINKER))
					poop = poop + 0.025
			else
				poop = 0
		if(!HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			if (wetness >= 1)
				if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggyhappy)
				else
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggysad)
			else
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
			if (stinkiness >= 1)
				if (HAS_TRAIT(src,TRAIT_POTTYREBEL))
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkyhappy)
				else
					SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"poopy",/datum/mood_event/stinkysad)
			else
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")
		if (fluids > 0)
			fluids = fluids - 10
		if (fluids < 0)
			fluids = 0


		if (pee >= max_wetcontinence * 0.5 && needpee <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			DisplayFlavortextMessage("peefirstwarning")
			needpee += 1
		if (pee >= max_wetcontinence * 0.8 && needpee <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			DisplayFlavortextMessage("peesecondwarning")
			needpee += 1
		if (poop >= max_messcontinence * 0.5 && needpoo <= 0 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			DisplayFlavortextMessage("poofirstwarning")
			needpoo += 1
		if (poop >= max_messcontinence * 0.8 && needpoo <= 1 && !HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
			DisplayFlavortextMessage("poosecondwarning")
			needpoo += 1

		if (pee >= max_wetcontinence && src.client.prefs != "Poop Only")
			Wetting()
		else if(pee >= max_wetcontinence)
			pee = 0
		if (poop >= max_messcontinence && src.client.prefs != "Pee Only")
			Pooping()
		else if(poop >= max_messcontinence)
			poop = 0
		switch(brand)
			if ("plain")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("classics")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("swaddles")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"sanshield",/datum/mood_event/sanitydiaper)
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hefters_m")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hefters_f")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Princess")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = TRUE
				rollbonus = 0
			if ("PwrGame")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 1
			if ("StarKist")
				set_light(3)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Space")
				set_light(0)
				ADD_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Replica")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
				adjustBruteLoss(-0.5)
			if ("Service")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Supply")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Hydroponics")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Sec")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Engineering")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Atmos")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Science")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Med")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Cult_Nar")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Cult_Clock")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Miner")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Miner_thick")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Ashwalker")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("alien")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("Jeans")
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
			if ("hyper")	//TESTING HYPER STUFF HERE!!!
				set_light(0)
				REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
				SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
				SEND_SIGNAL(src,COMSIG_DIAPERCHANGE,src.ckey)
				if (ishuman(src))
					var/mob/living/carbon/human/H = src
					var/datum/bank_account/D = H.get_bank_account()
					if (D)
						D.princessbonus = FALSE
				rollbonus = 0
	spawn(60)
		PampUpdate()

/mob/living/silicon/robot/proc/PampUpdate2()
	if(incontinent == TRUE)
		pee = pee + ((20 + rand(0, 10))/100) + (fluids / 3000)
		if (wetness >= 1)
			SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"peepee",/datum/mood_event/soggysad)
		if (fluids < 75 && needfluid == 0)
			needfluid++
			to_chat(src, "<span class ='warning'>Your chassis is uncomfortably warm.</span>")
		if (fluids == 0)
			if(needfluid == 1)
				needfluid++
				to_chat(src, "<span class ='warning'>Your chassis is nearing dangerously high heat levels!</span>")
			overheat()
		else
			cell.charge = cell.maxcharge
	if (fluids > 0)
		var/feh = rand()
		fluids -= feh
		reagents.remove_any(feh)
	if (fluids < 0)
		fluids = 0
	if (pee >= max_wetcontinence && incontinent == TRUE)
		Wetting()
	else if(pee >= max_wetcontinence)
		pee = 0
	switch(brand)
		if ("plain")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("classics")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("swaddles")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_ADD_MOOD_EVENT,"sanshield",/datum/mood_event/sanitydiaper)
		if ("hefters_m")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("hefters_f")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Princess")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("PwrGame")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("StarKist")
			set_light(3)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Space")
			set_light(0)
			ADD_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Replica")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Service")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Supply")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Hydroponics")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Sec")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Engineering")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Atmos")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Science")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Med")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Cult_Nar")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Cult_Clock")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Miner")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Miner_thick")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Ashwalker")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("alien")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
		if ("Jeans")
			set_light(0)
			REMOVE_TRAIT(src,TRAIT_NOBREATH,INNATE_TRAIT)
			SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"sanshield")
	spawn(60)
		PampUpdate2()

/mob/living/silicon/robot/proc/overheat()
	overheattimer++
	if(overheattimer >= 90)
		cell.charge = 0



/mob/living/carbon/proc/DiaperAppearance()
	SEND_SIGNAL(src,COMSIG_DIAPERCHANGE, ckey(src.mind.key))


/mob/living/carbon/proc/DiaperChange(obj/item/diaper/diap)
	var/turf/cuckold = null
	var/newpamp
	switch(src.dir)
		if(1)
			cuckold = locate(src.loc.x + 1,src.loc.y,src.loc.z)
		if(2)
			cuckold = locate(src.loc.x - 1,src.loc.y,src.loc.z)
		if(4)
			cuckold = locate(src.loc.x,src.loc.y - 1,src.loc.z)
		if(8)
			cuckold = locate(src.loc.x,src.loc.y + 1,src.loc.z)
	if(brand == "syndi")
		brand = "plain"
	if (wetness >= 1)
		if (stinkiness >= 1)
			newpamp = text2path(addtext("/obj/item/useddiap/", brand))
		else
			newpamp = text2path(addtext("/obj/item/wetdiap/", brand))
	else
		if (stinkiness >= 1)
			newpamp = text2path(addtext("/obj/item/poopydiap/", brand))
		else
			newpamp = text2path(addtext("/obj/item/diaper/", brand))
	new newpamp(cuckold)
	wetness = 0
	stinkiness = 0
	overlays -= statusoverlay
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.soiledunderwear = FALSE
		H.update_body()
	stinky = FALSE
	brand = replacetext("[diap.type]", "/obj/item/diaper/", "")
	if(HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"poopy")

/mob/living/silicon/robot/proc/DiaperAppearance()
	SEND_SIGNAL(src,COMSIG_DIAPERCHANGE, ckey(src.mind.key))

/mob/living/silicon/robot/proc/DiaperChange(obj/item/diaper/diap)
	var/turf/cuckold = null
	var/newpamp
	switch(src.dir)
		if(1)
			cuckold = locate(src.loc.x + 1,src.loc.y,src.loc.z)
		if(2)
			cuckold = locate(src.loc.x - 1,src.loc.y,src.loc.z)
		if(4)
			cuckold = locate(src.loc.x,src.loc.y - 1,src.loc.z)
		if(8)
			cuckold = locate(src.loc.x,src.loc.y + 1,src.loc.z)
	if(brand == "syndi")
		brand = "plain"
	if (wetness >= 1)
		newpamp = text2path(addtext("/obj/item/wetdiap/", brand))
	else
		newpamp = text2path(addtext("/obj/item/diaper/", brand))
	new newpamp(cuckold)
	wetness = 0
	overlays -= statusoverlay
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.soiledunderwear = FALSE
		H.update_body()
	brand = replacetext("[diap.type]", "/obj/item/diaper/", "")
	if(HAS_TRAIT(src,TRAIT_FULLYINCONTINENT))
		SEND_SIGNAL(src,COMSIG_CLEAR_MOOD_EVENT,"peepee")

/mob/living/carbon/verb/Pee()
	if(usr.client.prefs.accident_types != "Opt Out" || usr.client.prefs.accident_types != "Poop Only")
		set category = "IC"
	if(src.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && pee >= max_wetcontinence/2)
		on_purpose = 1
		Wetting()
	else
		to_chat(usr, "<span class='warning'>You cannot pee right now.</span>")

/mob/living/silicon/robot/verb/Pee()
	set category = "IC"
	if(incontinent == TRUE && needpee > 0)
		on_purpose = 1
		Wetting()
	else
		to_chat(usr, "<span class='warning'>You cannot pee right now.</span>")

/mob/living/carbon/verb/Poop()
	if(usr.client.prefs.accident_types != "Opt Out" || usr.client.prefs.accident_types != "Pee Only")
		set category = "IC"
	if(src.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(usr,TRAIT_FULLYINCONTINENT) && poop >= max_messcontinence/2)
		on_purpose = 1
		Pooping()
	else
		to_chat(usr, "<span class='warning'>You cannot poop right now.</span>")

/mob/living/carbon/New()
	..()
	PampUpdate()

/mob/living/silicon/robot/Initialize(mapload)
	..()
	PampUpdate2()
	create_reagents(1000)
	var/geh = rand(100,200)
	fluids = geh
	reagents.add_reagent(/datum/reagent/water,geh)
	add_verb(src,/mob/living/silicon/robot/verb/Pee)

/obj/item/reagent_containers/food/snacks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Pee Only")
		M.poop = M.poop + 1

/obj/item/reagent_containers/food/drinks/attack(mob/living/carbon/human/M, mob/living/user, def_zone)
	..()
	if(M.client.prefs.accident_types != "Poop Only")
		M.pee = M.pee + 2
	M.fluids = M.fluids + 25
	if (M.fluids > 300)
		M.fluids = 300

/atom/movable/screen/diaperstatus
	name = "diaper state"
	icon = 'icons/incon/diapercondition.dmi'
	icon_state = "hud_plain"
	screen_loc = ui_diaper
	var/datum/component/waddle

/atom/movable/screen/diaperstatus/proc/DiaperUpdate(mob/living/carbon/owner)
	if(HAS_TRAIT(owner,BABYBRAINED_TRAIT))
		if(owner.regressiontimer > 0)
			owner.regressiontimer--
		else if(owner.reagents.has_reagent(/datum/reagent/medicine/regression))
			owner.regressiontimer = 0
		else
			REMOVE_TRAIT(owner,BABYBRAINED_TRAIT,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NORUNNING,REGRESSION_TRAIT)
			REMOVE_TRAIT(owner,TRAIT_NOGUNS,REGRESSION_TRAIT)
			SEND_SIGNAL(owner,COMSIG_DIAPERCHANGE,owner.ckey)
	if(usr.client.prefs.accident_types != "Opt Out" && !HAS_TRAIT(owner,TRAIT_FULLYINCONTINENT))
		if (owner.wetness > 0)
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_used"
			else
				icon_state = "hud_plain_wet"
		else
			if (owner.stinkiness > 0)
				icon_state = "hud_plain_poopy"
			else
				icon_state = "hud_plain"
	else
		icon_state = null
	if(owner.brand == "Science")
		SSresearch.science_tech.add_point_type(TECHWEB_POINT_TYPE_GENERIC, 0.25)
	if(owner.brand == "alien")
		owner.wetness -= 0.1
		owner.stinkiness -= 0.1
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.wearingpoopy = (H.wear_suit?.soiled == TRUE || H.w_uniform?.soiled == TRUE || (H.soiledunderwear == TRUE && H.stinkiness == 150 + H.heftersbonus && H.hidden_underwear == FALSE))
		if(HAS_TRAIT_FROM(H,TRAIT_NORUNNING, POOPYTRAIT))
			if(H.wearingpoopy == FALSE)
				QDEL_NULL(waddle)
				REMOVE_TRAIT(H,TRAIT_NORUNNING,POOPYTRAIT)
		else
			if(H.wearingpoopy == TRUE)
				waddle = H.AddComponent(/datum/component/waddling)
				ADD_TRAIT(H,TRAIT_NORUNNING,POOPYTRAIT)
				if(H.m_intent == MOVE_INTENT_RUN)
					H.toggle_move_intent()
	spawn(1)
		DiaperUpdate(owner)

/atom/movable/screen/diaperstatus/proc/DiaperUpdate2(mob/living/silicon/robot/owner)
	if(owner.max_wetcontinence > 50)
		owner.max_wetcontinence = 50
	if(owner.incontinent == TRUE)
		if (owner.wetness > 0)
			icon_state = "hud_plain_wet"
		else
			icon_state = "hud_plain"
	else
		icon_state = null
	if(owner.brand == "Science")
		SSresearch.science_tech.add_point_type(TECHWEB_POINT_TYPE_GENERIC, 0.25)
	if(owner.brand == "alien")
		owner.wetness -= 0.1
	spawn(1)
		DiaperUpdate2(owner)

/atom/movable/screen/diaperstatus/New(mob/living/owner)
	if(iscarbon(owner))
		DiaperUpdate(owner)
	if(iscyborg(owner))
		DiaperUpdate2(owner)

/datum/hud/human/New(mob/living/carbon/owner)
	..()
	var/atom/movable/screen/diapstats = new /atom/movable/screen/diaperstatus(owner)
	if (HAS_TRAIT(owner,TRAIT_INCONTINENT))
		owner.max_wetcontinence = 50
		owner.max_messcontinence = 50
	else
		owner.max_wetcontinence = 100
		owner.max_messcontinence = 100
	diapstats.hud = src
	infodisplay += diapstats

/datum/hud/robot/New(mob/living/silicon/robot/owner)
	..()
	var/atom/movable/screen/diapstats = new /atom/movable/screen/diaperstatus(owner)
	diapstats.hud = src
	infodisplay += diapstats

/obj/effect/decal/cleanable/waste
	icon = 'icons/incon/accidents.dmi'
	gender = NEUTER

/obj/effect/decal/cleanable/waste/peepee
	name = "urine"
	desc = "A puddle of urine. Looks like we have a leaker."
	icon_state = "peepee"
	persistent = FALSE

/obj/effect/decal/cleanable/waste/peepee/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	AddComponent(/datum/component/slippery, 80, (NO_SLIP_WHEN_WALKING | SLIDE))

/datum/mood_event/soggysad
	description = "<span class='warning'>Aw man, my pants are wet...\n</span>"
	mood_change = -3

/datum/mood_event/soggyhappy
	description = "<span class='nicegreen'>A wet diaper is always comfy!\n</span>"
	mood_change = 3

/datum/mood_event/stinkysad
	description = "<span class='warning'>Ew... I need a change.\n</span>"
	mood_change = -5

/datum/mood_event/stinkyhappy
	description = "<span class='nicegreen'>Heh, take that, potty!\n</span>"
	mood_change = 5

/datum/mood_event/sanitydiaper
	description = "<span class='nicegreen'>I can't describe it- this diaper makes me feel safe!\n</span>"
	mood_change = 20

/obj/item/stock_parts/cell/incon
	charge = INFINITY
	maxcharge = INFINITY
