/// this is bad code
/mob/living/silicon/robot/update_icons()
	cut_overlays()
	icon_state = module.cyborg_base_icon
	//Citadel changes start here - Allows modules to use different icon files, and allows modules to specify a pixel offset
	icon = (module.cyborg_icon_override ? module.cyborg_icon_override : initial(icon))
	if(laser)
		add_overlay("laser")//Is this even used??? - Yes borg/inventory.dm
	if(disabler)
		add_overlay("disabler")//ditto

	if(sleeper_g && module.sleeper_overlay)
		add_overlay("[module.sleeper_overlay]_g[sleeper_nv ? "_nv" : ""]")
	if(sleeper_r && module.sleeper_overlay)
		add_overlay("[module.sleeper_overlay]_r[sleeper_nv ? "_nv" : ""]")
	if(stat == DEAD && module.has_snowflake_deadsprite)
		icon_state = "[module.cyborg_base_icon]-wreck"

	if(module.cyborg_pixel_offset)
		pixel_x = module.cyborg_pixel_offset
	//End of citadel changes

	if(module.cyborg_base_icon == "robot")
		icon = 'icons/mob/robots.dmi'
		pixel_x = initial(pixel_x)
	if(stat != DEAD && !(IsUnconscious() || IsStun() || IsParalyzed() || low_power_mode)) //Not dead, not stunned.
		if(!eye_lights)
			eye_lights = new()
		if(lamp_enabled || lamp_doom)
			eye_lights.icon_state = "[module.special_light_key ? "[module.special_light_key]":"[module.cyborg_base_icon]"]_l"
			eye_lights.color = lamp_doom? COLOR_RED : lamp_color
			eye_lights.plane = 19 //glowy eyes
		else
			eye_lights.icon_state = "[module.special_light_key ? "[module.special_light_key]":"[module.cyborg_base_icon]"]_e[is_servant_of_ratvar(src) ? "_r" : ""]"
			eye_lights.color = COLOR_WHITE
			eye_lights.plane = -1
		eye_lights.icon = icon
		add_overlay(eye_lights)

	if(opened)
		if(wiresexposed)
			add_overlay("ov-opencover +w")
		else if(cell)
			add_overlay("ov-opencover +c")
		else
			add_overlay("ov-opencover -c")
	if(hat)
		var/mutable_appearance/head_overlay = hat.build_worn_icon(default_layer = 20, default_icon_file = 'icons/mob/clothing/head.dmi', override_state = hat.icon_state)
		head_overlay.pixel_y += hat_offset
		add_overlay(head_overlay)
	update_fire()

	if(client && stat != DEAD && module.dogborg == TRUE)
		if(resting)
			if(sitting)
				icon_state = "[module.cyborg_base_icon]-sit"
			if(bellyup)
				icon_state = "[module.cyborg_base_icon]-bellyup"
			else if(!sitting && !bellyup)
				icon_state = "[module.cyborg_base_icon]-rest"
			cut_overlays()
		else
			icon_state = "[module.cyborg_base_icon]"

	if(incontinent == TRUE)
		var/underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
		var/undie_color
		switch(brand)
			if("plain")
				undie_color = "FFFFFF"
			if("classic")
				undie_color = "66FF66"
			if("thirteen")
				undie_color = "FFFFFF"
			if("swaddles")
				undie_color = "3399CC"
			if("cloth")
				undie_color = "FFFFFF"
			if("hefters_m")
				undie_color = "EEEEFF"
			if("hefters_f")
				undie_color = "FFDDEE"
			if("princess")
				undie_color = "FF99FF"
			if("pwrgame")
				undie_color = "8833FF"
			if("starkist")
				undie_color = "FF9933"
			if("space")
				undie_color = "3366CC"
			if("syndi")
				undie_color = "CC0000"
			if("service")
				undie_color = "999999"
			if("supply")
				undie_color = "DDBB22"
			if("hydro")
				undie_color = "00FF00"
			if("sec")
				undie_color = "111111"
			if("engi")
				undie_color = "FFEE00"
			if("atmos")
				undie_color = "FFEE00"
			if("sci")
				undie_color = "660099"
			if("med")
				undie_color = "4488AA"
			if("miner")
				undie_color = "777777"
			if("miner_thick")
				undie_color = "777777"
			if("jeans")
				undie_color = "587890"
			if("jeans_thick")
				undie_color = "587890"
			if("circuit")
				undie_color = "003300"
			if("pink")
				undie_color = "FFC0CB"
			if("pink_thick")
				undie_color = "FFC0CB"
			if("punk")
				undie_color = "000000"
			if("punk_thick")
				undie_color = "000000"
			if("fish")
				undie_color = "ABCDEF"
			if("SMWind")
				undie_color = "0BDA51"
			if("ratvar")
				undie_color = "B8860B"
			if("narsie")
				undie_color = "3D0000"
			if("ashwalker")
				undie_color = "DAA520"
			if("camo")
				undie_color = "568203"
			if("alien")
				undie_color = "563C5C"
			if("greentext")
				undie_color = "46DA3E"
			if("scalies")
				undie_color = "46DA3E"
			if("blackcat")
				undie_color = "FFFFFF"
			if("goldendog")
				undie_color = "000000"
			if("leafy")
				undie_color = "698B57"
			if("slime")
				undie_color = "83639D"
			if("skunk")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("bee")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("rainbow")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("rainbowse")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("matrix")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("ringading")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("hawaiir")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("hawaiib")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("pumpkin")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
			if("jacko")
				underwear = 'modular_citadel/icons/mob/widerobotpamp.dmi'
		var/mutable_appearance/MA3a = mutable_appearance(underwear, module.cyborg_base_icon, -BODY_TAURTAIL_LAYER, color = "#[undie_color]")
		if (stat != DEAD)
			if(resting)
				if(sitting)
					MA3a.icon_state = "[module.cyborg_base_icon]" + "_sit"
				if(bellyup)
					MA3a.icon_state = "[module.cyborg_base_icon]" + "_belly"
				else if(!sitting && !bellyup)
					MA3a.icon_state = "[module.cyborg_base_icon]" + "_rest"
			overlays.Add(MA3a)

	SEND_SIGNAL(src, COMSIG_ROBOT_UPDATE_ICONS)
