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
	
	$Till.text = "Till " + word


func set_speed(vel : Vector3) -> void:
	vel = -vel
	$Speed.text = str(vel.z) + " kts"


func set_distance(dist) -> void:
	if "guncam" in get_viewport().get_camera():
		var a = dist * CONSTANTS.DISTANCE_SCALE
		
		# formatting to have 2 decimal places
		a = str(a)
		var array = a.split('.',false)
		var string = array[0] + '.' + array[1].substr(0,2)
		
		$reticle/range.text = string + " km"
	else:
		$reticle/range.text = ""
