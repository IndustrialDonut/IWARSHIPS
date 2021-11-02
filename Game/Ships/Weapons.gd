extends Spatial


var selected_weapon : int = ENUMS.ARM.GUN # start with nothing selected

var direction
var torpedo_lockmax = 0
var torpedo_lockmin = 0

func set_distance(dist) -> void:
	pass
	#$Guns.set_distance(dist)


func set_target_point(point_global):
	direction = point_global


func _physics_process(delta):
	if direction:
		
		var no_y_direction = direction
		no_y_direction.y = $Slot2/Torps.global_transform.origin.y
		
		$Slot2/Torps.look_at(no_y_direction, Vector3.UP)


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("select_torpedo"):
		_select(ENUMS.ARM.TORP)
	
	elif Input.is_action_just_pressed("select_gun"):
		_select(ENUMS.ARM.GUN)
	
	if Input.is_action_just_pressed("fire"):
		_fire(selected_weapon)


func _select(weapon_enum : int):
	selected_weapon = weapon_enum


# takes type ENUMS.ARM
func _fire(type : int) -> void:
	for slot in get_children():
		if slot.get_contained_type() == type:
			slot.fire()
	
