extends Spatial

var selected_weapon : int = ENUMS.ARM.GUN

#var angular_acceleration = 7
#var _local_target = Vector3()

func set_target_point(point_global):
	for slot in get_children():
		slot.set_global_target(point_global)
	


func _physics_process(delta):
	

	
	# Comment explaining what this is for?
	$Slot2.rotation_degrees.x = 0
	



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("select_torpedo"):
		_select(ENUMS.ARM.TORP)
	
	elif Input.is_action_just_pressed("select_gun"):
		_select(ENUMS.ARM.GUN)
	
	if Input.is_action_just_pressed("fire"):
		_fire(selected_weapon)


func set_slot_weapon(index, weapon_scene):
	var slot = get_child(index)
	slot.change_out_weapon(weapon_scene)


func _select(weapon_enum : int):
	selected_weapon = weapon_enum


# takes type ENUMS.ARM
func _fire(type : int) -> void:
	for slot in get_children():
		if slot.get_contained_type() == type:
			slot.fire()
	
