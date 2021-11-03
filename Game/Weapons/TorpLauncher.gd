extends Spatial

const ROTATION_SPEED = deg2rad(40) # deg/s

const TYPE : int = ENUMS.ARM.TORP

var torp_salvo_size = 3

var _salvo_counter = 0


func fire():
	_launch_torp()
	_salvo_counter += 1
	$Salvo.start()


func _launch_torp() -> void:
	var torp = preload("res://Weapons/Torpedo_0.tscn").instance()
	add_child(torp)
	torp.setup(global_transform)


func _on_Salvo_timeout() -> void:
	if _salvo_counter < torp_salvo_size:
		_launch_torp()
		_salvo_counter += 1
	else:
		_salvo_counter = 0
		$Salvo.stop()
