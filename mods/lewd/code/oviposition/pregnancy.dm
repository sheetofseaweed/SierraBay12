/obj/item/organ/internal/lewd/womb/Process()
    ..()
    if(fertilized && owner)
        pregnancy_stage++
        if(pregnancy_stage >= 12) // ~2 minutes at normal tick rate
            owner.lay_eggs()
            pregnancy_stage = 0
            fertilized = FALSE

/mob/living/carbon/human/proc/lay_eggs()
    visible_message("<span class='notice'>[src] lays an egg!</span>")
    new /obj/item/egg_lewd(loc) // placeholder — expand later
