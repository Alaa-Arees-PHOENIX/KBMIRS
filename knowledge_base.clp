(defrule compatible_style_instruments
         (user (prefered_muisical_style ?prefms))
	 (musical_instrument (name ?n) (music_style $? ?prefms $?))
         =>
         (assert (choice ?n))
)

(defrule retract_noncompatible_style
	(user (prefered_muisical_style ?prefms))
	(not (musical_instrument (name ?n) (music_style $? ?prefms $?)))
        ;(neq ?prefms ?ms)
	?ins <- (musical_instrument (name ?n))
	?insChoice <- (choice ?n)
	=>
	(retract ?ins)
	(retract ?insChoice)
)

(defrule percussion_acceptance
          (user (like_to_go_with_percussion TRUE))
	  (musical_instrument (name ?n) (physical_type percussion))
          =>
          (assert(choice ?n))
)

(defrule retract_noncompatible_percussion
	(user (like_to_go_with_percussion FALSE))
	(musical_instrument (name ?n) (physical_type percussion))
	?ins <- (musical_instrument (name ?n))
	?insChoice <- (choice ?n)
	=>
	(retract ?ins)
	(retract ?insChoice)
)



(defrule financial_capacity_low
             (user (budget low))
             ?inds <- (musical_instrument (name ?n) (price high|medium))
             ?indsChoice <- (choice ?n)
             =>
             (retract ?inds)
             (retract ?indsChoice)
)
 
            
(defrule financial_capacity_medium
             (user (budget medium))
             ?inds <- (musical_instrument (name ?n) (price high))
             ?indsChoice <- (choice ?n)
             =>
             (retract ?inds)
             (retract ?indsChoice)
)




(defrule  like_wind_instruments 
            (user (like_wind_instruments TRUE))
            (musical_instrument (name ?n) (physical_type wind))
            =>
            (assert (choice ?n))
)

(defrule ret_like_wind
            (user (like_wind_instruments FALSE))
            ?ins <- (musical_instrument (name ?n) (physical_type wind))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)

(defrule low_lungs_capacity
            (user (lungs_capacity low))
            (musical_instrument (name ?n) (with_bellow TRUE))
            =>
            (assert (choise ?n))
)

(defrule ret_low_lungs_capacity
            (user (lungs_capacity low))
            ?ins <- (musical_instrument (name ?n) (with_bellow FALSE))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)

(defrule create_harmonies
            (user (enjoy_creating_harmonies TRUE))
            (musical_instrument (name ?n) (polyphonic TRUE))
            =>
            (assert (choice ?n))
)

(defrule ret_create_harmonies
            (user (enjoy_creating_harmonies FALSE))
            ?ins <- (musical_instrument (name ?n) (polyphonic TRUE))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)
(defrule dont_like_playing_with_group
            (user (like_to_play_with_group FALSE))
            (musical_instrument (name ?n)(solo_instrument TRUE))
            =>
            (assert (choice ?n))
)
(defrule travels_alot
            (user (travels_alot TRUE))
            (musical_instrument (name ?n) (portable TRUE))
            => 
            (assert (choice ?n))
)
(defrule ret_travels_alot 
            (user (travels_alot TRUE))
            ?ins <- (musical_instrument (name ?n) (portable FALSE))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)
(defrule short_expected_years_of_training
            (user (expected_years_of_training short))
            ?ins <- (musical_instrument (name ?n) (minimum_period_for_being_professional long|medium))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)
(defrule medium_expected_years_of_taining
            ?ins <- (musical_instrument (name ?n) (minimum_period_for_being_professional long))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)
(defrule have_complaining_neighbors
            (user (complaining_neighbors TRUE))
            ?ins <- (musical_instrument (name ?n) (noisy TRUE))
            ?insChoice <- (choice ?n)
            =>
            (retract ?ins)
            (retract ?insChoice)
)
;(defrule have_complaining_neighbors2
;           (user (complaining_neighbors TRUE))
;           ?ins <- (musical_instrument (name ?n) (electric TRUE))
;           ?insChoice <- (choice ?n)
;           =>
;           (assert (choice ?n))
;)

