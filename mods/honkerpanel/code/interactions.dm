/**********************************
*******Interactions code by HONKERTRON feat TestUnit with translations and code edits by Matt********
**Contains a lot ammount of ERP and MEHANOYEBLYA**
***********************************/

/mob/living/carbon/human/MouseDrop_T(mob/M as mob, mob/user as mob)
	if(M == src || src == usr || M != usr)		return
	if(usr.restrained())		return

	var/mob/living/carbon/human/H = usr
	H.partner = src
	make_interaction(machine)

/mob/proc/make_interaction()
	return

/mob/living/carbon/human/proc/has_penis()
	if(gender == MALE && potenzia > -1 && genitals && !mutilated_genitals)
		return 1
	else return 0

/mob/living/carbon/human/proc/is_nude()
	return (!w_uniform) ? 1 : 0

/mob/living/carbon/human/make_interaction()
	set_machine(src)

	var/mob/living/carbon/human/H = usr
	var/mob/living/carbon/human/P = H.partner
	var/obj/item/organ/external/temp = H.organs_by_name[BP_R_HAND]
	var/hashands = (temp && temp.is_usable())
	if (!hashands)
		temp = H.organs_by_name[BP_L_HAND]
		hashands = (temp && temp.is_usable())
	temp = P.organs_by_name[BP_R_HAND]
	var/hashands_p = (temp && temp.is_usable())
	if (!hashands_p)
		temp = P.organs_by_name[BP_L_HAND]
		hashands = (temp && temp.is_usable())
	var/mouthfree = !(H.wear_mask)
	var/mouthfree_p = !(P.wear_mask)
	var/haspenis = H.has_penis()
	var/haspenis_p = P.has_penis()
	var/hasvagina = (H.gender == FEMALE && H.genitals)
	var/hasvagina_p = (P.gender == FEMALE && P.genitals)
	var/hasanus_p = P.anus
	var/isnude = H.is_nude()
	var/isnude_p = P.is_nude()

	H.lastfucked = null
	H.lfhole = ""

	var/dat = "<B><HR><FONT size=3>INTERACTIONS - [H.partner]</FONT></B><BR><HR>"
	if (hashands)
		dat +=  {"<font size=3><B>Hands:</B></font><BR>"}
		if (Adjacent(P))
			if (isnude_p)
				if (hasvagina_p && (!P.mutilated_genitals))
					dat += {"<A href='?src=\ref[usr];interaction=fingering'>Put fingers in places...</A><BR>"}
	if (mouthfree && (lying == P.lying || !lying))
		dat += {"<font size=3><B>Mouth:</B></font><BR>"}
		dat += {"<A href='?src=\ref[usr];interaction=kiss'>Kiss.</A><BR>"}
		if (Adjacent(P))
			if (isnude_p && (!P.mutilated_genitals))
				if (haspenis_p)
					dat += {"<A href='?src=\ref[usr];interaction=blowjob'><font color=purple>Give head.</font></A><BR>"}
				if (hasvagina_p)
					dat += {"<A href='?src=\ref[usr];interaction=vaglick'><font color=purple>Lick pussy.</font></A><BR>"}
	if (isnude && usr.loc == H.partner.loc)
		if (haspenis && hashands)
			dat += {"<font size=3><B>ERP:</B></font><BR>"}
			if (isnude_p)
				if (hasvagina_p && (!P.mutilated_genitals))
					dat += {"<A href='?src=\ref[usr];interaction=vaginal'><font color=purple>Fuck vagina.</font></A><BR>"}
				if (hasanus_p)
					dat += {"<A href='?src=\ref[usr];interaction=anal'><font color=purple>Fuck ass.</font></A><BR>"}
				if (mouthfree_p)
					dat += {"<A href='?src=\ref[usr];interaction=oral'><font color=purple>Fuck mouth.</font></A><BR>"}
	if (isnude && usr.loc == H.partner.loc && hashands)
		if (hasvagina && haspenis_p && (!H.mutilated_genitals))
			dat += {"<font size=3><B>Vagina:</B></font><BR>"}
			dat += {"<A href='?src=\ref[usr];interaction=mount'><font color=purple>Mount!</font></A><BR><HR>"}

	var/datum/browser/popup = new(usr, "interactions", "Interactions", 340, 480)
	popup.set_content(dat)
	popup.open()

