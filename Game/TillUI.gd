extends Label


func set_till(till) -> void:
	var word
	match till:
		ENUMS.SHIP_TILL.BACK:
			word = "BACK"
		ENUMS.SHIP_TILL.REST:
			word = "REST"
		ENUMS.SHIP_TILL.QUARTER:
			word = "1/4"
		ENUMS.SHIP_TILL.HALF:
			word = "2/4"
		ENUMS.SHIP_TILL.THREE_Q:
			word = "3/4"
		ENUMS.SHIP_TILL.FULL:
			word = "FULL"
	
	text = word
