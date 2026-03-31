/mob/living/carbon/human/New()
	..()
	potenzia = (prob(80) ? rand(9, 14) : pick(rand(5, 13), rand(15, 20)))//Interactions
	resistenza = (prob(80) ? rand(150, 300) : pick(rand(10, 100), rand(350,600)))

/mob/living/carbon/human/Topic(href, href_list)
	///////Interactions!!///////
	if(href_list["interaction"])

		if (usr.stat == DEAD || usr.stat == UNCONSCIOUS || usr.restrained())
			return

		//CONDITIONS
		var/mob/living/carbon/human/H = usr
		var/mob/living/carbon/human/P = H.partner
		if (!(P in view(H.loc)))
			return
		var/obj/item/organ/external/temp = H.organs_by_name["r_hand"]
		var/hashands = (temp && temp.is_usable())
		if (!hashands)
			temp = H.organs_by_name["l_hand"]
			hashands = (temp && temp.is_usable())
		temp = P.organs_by_name["r_hand"]
		var/hashands_p = (temp && temp.is_usable())
		if (!hashands_p)
			temp = P.organs_by_name["l_hand"]
			hashands = (temp && temp.is_usable())
		var/mouthfree = !(H.wear_mask)//((H.head && (H.head.flags & HEADCOVERSMOUTH)) || (H.wear_mask && (H.wear_mask.flags & MASKCOVERSMOUTH)))
		var/mouthfree_p = !(P.wear_mask)// ((P.head && (P.head.flags & HEADCOVERSMOUTH)) || (P.wear_mask && (P.wear_mask.flags & MASKCOVERSMOUTH)))
		var/haspenis = H.has_penis()//((H.gender == MALE && H.potenzia > -1 && H.species.genitals))
		var/haspenis_p = P.has_penis()//((P.gender == MALE && P.potenzia > -1  && P.species.genitals))
		var/hasvagina = (H.gender == FEMALE && H.genitals && H.species.name != "Unathi" && H.species.name != "Stok")
		var/hasvagina_p = (P.gender == FEMALE && P.genitals && P.species.name != "Unathi" && P.species.name != "Stok")
		var/hasanus_p = P.anus
		var/isnude = H.is_nude()
		var/isnude_p = P.is_nude()
		var/ya = "&#1103;"


		if (href_list["interaction"] == "bow")
			H.visible_message("<B>[H]</B> bows before <B>[P]</B>.")
			if (istype(P.loc, /obj/structure/closet) && P.loc == H.loc)
				P.visible_message("<B>[H]</B> bows before <B>[P]</B>.")


		else if (href_list["interaction"] == "pet")
			if(((!istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<B>[H]</B> [pick("pets", "pats")] <B>[P]</B>.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> [pick("pets", "pats")] <B>[P]</B>.")

		else if (href_list["interaction"] == "give")
			if(Adjacent(P))
				if (((!istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
					H.give(P)

		else if (href_list["interaction"] == "kiss")
			if((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc) && mouthfree && mouthfree_p)
				if (H.lust == 0)
					H.visible_message("<B>[H]</B> kisses <B>[P]</B>.")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<B>[H]</B> kisses <B>[P]</B>.")
					if (H.lust < 5)
						H.lust = 5
				else
					H.visible_message("<B>[H]</B> kisses <B>[P]</B>.")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<B>[H]</B> kisses <B>[P]</B>.")
			else if (mouthfree)
				H.visible_message("<B>[H]</B> blows <B>[P]</B> a kiss.")

		else if (href_list["interaction"] == "lick")
			if( ((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && mouthfree && mouthfree_p)
				if (H.lust == 0)
					H.visible_message("<B>[H]</B> [H.gender == FEMALE ? "ëèçíóëà" : "ëèçíóë"] <B>[P]</B> â ùåêó.")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<B>[H]</B> [H.gender == FEMALE ? "ëèçíóëà" : "ëèçíóë"] <B>[P]</B> â ùåêó.")
					if (H.lust < 5)
						H.lust = 5
				else
					H.visible_message("<B>[H]</B> îñîáî òùàòåëüíî [H.gender == FEMALE ? "ëèçíóëà" : "ëèçíóë"] <B>[P]</B>.")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<B>[H]</B> îñîáî òùàòåëüíî [H.gender == FEMALE ? "ëèçíóëà" : "ëèçíóë"] <B>[P]</B>.")

		else if (href_list["interaction"] == "hug")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<B>[H]</B> hugs <B>[P]</B>.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> hugs <B>[P]</B>.")
				playsound(loc, 'mods/honkerpanel/sound/interactions/hug.ogg', 50, 1, -1)

		else if (href_list["interaction"] == "cheer")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<B>[H]</B> cheers <B>[P]</B> on.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> cheers <B>[P]</B> on.")

		else if (href_list["interaction"] == "five")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<B>[H]</B> high fives <B>[P]</B>.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> high fives <B>[P]</B>.")
				playsound(loc, 'mods/honkerpanel/sound/interactions/slap.ogg', 50, 1, -1)

		else if (href_list["interaction"] == "handshake")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && hashands_p)
				H.visible_message("<B>[H]</B> shakes <B>[P]</B>'s hand.")
				//if (istype(P.loc, /obj/structure/closet))
				//	P.visible_message("<B>[H]</B> shakes <B>[P]</B>'s hand.")
			else
				H.visible_message("<B>[H]</B> extends [H.gender == MALE ? "his" : "her"] hand to <B>[P]</B>.")
				//if (istype(P.loc, /obj/structure/closet))
				//	P.visible_message("<B>[H]</B> extends [H.gender == MALE ? "his" : "her"] hand to <B>[P]</B>.")

		else if (href_list["interaction"] == "wave")
			if (!(Adjacent(P)) && hashands)
				H.visible_message("<B>[H]</B> waves at <B>[P]</B>.")
			else
				H.visible_message("<B>[H]</B> waves [H.gender == MALE ? "his" : "her"] stump at <B>[P]</B>.")


		else if (href_list["interaction"] == "slap")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<span class='danger'>[H] slaps [P]!</span>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<span class='danger'>[H] slaps [P]!</span>")
				playsound(loc, 'mods/honkerpanel/sound/interactions/slap.ogg', 50, 1, -1)
				H.do_attack_animation(P)

		else if (href_list["interaction"] == "fuckyou")
			if(hashands)
				H.visible_message("<span class='danger'>[H] gives [P] the finger!</span>")
				if (istype(P.loc, /obj/structure/closet) && P.loc == H.loc)
					P.visible_message("<span class='danger'>[H] gives [P] the finger!</span>")

		else if (href_list["interaction"] == "knock")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands)
				H.visible_message("<span class='danger'>[H] knocks [P] upside the head!</span>")//Knocks?("<span class='danger'>[H] äàåò [P] ïîäçàòûëüíèê!</span>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<span class='danger'>[H] knocks [P] upside the head!</span>")
				playsound(loc, 'sound/weapons/throwtap.ogg', 50, 1, -1)
				H.do_attack_animation(P)

		else if (href_list["interaction"] == "spit")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && mouthfree)
				H.visible_message("<span class='danger'>[H] spits at [P]!</span>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<span class='danger'>[H] spits at [P]!</span>")

		else if (href_list["interaction"] == "threaten")
			if(hashands)
				H.visible_message("<span class='danger'>[H] threatens [P] with a fist!</span>")
				if (istype(P.loc, /obj/structure/closet) && H.loc == P.loc)
					P.visible_message("<span class='danger'>[H] threatens [P] with a fist!</span>")

		else if (href_list["interaction"] == "tongue")
			if(mouthfree)
				H.visible_message("<span class='danger'>[H] sticks their tongue out at [P]!</span>")
				if (istype(P.loc, /obj/structure/closet) && H.loc == P.loc)
					P.visible_message("<span class='danger'>[H] sticks their tongue out at [P]</span>")

		else if (href_list["interaction"] == "assslap")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && isnude_p && hasanus_p && hashands)
				H.visible_message("<span class='danger'>[H] slaps [P] right on the ass!</span>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<span class='danger'>[H] slaps [P] right on the ass!</span>")
				playsound(loc, 'mods/honkerpanel/sound/interactions/slap.ogg', 50, 1, -1)

		else if (href_list["interaction"] == "pull")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && hashands && !H.restrained() && P.species.name == "Tajaran")
				if (prob(30))
					H.visible_message("<span class='danger'>[H] ä¸ðãàåò [P] çà õâîñò!</span>")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<span class='danger'>[H] ä¸ðãàåò [P] çà õâîñò!</span>")
				else
					H.visible_message("<B>[H]</B> ïûòàåòñ[ya] ïîéìàòü <B>[P]</B> çà õâîñò!")
					if (istype(P.loc, /obj/structure/closet))
						P.visible_message("<B>[H]</B> ïûòàåòñ[ya] ïîéìàòü <B>[P]</B> çà õâîñò!")

		else if (href_list["interaction"] == "vaglick")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && isnude_p && mouthfree && hasvagina_p)
				H.fuck(H, P, "vaglick")

		else if (href_list["interaction"] == "asslick")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && isnude_p && mouthfree && hasanus_p)
				usr.visible_message("<font color=purple>[H] licks [P]'s asshole.</font>")

		else if (href_list["interaction"] == "fingering")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && isnude_p && hashands && hasvagina_p)
				H.fuck(H, P, "fingering")

		else if (href_list["interaction"] == "blowjob")
			if(((Adjacent(P) && !istype(P.loc, /obj/structure/closet)) || (H.loc == P.loc)) && isnude_p && mouthfree && haspenis_p)
				H.fuck(H, P, "blowjob")

		else if (href_list["interaction"] == "anal")
			if (H.loc == P.loc && isnude_p && isnude && haspenis && hasanus_p)
				if (H.erpcooldown == 0)
					if (H.potenzia > 0)
						H.fuck(H, P, "anal")
				else
					var/message = pick("it's not erect...")//, "Êàê-òî íåò æåëàíè[ya]...", "×òî-òî íå îõîòà...", "Íåò, íå ñåé÷àñ.")
					H << message
		else if (href_list["interaction"] == "vaginal")
			if (H.loc == P.loc && isnude_p && isnude && haspenis && hasanus_p)
				if (H.erpcooldown == 0)
					if (H.potenzia > 0)
						H.fuck(H, P, "vaginal")
				else
					var/message = pick("it's not erect...")//"Íå õî÷åòñ[ya] ìíå...", "Êàê-òî íåò æåëàíè[ya]...", "×òî-òî íå îõîòà...", "Íåò, íå ñåé÷àñ.")
					H << message

		else if (href_list["interaction"] == "oral")
			if (H.loc == P.loc && isnude && mouthfree_p && haspenis)
				if (H.erpcooldown == 0)
					if (H.potenzia > 0)
						H.fuck(H, P, "oral")
				else
					var/message = pick("it's not erect...")//"Íå õî÷åòñ[ya] ìíå...", "Êàê-òî íåò æåëàíè[ya]...", "×òî-òî íå îõîòà...", "Íåò, íå ñåé÷àñ.")
					H << message

		else if (href_list["interaction"] == "mount")
			if (H.loc == P.loc && isnude && isnude_p && haspenis_p && hasvagina)
				if (P.lust <= 0)
					var/message = pick("It's not up...")//"Èíñòðóìåíò íå ïåðåâåäåí â ðàáî÷åå ñîñòî[ya]íèå...", "Ó íåãî åùå íå âñòàë...", "À îí ëåæèò...", "Íèêàê íå íàñàäèòüñ[ya]...")
					H << message
				else if (H.erpcooldown == 0)
					H.fuck(H, P, "mount")
				else
					var/message = pick("You have no lust now.")//"Íå õî÷åòñ[ya] ìíå...", "Êàê-òî íåò æåëàíè[ya]...", "×òî-òî íå îõîòà...", "Íåò, íå ñåé÷àñ.")
					H << message

	..()
	return
