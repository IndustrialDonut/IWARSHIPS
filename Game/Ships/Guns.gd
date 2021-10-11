extends Spatial


var muzzle_velocity = 800 # strictly the horizontal velocity, in m/s
var _muzzle_velocity = muzzle_velocity * CONSTANTS.UNITS_PER_METER

var _current_target_distance = 0

func set_distance(dist):
	_current_target_distance = dist


func fire():
	_fire_shell()


func _fire_shell():
	var shell = preload("res://Shell203JP.tscn").instance()
	owner.add_child(shell)
	shell.global_transform = global_transform
	shell.linear_velocity = _muzzle_velocity * -shell.global_transform.basis.z
	var h_time_half = (_current_target_distance / _muzzle_velocity) / 2.0
	var v0 = h_time_half * 9.8
	
	shell.linear_velocity.y += v0
