extends Spatial


func fire():
	$MainCannon.fire()


func get_gun_elevation(distance):
	return $MainCannon.get_gun_elevation(distance)


func load_gun():
	$MainCannon.load_gun()


func set_muzzle_velocity(speed):
	$MainCannon.set_muzzle_velocity(speed)
