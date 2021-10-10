extends Spatial

#func _process(delta: float) -> void:
#	for turret in $ShipBase/Hull/TurretContainer.get_children():
#		if $ShipBase.targeted_location != Vector3.ZERO:
#			turret.look_at(Vector3.UP, $ShipBase.targeted_location)


export(NodePath) onready var shipbase = get_node(shipbase)

var selected_weapon : int = -1 # start with nothing selected

var muzzle_velocity = 800 # strictly the horizontal velocity, in m/s
var _muzzle_velocity = muzzle_velocity * CONSTANTS.UNITS_PER_METER

var torp_salvo_size = 3

var _salvo_counter = 0


func _process(delta: float) -> void:
	
	global_transform.origin = shipbase.global_transform.origin
	
	if Input.is_action_just_pressed("select_torpedo"):
		_select(CONSTANTS.ARM.TORP)

	if Input.is_action_just_pressed("fire"):
		_fire()
	
	var cam = get_viewport().get_camera()
	var cam_forward = - cam.global_transform.basis.z * 1000 
	cam_forward.y = 0
	cam_forward += $Torps.global_transform.origin
	
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
		_launch_torp()
		_salvo_counter += 1
		$Torps/Salvo.start()
	else:
		_fire_shell()


func _on_Salvo_timeout() -> void:
	if _salvo_counter < torp_salvo_size:
		_launch_torp()
		_salvo_counter += 1
	else:
		_salvo_counter = 0
		$Torps/Salvo.stop()


func _launch_torp() -> void:
	var torp = preload("res://Ships/Torpedo_0.tscn").instance()
	owner.add_child(torp)
	torp.setup($Torps.global_transform)


func _fire_shell():
	var shell = preload("res://Shell203JP.tscn").instance()
	owner.add_child(shell)
	shell.global_transform = $Torps.global_transform
	shell.linear_velocity = _muzzle_velocity * -shell.global_transform.basis.z
	var h_time_half = (_current_target_distance / _muzzle_velocity) / 2.0
	var v0 = h_time_half * 9.8
	
	shell.linear_velocity.y += v0


var _current_target_distance = 0
func set_distance(dist) -> void:
	_current_target_distance = dist
