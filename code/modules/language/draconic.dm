/datum/language/draconic
	name = "Draconic"
	desc = "The common language of lizard-people, composed of sibilant hisses and rattles."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	key = "o"
	flags = TONGUELESS_SPEECH
	space_chance = 40
	syllables = list(
		"za", "az", "ze", "ez", "zi", "iz", "zo", "oz", "zu", "uz", "zs", "sz",
		"ha", "ah", "he", "eh", "hi", "ih", "ho", "oh", "hu", "uh", "hs", "sh",
		"la", "al", "le", "el", "li", "il", "lo", "ol", "lu", "ul", "ls", "sl",
		"ka", "ak", "ke", "ek", "ki", "ik", "ko", "ok", "ku", "uk", "ks", "sk",
		"sa", "as", "se", "es", "si", "is", "so", "os", "su", "us", "ss", "ss",
		"ra", "ar", "re", "er", "ri", "ir", "ro", "or", "ru", "ur", "rs", "sr",
		"a",  "a",  "e",  "e",  "i",  "i",  "o",  "o",  "u",  "u",  "s",  "s"
	)
	icon_state = "lizard"
	default_priority = 90
	chooseable_roundstart = TRUE

/datum/language/draconic/yipyak
	name = "Yipyak"
	desc = "A dialect of Draconic that is spoken by kobolds. Roughly equivalent to having a southern drawl."
	key = "Y"
	syllables = list(
		"ya","yaz","ye","yez","yi","yiz","yo","yoz","yu","yuz","ys","yz",
		"yah","yeh","yih","yoh","yuh","ysh","yal","yel","yil","yol","yul",
		"ysl","yak","yark","yap","yek","yik","yip","yok","yuk","ysk","yas","yes",
		"yis","yos","yus","yss","yar","yer","yir","yor","yur","yrs","ysr"
	)
