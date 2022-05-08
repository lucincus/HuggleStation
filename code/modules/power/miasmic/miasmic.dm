/obj/machinery/power/miasmic
	name = "miasmic generator"
	desc = "A generator that turns methane and other waste gasses into power."
	icon_state = "teg"
	density = TRUE
	use_power = NO_POWER_USE

	var/stinkarea = 0
	var/stinkspent = 0

/obj/machinery/power/miasmic/Initialize(mapload)
	. = ..()
	connect_to_network()
	SSair.atmos_machinery += src

/obj/machinery/power/miasmic/Destroy()
	SSair.atmos_machinery -= src
	return ..()

/obj/machinery/power/miasmic/process()
	var/output = round(stinkarea / 10)
	add_avail(output * 10)
	stinkarea -= output
	stinkspent = output
	for(var/turf/T in RANGE_TURFS(3, src.loc))
		var/datum/gas_mixture/G = T.return_air()
		stinkarea += (((G.get_moles(GAS_DIAPERSMELL) * 2) + G.get_moles(GAS_MIASMA) + G.get_moles(GAS_METHANE)) * 200)
		G.set_moles(GAS_DIAPERSMELL, (G.get_moles(GAS_DIAPERSMELL) * 0.8))
		G.set_moles(GAS_MIASMA, (G.get_moles(GAS_MIASMA) * 0.8))
		G.set_moles(GAS_METHANE, (G.get_moles(GAS_METHANE) * 0.8))
		G.set_temperature(G.return_temperature() + 0.1)
