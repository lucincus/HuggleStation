/obj/item/seeds/marshmallow
	name = "pack of marshmallow seeds"
	desc = "They're seeds that grow marshmallow root."
	icon_state = "seed-marshmallow"
	species = "marshmallow"
	plantname = "Marshmallow Root"
	product = /obj/item/reagent_containers/food/snacks/grown/marshmallowroot
	lifespan = 35
	maturation = 5
	production = 5
	yield = 4
	endurance = 45
	instability = 5
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/marshmallow/laxative, /obj/item/seeds/marshmallow/marshmerrow)
	reagents_add = list(/datum/reagent/medicine/laxative = 0.01, /datum/reagent/consumable/nutriment/vitamin = 0.06, /datum/reagent/consumable/nutriment = 0.03)

/obj/item/reagent_containers/food/snacks/grown/marshmallowroot
	seed = /obj/item/seeds/marshmallow
	name = "marshmallow root"
	desc = "A root of the marshmallow plant. Can be used to make marshmallows."
	icon_state = "marshroot"
	bitesize_mod = 25
	tastes = list("bitterness" = 1)

/obj/item/seeds/marshmallow/laxative
	name = "pack of marshmallax seeds"
	desc = "They're seeds that grow marshmallax root."
	icon_state = "seed-marshmallax"
	species = "marshmallax"
	plantname = "Marshmallax Root"
	icon_dead = "marshmallow-dead"
	product = /obj/item/reagent_containers/food/snacks/grown/marshmallax
	yield = 2
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/marshmallow)
	reagents_add = list(/datum/reagent/medicine/laxative = 0.1)

/obj/item/reagent_containers/food/snacks/grown/marshmallax
	seed = /obj/item/seeds/marshmallow/laxative
	name = "marshmallax root"
	desc = "A root of the marshmallax plant. Extremely potent laxative."
	icon_state = "marshlax"
	bitesize_mod = 25
	tastes = list("bitterness" = 1)

/datum/food_processor_process/marshmallow
	input = /obj/item/reagent_containers/food/snacks/grown/marshmallowroot
	output = /obj/item/reagent_containers/food/snacks/marshmallow

/obj/item/seeds/marshmallow/marshmerrow
	name = "pack of marshmerrow seeds"
	desc = "They're seeds that grow marshmerrow pulps."
	icon_state = "seed-marshmerrow"
	growthstages = 2
	species = "marshmerrow"
	plantname = "Marshmerrow"
	icon_dead = "marshmerrow-dead"
	product = /obj/item/reagent_containers/food/snacks/grown/marshmerrow
	yield = 1
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/marshmallow)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.06, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/honey = 0.05)

/obj/item/reagent_containers/food/snacks/grown/marshmerrow
	seed = /obj/item/seeds/marshmallow/marshmerrow
	name = "marshmerrow"
	desc = "The sweet pulp of marshmerrow reeds is a delectable foodstuff, and when eaten fresh or prepared, it has modest healing properties."
	icon_state = "marshmer"
	bitesize_mod = 25
	wine_power = 75
	tastes = list("sweetness" = 1)

/obj/item/seeds/diapers
	name = "pack of diaper seeds"
	desc = "They're seeds that grow into diapers. Yes, really. Needs some processing before use."
	icon_state = "seed-diap"
	species = "diap"
	plantname = "Diaper Plant"
	icon_dead = "diap-dead"
	reagents_add = list(/datum/reagent/medicine/regression = 0.01, /datum/reagent/medicine/laxative = 0.02, /datum/reagent/medicine/diuretic = 0.03, /datum/reagent/medicine/sodiumpolyacrylate = 0.05)
	genes = list(/datum/plant_gene/trait/stinging)
	product = /obj/item/reagent_containers/food/snacks/grown/shell/diaper
	yield = 1
	growthstages = 2

/obj/item/reagent_containers/food/snacks/grown/shell/diaper
	seed = /obj/item/seeds/diapers
	name = "thorny diaper"
	desc = "Just remove the thorns and it'll work fine. Do NOT ingest."
	icon = 'icons/incon/diaper.dmi'
	icon_state = "leafy"
	bitesize_mod = 25
	tastes = list("rubbery" = 3)
	trash = /obj/item/diaper/leafy
	bitesize_mod = 2
	foodtype = FRUIT
	wine_power = 1
