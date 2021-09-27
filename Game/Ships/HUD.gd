extends Control


func set_rudder_angle(normalized) -> void:
	$ColorRect/TextureRect.rect_position.x = normalized * $ColorRect.rect_size.x
	$ColorRect/TextureRect.rect_position.x -= $ColorRect/TextureRect.rect_size.x/2.0


func set_till(till) -> void:
	var word
	match till:
		-1:
			word = "BACK"
		0:
			word = "REST"
		1:
			word = "1/4"
		2:
			word = "2/4"
		3:
			word = "3/4"
		4:
			word = "FULL"
	
	$Till.text = word


func set_speed(vel : Vector3) -> void:
	vel = -vel
	$Speed.text = Helper.decimal_place_string(vel.z * CONSTANTS.US2KTS / 10.0, 1) + " kts" # scale speed down.


func set_distance(dist) -> void:
	if get_viewport().get_camera().is_in_group("guncam"):
		
		var a = dist * CONSTANTS.KM_PER_UNIT
		
		$reticle/range.text = Helper.decimal_place_string(a, 2) + " km"
		
	else:
		
		$reticle/range.text = ""

