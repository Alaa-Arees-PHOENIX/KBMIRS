;(defrule compatible_style_instruments
;	(user (preferred_music_style ?prefms))
;	(musical_instrument (name ?n) (music_style $? ?prefms $?))
;	=>
;	(assert (choice ?n))
;)

(defrule retract_noncompatible_style
	(user (preferred_music_style ?prefms))
	(not (musical_instrument (name ?n) (music_style $? ?prefms $?)))
	?ins <- (musical_instrument (name ?n))
	=>
	(retract ?ins)
)

;(defrule percussion_acceptance
;	(user (like_percussion_instruments TRUE))
;	(musical_instrument (name ?n) (physical_type percussion))
;	=>
;	(assert(choice ?n))
;)

(defrule retract_noncompatible_percussion
	(user (like_percussion_instruments FALSE))
	(musical_instrument (name ?n) (physical_type percussion))
	?ins <- (musical_instrument (name ?n))
	=>
	(retract ?ins)
)


(defrule retract_noncompatible_budget
	(user (budget ?b))
	?ins <- (musical_instrument (name ?n) (price ?p))
	(test (> ?p ?b))
	=>
	(retract ?ins)
)

(defrule retract_noncompatible_train_time
	(user (expected_time_of_training ?userTrainTime))
	?ins <- (musical_instrument (name ?n) (proficiency_required_time ?instrumentTrainTime))
	(test (> ?instrumentTrainTime ?userTrainTime))
	=>
	(retract ?ins)
)

;(defrule like_wind_instruments 
;	(user (like_wind_instruments TRUE))
;	(musical_instrument (name ?n) (physical_type wind))
;	=>
;	(assert (choice ?n))
;)

(defrule ret_like_wind
	(user (like_wind_instruments FALSE))
	?ins <- (musical_instrument (name ?n) (physical_type wind))
	=>
	(retract ?ins)
)

;(defrule low_lungs_capacity
;	(user (lungs_capacity low))
;	(musical_instrument (name ?n) (with_bellow TRUE))
;	=>
;	(assert (choise ?n))
;)

(defrule retract_noncompatible_lungs_capacity
	(user (lungs_capacity low))
	?ins <- (musical_instrument (name ?n) (physical_type wind) (with_bellow FALSE))
	=>
	(retract ?ins)
)

;(defrule create_harmonies
;	(user (enjoy_creating_harmonies TRUE))
;	(musical_instrument (name ?n) (polyphonic TRUE))
;	=>
;	(assert (choice ?n))
;)

; I think instruments matching this rule are better be added to an alternative list
; of instruments (also recommended but less likely to be accepted by the customer)
; and not fully retract it from the system. <Alaa>
(defrule ret_create_harmonies
	(user (enjoy_creating_harmonies FALSE))
	?ins <- (musical_instrument (name ?n) (polyphonic TRUE))
	=>
	(retract ?ins)
)

;(defrule dont_like_playing_with_group
;	(user (like_to_play_with_group FALSE))
;	(musical_instrument (name ?n)(solo_instrument TRUE))
;	=>
;	(assert (choice ?n))
;)

(defrule dont_like_playing_with_group
	(user (like_to_play_with_group FALSE))
	?ins <- (musical_instrument (name ?n) (solo_instrument FALSE))
	=>
	(retract ?ins)
)

;(defrule travels_alot
;	(user (travels_alot TRUE))
;	(musical_instrument (name ?n) (portable TRUE))
;	=> 
;	(assert (choice ?n))
;)

(defrule travels_alot 
	(user (travels_alot TRUE))
	?ins <- (musical_instrument (name ?n) (portable FALSE))
	=>
	(retract ?ins)
)

(defrule have_complaining_neighbors
	(user (complaining_neighbors TRUE))
	?ins <- (musical_instrument (name ?n) (noisy TRUE))
	=>
	(retract ?ins)
)

; Nina was suggesting in the following rule that we can add an attribute
; to indicate whether an instrument has an electric variant which can reduce
; noise by lowering volume or using headphones, but I (Alaa) suggest that
; instead of this rule we can just define the electric variant of an instrument
; as a new fact or instrument having `(noisy FALSE)`. <Alaa>

;(defrule have_complaining_neighbors2
;           (user (complaining_neighbors TRUE))
;           ?ins <- (musical_instrument (name ?n) (electric TRUE))
;           ?insChoice <- (choice ?n)
;           =>
;           (assert (choice ?n))
;)

