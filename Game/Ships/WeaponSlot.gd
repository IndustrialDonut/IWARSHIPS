extends Spatial

var _local_target = Vector3()

func _physics_process(delta: float) -> void:
	
	var trav_rate = deg2rad(get_child(0).ROTATION_SPEED)
	
	var front = global_transform.basis.z
	
	var ang = Vector2(front.x, front.z).angle_to(
				Vector2(_local_target.x, _local_target.z)
				)
	
	# Creating a threshold otherwise there is a slight vibration
	if(rad2deg(ang) <= 179): 
		rotate_object_local(
				Vector3(0,1,0), 
				sign(ang) * trav_rate * delta
				)


func set_global_target(point_global):
	_local_target = point_global - global_transform.origin


func change_out_weapon(weapon_scene):
	get_child(0).queue_free()
	
	var inst = weapon_scene.instance()
	
	add_child(inst)


func fire():
	get_child(0).fire()


func get_contained_type():
	return get_child(0).type