//INTERACTIONS
/mob/living/carbon/human
	var/genitals = 1
	var/anus = 1
	var/mob/living/carbon/human/partner
	var/mob/living/carbon/human/lastfucked
	var/lfhole
	var/potenzia = 10
	var/resistenza = 200
	var/lust = 0
	var/erpcooldown = 0
	var/multiorgasms = 0
	var/lastmoan
	var/mutilated_genitals = 0 //Whether or not they can do the fug.

mob/living/carbon/human/proc/cum(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole = "floor")
	var/message = ""
	var/turf/T

	if (H.gender == MALE)
		var/datum/reagent/blood/source = H.get_blood(H.vessel)
		if (P)
			T = get_turf(P)
		else
			T = get_turf(H)
		if (H.multiorgasms < H.potenzia)
			var/obj/effect/decal/cleanable/cum/C = new(T)
			// Update cum information.
			C.blood_DNA = list()
			if(source.data["blood_type"])
				C.blood_DNA[source.data["blood_DNA"]] = source.data["blood_type"]
			else
				C.blood_DNA[source.data["blood_DNA"]] = "O+"

		if (H.genitals)
			if (hole == "mouth" || H.zone_sel.selecting == "mouth")
				message = pick("cums right in [P]'s mouth.")
				var/datum/reagents/holder = new
				var/amt = rand(20,30)
				holder.add_reagent("semen", amt)
				holder.trans_to_mob(P, amt, CHEM_INGEST)

			else if (hole == "vagina")
				message = pick("cums in [P]'s pussy")

			else if (hole == "anus")
				message = pick("cums in [P]'s asshole.")
			else if (hole == "floor")
				message = "cums on the floor!"

		else
			message = pick("cums!", "orgams!")

		playsound(loc, "mods/honkerpanel/sound/interactions/final_m[rand(1, 5)].ogg", 70, 1, 0)

		H.visible_message("<B>[H] [message]</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message]</B>")
		H.lust = 5
		H.resistenza += 50

	else
		message = pick("cums!")
		H.visible_message("<B>[H] [message].</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message].</B>")
		playsound(loc, "mods/honkerpanel/sound/interactions/final_f[rand(1, 3)].ogg", 90, 1, 0)
		var/delta = pick(20, 30, 40, 50)
		src.lust -= delta

	H.druggy = 60
	H.multiorgasms += 1
	H.erpcooldown = rand(200, 450)
	H.druggy = 300
	H.erpcooldown = 600

