// DIURETICS
/datum/chemical_reaction/medicine/diuretic
	name = "Space Diuretics"
	id = /datum/reagent/medicine/diuretic
	results = list(/datum/reagent/medicine/diuretic = 4)
	required_reagents = list(/datum/reagent/sulfur = 2, /datum/reagent/water = 1, /datum/reagent/consumable/sugar = 1)

/datum/reagent/medicine/diuretic
	name = "Space Diuretics"
	description = "Fills the bladder to induce urinary relief."
	taste_description = "water"
	pH = 7.5
	color = "#ccb464"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	overdose_threshold = 50

/datum/reagent/medicine/diuretic/on_mob_life(mob/living/carbon/M)
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	if(M.client.prefs.accident_types != "Poop Only" && src.volume >= 1)
		M.pee += 0.5 * src.volume
	..()

/datum/reagent/medicine/diuretic/overdose_start(mob/living/carbon/M)
	// metabolization_rate = 15 * REAGENTS_METABOLISM
	if(M.client.prefs.accident_types != "Poop Only")
		// ADD_TRAIT(M, TRAIT_WETINCONTINENT, type)
		M.add_quirk(/datum/quirk/urinaryincontinence, TRUE)
	..()
	. = 1

/datum/reagent/medicine/diuretic/overdose_process(mob/living/carbon/M)
	if(prob(20))
		M.Wetting()
	..()
	. = 1

// LAXATIVES
/datum/chemical_reaction/medicine/laxative
	name = "Space Lax"
	id = /datum/reagent/medicine/laxative
	results = list(/datum/reagent/medicine/laxative = 10)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/phenol = 3, /datum/reagent/nitrogen = 1, /datum/reagent/consumable/ethanol = 4)

/datum/reagent/medicine/laxative
	name = "Space Lax"
	description = "Helps alleviate constipation, now 100% more effective than ancient Earth variants!"
	taste_description = "charcoal"
	pH = 7.5
	color = "#543400"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	overdose_threshold = 50

/datum/reagent/medicine/laxative/on_mob_life(mob/living/carbon/M)
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	if(M.client.prefs.accident_types != "Pee Only" && src.volume >= 1)
		M.poop += 0.5 * src.volume
	..()

/datum/reagent/medicine/laxative/overdose_start(mob/living/carbon/M)
	// metabolization_rate = 15 * REAGENTS_METABOLISM
	if(M.client.prefs.accident_types != "Pee Only")
		// ADD_TRAIT(M, TRAIT_MESSINCONTINENT, type)
		M.add_quirk(/datum/quirk/fecalincontinence, TRUE)
	..()
	. = 1

/datum/reagent/medicine/laxative/overdose_process(mob/living/carbon/M)
	var/obj/item/organ/liver/L = M.getorganslot(ORGAN_SLOT_LIVER)
	if(L && prob(10))
		L.applyOrganDamage(0.5)
	if(prob(33))
		M.Pooping()
	..()
	. = 1

// Castor Oil
/datum/chemical_reaction/medicine/castoroil
	name = "Castor Oil"
	id = /datum/reagent/medicine/castoroil
	results = list(/datum/reagent/medicine/castoroil = 3)
	required_reagents = list(/datum/reagent/medicine/laxative = 2, /datum/reagent/medicine/calomel = 1)

/datum/reagent/medicine/castoroil
	name = "Castor Oil"
	description = "Quickly induces bowel movements, purging chemicals and minorly healing toxin damage. Has no effect on those immune to induced bowel activity."
	taste_description = "indescribably horrible"
	pH = 7.5
	color = "#f8f89b"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/castoroil/reaction_mob(mob/living/M, method=INGEST, reac_volume, show_message = 1) //eating castor oil will give you the grossed out moodlet
	if(iscarbon(M) && M.stat != DEAD)
		if(show_message)
			to_chat(M, "<span class='warning'>That tasted awful!</span>")
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "gross_medicine", /datum/mood_event/gross_medicine)
	..()

