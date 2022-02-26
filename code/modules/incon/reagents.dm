// DIURETICS
/datum/chemical_reaction/medicine/diuretic
	results = list(/datum/reagent/medicine/diuretic = 10)
	required_reagents = list(/datum/reagent/sulfur = 2, /datum/reagent/water = 1, /datum/reagent/consumable/sugar = 1)

/datum/reagent/medicine/diuretic
	name = "Space Diuretics"
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
	if(prob(50))
		M.Wetting()
	..()
	. = 1

// LAXATIVES
/datum/chemical_reaction/medicine/laxative
	results = list(/datum/reagent/medicine/laxative = 10)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/phenol = 3, /datum/reagent/nitrogen = 1, /datum/reagent/consumable/ethanol = 4)

/datum/reagent/medicine/laxative
	name = "Space Lax"
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
	if(L && prob(33))
		L.applyOrganDamage(1)
	if(prob(33))
		M.Pooping()
	..()
	. = 1

// REGRESSION SERUM
/datum/chemical_reaction/medicine/regression
	results = list(/datum/reagent/medicine/regression = 10)
	required_reagents = list(/datum/reagent/medicine/omnizine = 3, /datum/reagent/toxin/carpotoxin = 2, /datum/reagent/ammonia = 5)

/datum/reagent/medicine/regression
	name = "Regression Serum"
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

/datum/reagent/medicine/sodiumpolyacrylate
	name = "Sodium Polyacrylate"
	taste_description = "extreme dryness"
	pH = 7.5
	color = "#bccada"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
