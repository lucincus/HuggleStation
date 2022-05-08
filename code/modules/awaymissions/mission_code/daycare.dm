// Daycare Areas

/area/awaymission/daycare
	name = "Abandoned Daycare"
	icon_state = "away"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY

/area/awaymission/daycare/forest
	name = "Spooky Forest"
	icon_state = "away1"

/area/awaymission/daycare/outpost
	name = "Staff Outpost"
	icon_state = "away2"

//objects

/obj/item/paper/pamphlet/daycareCover
	name = "pamphlet - \'New-U Rejuvination\'"
	desc = "A pamphlet welcoming newly enrolled patients to the New-U facility."
	info = "<b>Welcome to the 'New-U'...</b><br>\
			Congratulations! If you're reading this, you have been granted a new chance at life, \
			your consent to treatment is irrelevant. While the crimes you doubtless committed to \
			earn your stay with New-U are non doubt grave or vast our benefactors, a large number of \
			corporations including (but not limited to) NanoTrasen, CyberSun, and WaffleCo have seen \
			fit to spare you death or torture, and released you into our care!<br>\
			<br>Because we care about you, we wish to assure you that no harm will come to you in our \
			state of the art facility. It is our number one goal to rehabilitate you with our advanced, \
			experimental techniques and technology so that you may become a productive and harmless \
			member of society.<br>\
			During your extended stay, until we release you from our care, your every need shall be \
			attended to by our caregivers. You will have a long period of pampering to look forward to, \
			and will no doubt leave our facility looking upon your time here fondly."

/obj/item/paper/fluff/awaymissions/daycare/noentry
	name = "Important Notice"
	info = "Due to unfortunate circumstances, the New-U Rejuvination Center has been shut down indefinitely. This area is now under NanoTrasen authority following New-U's dissolution, and any trespassers will be prosecuted to the fullest extent of SolGov law."

/obj/item/paper/fluff/awaymissions/daycare/laura
	name = "Prisoner's Note"
	info = "I have to keep writing these notes, I feel like they're helping me stay sane throughout this torture.<br>\
			If anyone else finds this, my name isn't important. You can call me 'Kitten' like that asshole does, it's either become true by now or I've put this place far enough behind me not to care anymore.<br>\
			NanoTrasen stuck me in this hell hole as punishment for... what happened... They've messed with my head somehow, I can't even write about the incident without my head feeling like it's going to burst...<br>\
			That's not even mentioning what the monster in charge of this place did to me... I don't think I'll be able to get out of these damn diapers even if I escape.<br>\
			And now, that bastard is trying to regress me, calls it my 'treatment'. He'd probably have succeeded if it weren't for Laura..."

/obj/item/paper/crumpled/awaymissions/daycare/theplan
	name = "A Note From Laura"
	info = "We can finally do it! Jamie's said he's going to be operating on you tonight... alone.<br>\
			He really bought into the whole baby act, he thinks you're harmless as a kitten, hehe... I'm sorry, that was insensitive, wasn't it?<br>\
			Just tell me what you need me to do, your message can go in the usual place! We're finally getting out of here, we're all going to be free from this messed up experiment..."

/obj/item/paper/crumpled/awaymissions/daycare/escape
	name = "A Crumpled-up Note"
	info = "This is it, Laura, we'll finally be free from this hell-hole. When your bastard boss comes to do the surgery, he's going to get a rude awakening.<br>\
			I won't be bringing you along, NanoTrasen will surely come looking for me after the news gets out. Don't worry, though, I can find my own way through the gateway..."

/obj/item/paper/fluff/awaymissions/daycare/ohno
	name = "Laura's Journal - Page 45"
	info = "No no no, it wasn't supposed to go like this... I knew he'd probably kill Jamie, but I was going to smuggle him into the shuttle home-<br>\
			LARS WASN'T SUPPOSED TO DIE TOO<br>\
			This can't be happening! I have to leave <b>now</b>...<br>\
			I don't know what I'm going to do, but... I'm going to <i>punish</i> him for this. Lars, I'm so sorry... I thought this was our best option, but..."

//turfs
/turf/open/water/daycare
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/dirt/daycare
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/closed/mineral/random/labormineral/daycare
	baseturfs = /turf/open/floor/plating/asteroid
	turf_type = /turf/open/floor/plating/asteroid