/datum/reagent/medicine/castoroil/on_mob_life(mob/living/carbon/M)
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	if(M.client.prefs.accident_types != "Pee Only" && src.volume >= 1)
		M.poop += 1 * src.volume
		M.adjustToxLoss(-1, FALSE)
		for(var/A in M.reagents.reagent_list)
			var/datum/reagent/R = A
			if(R != src)
				M.reagents.remove_reagent(R.type,2)
	..()

// REGRESSION SERUM
/datum/chemical_reaction/medicine/regression
	name = "Regression Serum"
	id = /datum/reagent/medicine/regression
	results = list(/datum/reagent/medicine/regression = 10)
	required_reagents = list(/datum/reagent/medicine/omnizine = 3, /datum/reagent/toxin/carpotoxin = 2, /datum/reagent/ammonia = 5)

/datum/reagent/medicine/regression
	name = "Regression Serum"
	description = "A solution that reduces one to an infantile state of mind."
	taste_description = "childhood whimsy"
	pH = 7.5
	color = "#F034E2"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 51

/datum/reagent/medicine/regression/on_mob_add(mob/living/L)
	if(iscarbon(L) && !(L.client?.prefs.cit_toggles & NEVER_REGRESS))
		var/mob/living/carbon/C = L
		metabolization_rate = 0.1 * REAGENTS_METABOLISM
		if(C.m_intent == MOVE_INTENT_RUN)
			C.toggle_move_intent()
		ADD_TRAIT(C, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
		ADD_TRAIT(C, TRAIT_NORUNNING, REGRESSION_TRAIT)
		ADD_TRAIT(C, TRAIT_NOGUNS, REGRESSION_TRAIT)
		SEND_SIGNAL(C, COMSIG_DIAPERCHANGE, C.ckey)
	return

/datum/reagent/medicine/regression/overdose_process(mob/living/L)
	if(iscarbon(L) && !(L.client?.prefs.cit_toggles & NEVER_REGRESS))
		var/mob/living/carbon/C = L
		metabolization_rate = 0.1 * REAGENTS_METABOLISM
		if(C.m_intent == MOVE_INTENT_RUN)
			C.toggle_move_intent()
		ADD_TRAIT(C, BABYBRAINED_TRAIT, ROUNDSTART_TRAIT)
		ADD_TRAIT(C, TRAIT_NORUNNING, ROUNDSTART_TRAIT)
		ADD_TRAIT(C, TRAIT_NOGUNS, ROUNDSTART_TRAIT)
		SEND_SIGNAL(C, COMSIG_DIAPERCHANGE, C.ckey)
	return

// Maturity Serum
/datum/chemical_reaction/medicine/maturity
	name = "Maturity Serum"
	id = /datum/reagent/medicine/maturity
	results = list(/datum/reagent/medicine/maturity = 2)
	required_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/coffee = 1)

/datum/reagent/medicine/maturity
	name = "Maturity Serum"
	description = "A serum that reverses the effects of Regression Serum overdose."
	taste_description = "coffee and crushing disappointment"
	pH = 7.5
	color = "#504a41"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/medicine/maturity/on_mob_add(mob/living/L)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		L.reagents.remove_reagent(/datum/reagent/medicine/regression,3)
		metabolization_rate = 0.1 * REAGENTS_METABOLISM
		REMOVE_TRAIT(C, BABYBRAINED_TRAIT, ROUNDSTART_TRAIT)
		REMOVE_TRAIT(C, TRAIT_NORUNNING, ROUNDSTART_TRAIT)
		REMOVE_TRAIT(C, TRAIT_NOGUNS, ROUNDSTART_TRAIT)
	return

/datum/reagent/medicine/sodiumpolyacrylate
	name = "Sodium Polyacrylate"
	taste_description = "extreme dryness"
	pH = 7.5
	color = "#bccada"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
