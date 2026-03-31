// Simple Bay12-friendly horny AI for hostile mobs (expand as needed)
/mob/living/simple_animal/hostile
    var/horny = FALSE

/mob/living/simple_animal/hostile/Life(mob/living/target)
    . = ..()
    if(target && ishuman(target))
        var/mob/living/carbon/human/H = target
        if(H.horny_level >= 1)
            horny = TRUE
            // Add approach/attack logic here if you want mobs to initiate lewd interactions
