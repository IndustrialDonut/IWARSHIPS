extends Spatial


func fire():
	get_child(0).fire()


func get_contained_type():
	return get_child(0).type
