extends Spatial


var selected_weapon : int = ENUMS.ARM.GUN # start with nothing selected


#var angular_acceleration = 7
var target = Vector3()


const ROTATION_SPEED = 1



func set_target_point(point_global):
	target = point_global


func _physics_process(delta):

	var front = $Slot2.transform.basis.z
	var ang = Vector2(front.x, front.z).angle_to(Vector2(target.x, target.z))

	$Slot2.rotation_degrees.x = 0
	if(rad2deg(ang) <= 179): #Creating a threshold otherwise there is a slight vibration
		$Slot2.rotate_object_local(Vector3(0,1,0), sign(ang) * ROTATION_SPEED * delta)
	
#$Slot1/TurretDouble2.rotation.y = lerp_angle($Slot1/TurretDouble2.rotation.y, atan2(direction.x, direction.y) - rotation.y, delta * angular_acceleration)



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("select_torpedo"):
		_select(ENUMS.ARM.TORP)
	
	elif Input.is_action_just_pressed("select_gun"):
		_select(ENUMS.ARM.GUN)
	
	if Input.is_action_just_pressed("fire"):
		_fire(selected_weapon)


func _select(weapon_enum : int):
	selected_weapon = weapon_enum


# takes type ENUMS.ARM
func _fire(type : int) -> void:
	for slot in get_children():
		if slot.get_contained_type() == type:
			slot.fire()
	
