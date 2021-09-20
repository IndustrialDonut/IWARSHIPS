extends Spatial

#these can be changed on the particular child cannon
var shell = preload("res://Shell203JP.tscn")
var muzzle_vel = 40 #m/s

var loaded := false

func fire():
	if loaded:
		var inst = shell.instance()
		get_tree().current_scene.get_node("Containers").add_child(inst)
		inst.global_transform = $Muzzle.global_transform
		inst.linear_velocity = - muzzle_vel * inst.global_transform.basis.z
		
		loaded = false

func calc_el(dist):
	var el = (asin(9.8 * dist / (muzzle_vel*muzzle_vel) ))  /2.0
	if el > 0:
		return el
	else:
		return 0
