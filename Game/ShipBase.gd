extends RigidBody

signal HUD_data_changed(data, type)

func _physics_process(delta) -> void:
	
	if Input.is_action_just_pressed("back"):
		$Propulsion.till_decrease()
	elif Input.is_action_just_pressed("forward"):
		$Propulsion.till_increase()
	
	if Input.is_action_pressed("left"):
		$Propulsion.set_rudder_key_state(-1)
	elif Input.is_action_pressed("right"):
		$Propulsion.set_rudder_key_state(1)
	else:
		$Propulsion.set_rudder_key_state(0)


func _on_HUD_data_changed(data, type) -> void:
	emit_signal("HUD_data_changed", data, type)
