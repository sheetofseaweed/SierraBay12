/mob/living/carbon/human/verb/lewd_kiss(mob/living/carbon/human/target in view(1))
    set name = "Lewd Kiss"
    set category = "Leud"
    set desc = "Kiss someone lewdly."

    if(target && !target.isSynthetic())
        src.arousal = min(src.arousal + 25, AROUSAL_MAX)
        target.arousal = min(target.arousal + 25, AROUSAL_MAX)
        visible_message("<span class='notice'>[src] kisses [target] passionately!</span>")
