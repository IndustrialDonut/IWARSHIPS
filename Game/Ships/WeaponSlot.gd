extends Spatial


func change_out_weapon(weapon_scene):
	get_child(0).queue_free()
	
	var inst = weapon_scene.instance()
	
	add_child(inst)


func fire():
	get_child(0).fire()


func get_contained_type():
	return get_child(0).type

