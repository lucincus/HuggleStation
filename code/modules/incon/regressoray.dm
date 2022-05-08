/obj/item/gun/energy/regressoray
	name = "regression ray"
	desc = "A ray-gun that temporarily mentally regresses the target, leaving them baby-brained for a bit."
	icon = 'icons/incon/regressoray.dmi'
	icon_state = "regression_ray"
	ammo_type = list(/obj/item/ammo_casing/energy/regression)
	ammo_x_offset = 1
	selfcharge = 1
	item_flags = NONE

/obj/item/gun/energy/regressoray/suicide_act(mob/living/carbon/user)
	if (istype(user) && can_shoot() && can_trigger_gun(user) && user.get_bodypart(BODY_ZONE_HEAD))
		user.visible_message("<span class='suicide'>[user] is putting the barrel of the [src] in their mouth. It looks like [p_theyre()] trying to commit suicide...?!</span>")
		sleep(10)
		user.visible_message("<span class='suicide'>[user] fired the [src] upon [p_them()]selves! It looks like [p_they()] decided not to think, and just stink.</span>")
		if(user.m_intent == MOVE_INTENT_RUN)
			user.toggle_move_intent()
		ADD_TRAIT(user, BABYBRAINED_TRAIT, ROUNDSTART_TRAIT)
		ADD_TRAIT(user, TRAIT_NORUNNING, ROUNDSTART_TRAIT)
		ADD_TRAIT(user, TRAIT_NOGUNS, ROUNDSTART_TRAIT)
		SEND_SIGNAL(user, COMSIG_DIAPERCHANGE, user.ckey)

/obj/item/ammo_casing/energy/regression
	fire_sound = 'sound/effects/stealthoff.ogg'
	harmful = FALSE
	projectile_type = /obj/item/projectile/energy/regression

/obj/item/projectile/energy/regression
	name = "psi-chronoray"
	icon_state = "energy2"
	damage = 0
	damage_type = TOX
	nodamage = TRUE
	flag = "energy"

/obj/item/projectile/energy/regression/on_hit(mob/living/carbon/target, blocked = FALSE)
	. = ..()
	if(isliving(target) && (!target.mind.antag_datums) && !HAS_TRAIT(target, TRAIT_MINDSHIELD) && !(target.client?.prefs.cit_toggles & NEVER_REGRESS))
		if(target.regressiontimer <= 0)
			if(target.m_intent == MOVE_INTENT_RUN)
				target.toggle_move_intent()
			ADD_TRAIT(target, BABYBRAINED_TRAIT, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NORUNNING, REGRESSION_TRAIT)
			ADD_TRAIT(target, TRAIT_NOGUNS, REGRESSION_TRAIT)
			SEND_SIGNAL(target, COMSIG_DIAPERCHANGE, target.ckey)
		target.regressiontimer = 6000

/obj/item/gun/energy/regressoray/station
	name = "regression ray"
	desc = "A ray-gun that temporarily mentally regresses the target, leaving them baby-brained for a bit."
	ammo_type = list(/obj/item/ammo_casing/energy/regression)
	ammo_x_offset = 1
	selfcharge = 0
	item_flags = NONE
	pin = null

/obj/item/gun/energy/carbygun
	name = "carbuncle gun"
	desc = "A gun made for problems you just wanna throw carbuncles at, fashioned to look like a grimoire."
	icon = 'icons/obj/library.dmi'
	icon_state ="bookcarby"
	ammo_type = list(/obj/item/ammo_casing/energy/carby)
	ammo_x_offset = 1
	selfcharge = 1
	item_flags = NONE

/obj/item/ammo_casing/energy/carby
	fire_sound = 'sound/machines/click.ogg'
	harmful = FALSE
	projectile_type = /obj/item/toy/plush/carby
