extends Spatial

# consts at top
const ROTATION_SPEED = 1

var selected_weapon : int = ENUMS.ARM.GUN # start with nothing selected

#var angular_acceleration = 7
var _local_target = Vector3()

func set_target_point(point_global):
	_local_target = point_global - global_transform.origin


func _physics_process(delta):
	
	var front = $Slot2.global_transform.basis.z
	
	var ang = Vector2(front.x, front.z).angle_to(
				Vector2(_local_target.x, _local_target.z)
				)
	
	# Comment explaining what this is for?
	$Slot2.rotation_degrees.x = 0
	
	# Creating a threshold otherwise there is a slight vibration
	if(rad2deg(ang) <= 179): 
		$Slot2.rotate_object_local(
				Vector3(0,1,0), 
				sign(ang) * ROTATION_SPEED * delta
				)


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
	
