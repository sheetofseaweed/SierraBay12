/mob/living/carbon/human
    var/arousal = 0
    var/horny_level = 0 // 0 = normal, 1 = mildly horny, 2 = very horny

/mob/living/carbon/human/Life()
    . = ..()
    if(stat != DEAD && !isSynthetic())
        handle_arousal()

/mob/living/carbon/human/proc/handle_arousal()
    var/gain = 0.25

    for(var/obj/item/organ/internal/lewd/O in internal_organs)
        if(!O || (O.status & ORGAN_CUT_AWAY))
            continue
        gain += O.arousal_contribution

    arousal = clamp(arousal + gain, 0, AROUSAL_MAX)

    if(arousal >= AROUSAL_HIGH)
        horny_level = 2
    else if(arousal >= AROUSAL_MED)
        horny_level = 1
    else
        horny_level = 0

/obj/item/organ/internal/lewd
    name = "lewd organ base"
    icon = 'mods/lewd/icons/lewd_organs.dmi'
    parent_organ = BP_GROIN
    var/arousal_contribution = 0.3
    var/fluid_amount = 0
    var/fluid_max = 100
    var/fluid_type = "cum"

/obj/item/organ/internal/lewd/Process()
    ..()
    if(owner && owner.arousal > 15 && fluid_amount < fluid_max)
        fluid_amount += 0.6
