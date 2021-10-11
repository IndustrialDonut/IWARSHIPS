extends Spatial


var selected_weapon : int = -1 # start with nothing selected


func set_distance(dist) -> void:
	$Guns.set_distance(dist)


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("select_torpedo"):
		_select(CONSTANTS.ARM.TORP)
	
	if Input.is_action_just_pressed("fire"):
		_fire()
	
	
	# ROTATE TORP LAUNCHER TO AIM POINT
	var cam = get_viewport().get_camera()
	var cam_forward = - cam.global_transform.basis.z * 1000 
	cam_forward.y = 0
	cam_forward += global_transform.origin
	
	var rot_dir = (-$Torps.global_transform.basis.z).cross(cam_forward)
	rot_dir = rot_dir.y
	if is_zero_approx(rot_dir):
		pass
	elif rot_dir > 0:
		$Torps.rotate(Vector3.UP, delta * 2)
	else:
		$Torps.rotate(- Vector3.UP, delta * 2)
	

func _select(weapon_enum : int):
	selected_weapon = weapon_enum


func _fire() -> void:
	
	if selected_weapon == CONSTANTS.ARM.TORP:
		$Torps.fire()

	else:
		$Guns.fire()

