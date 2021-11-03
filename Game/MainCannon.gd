extends Spatial

var _shell = preload("res://Shell203JP.tscn")
var _muzzle_vel : float = 30 # units/s
var _loaded := false

func fire():
	
	if _loaded:
		
		var inst = _shell.instance()
		add_child(inst) # added as toplevel though
		
		var T = global_transform
		inst.global_transform = T
		inst.linear_velocity = -T.basis.z * _muzzle_vel
		
		_loaded = false


func get_gun_elevation(distance : float) -> float:
	
	var el = asin(9.8 * distance / (_muzzle_vel*_muzzle_vel))  / 2.0
	
	return clamp(el, 0.0, deg2rad(45.0))


func load_gun():
	_loaded = true


func set_muzzle_velocity(speed : float):
	_muzzle_vel = speed
