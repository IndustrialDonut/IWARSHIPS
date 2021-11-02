extends Spatial


var selected_weapon : int = -1 # start with nothing selected

#var angular_acceleration = 7
var target = Vector3()


const ROTATION_SPEED = 1

func set_distance(dist) -> void:
	pass
	#$Guns.set_distance(dist)

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
	
	if Input.is_action_just_pressed("fire"):
		_fire()
	
	
	# ROTATE TORP LAUNCHER TO AIM POINT
#	var cam = get_viewport().get_camera()
#	var cam_forward = - cam.global_transform.basis.z * 1000 
#	cam_forward.y = 0
#	cam_forward += global_transform.origin
#
#	var rot_dir = (-$Torps.global_transform.basis.z).cross(cam_forward)
#	rot_dir = rot_dir.y
#	if is_zero_approx(rot_dir):
#		pass
#	elif rot_dir > 0:
#		$Torps.rotate(Vector3.UP, delta * 2)
#	else:
#		$Torps.rotate(- Vector3.UP, delta * 2)
	

func _select(weapon_enum : int):
	selected_weapon = weapon_enum


func _fire() -> void:
	
	if selected_weapon == ENUMS.ARM.TORP:
		for child in get_children():
			if child.contained == ENUMS.ARM.TORP:
				child.fire()

	else:
		for child in get_children():
			if child.contained == ENUMS.ARM.GUN:
				child.fire()

