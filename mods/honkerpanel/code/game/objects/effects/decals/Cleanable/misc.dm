/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "It's pie cream from a cream pie. Or not..."
	density = 0
	layer = 2
	icon = 'mods/honkerpanel/icons/effects/cum.dmi'
	icon_state = "cum1"
	blood_DNA = list()
	anchored = 1

/obj/effect/decal/cleanable/cum/New()
	..()
	icon_state = pick("cum1", "cum3", "cum4", "cum5", "cum6", "cum7", "cum8", "cum9", "cum10", "cum11", "cum12")
	for(var/obj/effect/decal/cleanable/cum/jizz in src.loc)
		if(jizz != src)
			qdel(jizz)