mob/living/carbon/human/proc/fuck(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole)
	var/message = ""
	switch(hole)

		if("vaglick")

			message = pick("licks [P].", "sucks [P]'s pussy.")

			if (H.lastfucked != P || H.lfhole != hole)
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 10
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 10
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.sexmoan()
			H.do_fucking_animation(P)

		if("fingering")

			message = pick("fingers [P].", "fingers [P]'s pussy.")
			if (prob(35))
				message = pick("fingers [P] hard.")
			if (H.lastfucked != P || H.lfhole != hole)
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 8
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 8
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.sexmoan()
			playsound(loc, "mods/honkerpanel/sound/interactions/champ_fingering.ogg", 50, 1, -1)
			H.do_fucking_animation(P)

		if("blowjob")
			message = pick("sucks [P]'s dick.", "gives [P] head.")
			if (prob(35))
				message = pick("sucks [P] off.")
			if (H.lust < 6)
				H.lust += 6
			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 10
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 10
				if (P.lust >= P.resistenza)
					P.cum(P, H, "mouth")
			playsound(loc, "mods/honkerpanel/sound/interactions/bj[rand(1, 11)].ogg", 50, 1, -1)
			H.do_fucking_animation(P)
			if (prob(P.potenzia))
				H.visible_message("<B>[H]</B> goes in deep on <B>[P]</B>.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> goes in deep on <B>[P]</B>.")

		if("vaginal")
			message = pick("fucks [P].",)
			if (prob(35))
				message = pick("pounds [P]'s pussy.")

			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick into [P]'s pussy.")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += H.potenzia * 2
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 10
			if (H.lust >= H.resistenza)
				H.cum(H, P, "vagina")

			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += H.potenzia * 0.5
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.sexmoan()
			H.do_fucking_animation(P)
			playsound(loc, "mods/honkerpanel/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

		if("anal")

			message = pick("fucks [P]'s ass.")
			if (prob(35))
				message = pick("fucks [P]'s ass.")

			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick into [P]'s asshole.")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += H.potenzia * 2
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 12
			if (H.lust >= H.resistenza)
				H.cum(H, P, "anus")

			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				if (H.potenzia > 13)
					P.lust += H.potenzia * 0.25
				else
					P.lust += H.potenzia * 0.75
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.sexmoan()
			H.do_fucking_animation(P)
			playsound(loc, "mods/honkerpanel/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

		if("oral")
			message = pick("fucks [P]'s throat.")
			if (prob(35))
				message = pick(" sucks [P]'s [P.gender == FEMALE ? "vag" : "dick"]..", " licks [P]'s [P.gender == FEMALE ? "vag" : "dick"]..")
			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick down [P]'s throat.")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && H.stat != DEAD)
				H.visible_message("<font color=purple><B>[H][message]</B></font>")
				H.lust += 15
			else
				H.visible_message("<font color=purple>[H][message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H][message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 15
			if (H.lust >= H.resistenza)
				H.cum(H, P, "mouth")

			H.do_fucking_animation(P)
			playsound(loc, "mods/honkerpanel/sound/interactions/oral[rand(1, 2)].ogg", 70, 1, -1)
			if (P.species.name == "Slime People")
				playsound(loc, "mods/honkerpanel/sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)
			if (prob(H.potenzia))
				H.visible_message("<B>[H] fucks [P]'s mouth.</B>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H] fucks [P]'s mouth.</B>")


		if("mount")
			message = pick("fucks [P]'s dick", "rides [P]'s dick", "rides [P]")
			if (H.lastfucked != P || H.lfhole != hole)
				message = pick("begins to hop on [P]'s dick")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message].</B></font>")
				P.lust += H.potenzia * 2
			else
				H.visible_message("<font color=purple>[H] [message].</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message].</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += P.potenzia
			if (H.lust >= H.resistenza)
				H.cum(H, P)
			else
				H.sexmoan()
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += H.potenzia
				if (P.lust >= P.resistenza)
					P.cum(P, H, "vagina")
				else
					P.sexmoan()
			H.do_fucking_animation(P)
			playsound(loc, "mods/honkerpanel/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
			if (H.species.name == "Slime People")
				playsound(loc, "mods/honkerpanel/sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)

mob/living/carbon/human/proc/sexmoan()

	var/mob/living/carbon/human/H = src
	switch(species.name)
		if ("Human")
			if (prob(H.lust / H.resistenza * 65))
				var/message = pick("moans", "moans in pleasure",)
				H.visible_message("<B>[H]</B> [message].")
				var/g = H.gender == FEMALE ? "f" : "m"
				var/sexmoan = rand(1, 7)
				if (sexmoan == lastmoan)
					sexmoan--
				if(!istype(loc, /obj/structure/closet))
					playsound(loc, "mods/honkerpanel/sound/interactions/moan_[g][sexmoan].ogg", 70, 1, 1)
				else if (g == "f")
					playsound(loc, "mods/honkerpanel/sound/interactions/under_moan_f[rand(1, 4)].ogg", 70, 1, 1)
				lastmoan = sexmoan


/mob/living/carbon/human/proc/handle_lust()
	lust -= 4
	if (lust <= 0)
		lust = 0
		lastfucked = null
		lfhole = ""
		multiorgasms = 0
	if (lust == 0)
		erpcooldown -= 1
	if (erpcooldown < 0)
		erpcooldown = 0

/mob/living/carbon/human/proc/do_fucking_animation(mob/living/carbon/human/P)
	var/pixel_x_diff = 0
	var/pixel_y_diff = 0
	var/final_pixel_y = initial(pixel_y)

	var/direction = get_dir(src, P)
	if(direction & NORTH)
		pixel_y_diff = 8
	else if(direction & SOUTH)
		pixel_y_diff = -8

	if(direction & EAST)
		pixel_x_diff = 8
	else if(direction & WEST)
		pixel_x_diff = -8

	if(pixel_x_diff == 0 && pixel_y_diff == 0)
		pixel_x_diff = rand(-3,3)
		pixel_y_diff = rand(-3,3)
		animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
		animate(pixel_x = initial(pixel_x), pixel_y = initial(pixel_y), time = 2)
		return

	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
	animate(pixel_x = initial(pixel_x), pixel_y = final_pixel_y, time = 2)
