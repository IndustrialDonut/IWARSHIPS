extends Spatial

var type : int = ENUMS.ARM.GUN

const trav_rate = 20 # deg/s

var on_target := false

func _ready():
	for gun in $Horizontal/Vertical.get_children():
		gun.load_gun()


func fire():
	for gun in $Horizontal/Vertical.get_children():
		gun.fire()


func _on_Timer_timeout():
	for gun in $Horizontal/Vertical.get_children():
		gun.load_gun()







var muzzle_velocity = 800 # strictly the horizontal velocity, in m/s
var _muzzle_velocity = muzzle_velocity * CONSTANTS.UNITS_PER_METER

var _current_target_distance = 0

#func fire():
#	_fire_shell()


func _fire_shell():
	pass
#	var shell = preload("res://Shell203JP.tscn").instance()
#	owner.add_child(shell)
#	shell.global_transform = global_transform
#	shell.linear_velocity = _muzzle_velocity * -shell.global_transform.basis.z
#	var h_time_half = (_current_target_distance / _muzzle_velocity) / 2.0
#	var v0 = h_time_half * 9.8 #* CONSTANTS.UNITS_PER_METER
#
#	shell.linear_velocity.y += v0
