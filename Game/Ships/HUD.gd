extends Control

signal slot_changed(slot_index, weapon_scene)

func set_num_slots(num):
	
	$ShipConfigurer.set_num_slots(num)


func set_ship_basics(data, type):
	match type:
		ENUMS.DATA.SHIP_VELOCITY:
			_set_speed(data)
		ENUMS.DATA.RUDDER_ANGLE:
			_set_rudder_angle(data)
		ENUMS.DATA.SHIP_TILL:
			$Till.set_till(data)
		ENUMS.DATA.TARGET_DISTANCE:
			_set_distance(data)
		ENUMS.DATA.RADAR_ACTIVE, ENUMS.DATA.RADAR_RWR:
			print(type)
			$RadarRing.set_data(data, type)


func _set_distance(dist) -> void:
	if get_viewport().get_camera().is_in_group("guncam"):
		
		var a = dist * CONSTANTS.KM_PER_UNIT
		
		$reticle/range.text = Helper.decimal_place_string(a, 2) + " km"
		
		$reticle/tof.text = "(not fully implemented) " + Helper.decimal_place_string(a / 0.8, 2) + " s" # if shell speed is 800m/s
	else:
		
		$reticle/range.text = ""


func _set_rudder_angle(normalized) -> void:
	$ColorRect/TextureRect.rect_position.x = normalized * $ColorRect.rect_size.x
	$ColorRect/TextureRect.rect_position.x -= $ColorRect/TextureRect.rect_size.x/2.0


func _set_speed(vel : Vector3) -> void:
	vel = -vel
	$Speed.text = Helper.decimal_place_string(vel.z * CONSTANTS.US2KTS / 10.0, 1) + " kts" # scale speed down.


func _on_ShipConfigurer_slot_changed(slot_index, weapon_scene) -> void:
	emit_signal("slot_changed", slot_index, weapon_scene)
