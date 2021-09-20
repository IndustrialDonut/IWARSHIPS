extends Spatial

var team = 0

func _physics_process(delta):
	_do_fog_of_war()


func _do_fog_of_war(): 
	# also set 'your players' ships' targets
	for en in get_tree().get_nodes_in_group("Targets"):
		en.fog()
	
	for unit in get_tree().get_nodes_in_group("Units"):
		var smallest_dist : float = 10_000
		for en in get_tree().get_nodes_in_group("Targets"):
			var dist = (en.global_transform.origin - unit.global_transform.origin).length()
			if dist <= en.detection:
				en.reveal()
				
				if dist < smallest_dist:
					smallest_dist = dist
					unit.closest_enemy = en


func initialize_teams():
	if team == 0:
		for unit in $BlueUnits.get_children():
			unit.add_to_group("Units")
		for unit in $RedUnits.get_children():
			unit.add_to_group("Targets")
	elif team == 1:
		for unit in $BlueUnits.get_children():
			unit.add_to_group("Targets")
		for unit in $RedUnits.get_children():
			unit.add_to_group("Units")
			
	for unit in $BlueUnits.get_children():
		unit.find_node("BlueFlag").show()
		#unit.find_node("LaserVertical").get_child(0).modulate
	for unit in $RedUnits.get_children():
		unit.find_node("RedFlag").show()
