extends Spatial

const TYPE : int = ENUMS.ARM.GUN
const ROTATION_SPEED = deg2rad(20)
const ELEVATION_SPEED = deg2rad(10)

var _elevation_target = 0.0

func _ready():
	for gun in $Horizontal/Vertical.get_children():
		gun.load_gun()


func _physics_process(delta: float) -> void:
	
	var diff = _elevation_target - $Horizontal/Vertical.rotation.x
	
	if abs(diff) > deg2rad(0.1):
		
		var dir = sign(diff)
		
		$Horizontal/Vertical.rotation.x += dir * delta * ROTATION_SPEED


func fire():
	for gun in $Horizontal/Vertical.get_children():
		gun.fire()


func set_global_target(point_global):
	var dist = (point_global - global_transform.origin).length()
	
	# only need ONE elevation 
	_elevation_target = $Horizontal/Vertical.get_child(0).get_gun_elevation(dist)


func _on_Timer_timeout():
	for gun in $Horizontal/Vertical.get_children():
		gun.load_gun()




