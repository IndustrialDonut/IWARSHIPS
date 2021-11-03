extends Spatial

var shell = preload("res://Shell203JP.tscn")
var muzzle_vel = 40 #m/s
var loaded := false

func fire():
	
	if loaded:
		
		var inst = shell.instance()
		add_child(inst) # added as toplevel though
		
		var T = global_transform
		inst.global_transform = T
		inst.linear_velocity = -T.basis.z * muzzle_vel
		
		loaded = false


func get_gun_elevation(distance):
	
	var el = (asin(9.8 * distance / (muzzle_vel*muzzle_vel) ))  / 2.0
	
	return clamp(el, 0, deg2rad(90))


func load_gun():
	loaded = true


func set_muzzle_velocity(speed):
	muzzle_vel = speed
