

/mob/proc/texttospeech(var/text)
	var/name2 = ""
	if (!name2 || name2 == "")
		if(!src.ckey || src.ckey == "")
			name2 = "\ref[src]"
		else
			name2 = src.ckey
	spawn(0)
		var/list/voiceslist = list()

		voiceslist["msg"] = text
		voiceslist["ckey"] = name2
		var/params = list2params(voiceslist)

		text2file(params, "tmp/voicequeue[name2].txt")

		shell("Code.exe [name2]")

	spawn(5)
		if(isliving(src) || name2)
			if(src.client?.prefs.cit_toggles & TTS)
				src.playsound_local(src.loc, "tmp/playervoice[name2].wav", 70, max_distance = 7)

		fdel("tmp/voicequeue[name2].txt")

/client/proc/texttospeech(var/text, var/clientkey)
	spawn(0)
		var/list/voiceslist = list()

		voiceslist["msg"] = text
		voiceslist["ckey"] = clientkey
		var/params = list2params(voiceslist)
		params = replacetext(params, "&", "^&")

		call("writevoice.dll", "writevoicetext")(params)
		shell("cmd /C echo [params]>>scripts\\voicequeue.txt")
