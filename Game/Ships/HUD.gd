extends Control


func set_basics(data, type):
	match type:
		ENUMS.DATA.SHIP_VELOCITY:
			_set_speed(data)
		ENUMS.DATA.RUDDER_ANGLE:
			_set_rudder_angle(data)
		ENUMS.DATA.SHIP_TILL:
			_set_till(data)


func set_distance(dist) -> void:
	if get_viewport().get_camera().is_in_group("guncam"):
		
		var a = dist * CONSTANTS.KM_PER_UNIT
		
		$reticle/range.text = Helper.decimal_place_string(a, 2) + " km"
		
	else:
		
		$reticle/range.text = ""


func _set_rudder_angle(normalized) -> void:
	$ColorRect/TextureRect.rect_position.x = normalized * $ColorRect.rect_size.x
	$ColorRect/TextureRect.rect_position.x -= $ColorRect/TextureRect.rect_size.x/2.0


func _set_till(till) -> void:
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
	
	$Till.text = word


func _set_speed(vel : Vector3) -> void:
	vel = -vel
	$Speed.text = Helper.decimal_place_string(vel.z * CONSTANTS.US2KTS / 10.0, 1) + " kts" # scale speed down.

