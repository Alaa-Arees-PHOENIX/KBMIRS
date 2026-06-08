(deftemplate user
	(slot name)
	(slot preferred_music_style (type SYMBOL) (allowed-symbols classic jazz rock blues folk))
	(slot like_wind_instruments (type SYMBOL) (allowed-symbols TRUE FALSE))
	(slot like_percussion_instruments (type SYMBOL) (allowed-symbols TRUE FALSE))
	(slot lungs_capacity (type SYMBOL) (allowed-symbols low high))
	(slot travels_alot (type SYMBOL) (allowed-symbols TRUE FALSE))
	(slot complaining_neighbors (type SYMBOL) (allowed-symbols TRUE FALSE))
	(slot like_to_play_with_group (type SYMBOL) (allowed-symbols TRUE FALSE))
	(slot enjoy_creating_harmonies (type SYMBOL) (allowed-symbols TRUE FALSE))

	; price: 0->low, 1->medium, 2->high
	(slot budget (type INTEGER) (allowed-integers 0 1 2))

	; expected_time_of_training: 0->short, 1->medium, 2->long
	(slot expected_time_of_training (type INTEGER) (allowed-integers 0 1 2))
)

; Adding some users for quick testing
(deffacts users
	(user
		(name "Nina")
		(budget 1)
		(preferred_music_style classic)
        	(like_wind_instruments TRUE)
		(like_percussion_instruments FALSE)
		(travels_alot TRUE)
		(complaining_neighbors TRUE)
		(lungs_capacity high)
		(like_to_play_with_group TRUE)
		(expected_time_of_training 2)
		(enjoy_creating_harmonies TRUE)
	)
)
