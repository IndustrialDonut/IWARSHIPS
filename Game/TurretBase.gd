extends Spatial

var trav_speed = 0.01

var on_target := false

func _ready():
	for gun in $Horizontal/Vertical.get_children():
		gun.loaded = true

func command_fire():
	for gun in $Horizontal/Vertical.get_children():
		gun.fire()
		

func aim(point):
	on_target = false
	
	var cross = ( - $Horizontal.global_transform.basis.z).cross(point - self.global_transform.origin)
	
	if abs(cross.y)<1:
		on_target = true
	else:
		if abs(cross.y)<3:
			if cross.y > 0:
				$Horizontal.rotate_y(trav_speed/5.0)
			elif cross.y < 0:
				$Horizontal.rotate_y(-trav_speed/5.0)
		else:
			if cross.y > 0:
				$Horizontal.rotate_y(trav_speed)
			elif cross.y < 0:
				$Horizontal.rotate_y(-trav_speed)
			
		var el = $Horizontal/Vertical.get_child(0).calc_el((point - self.global_transform.origin).length())
		$Horizontal/Vertical.rotation.x = lerp_angle($Horizontal/Vertical.rotation.x, el, 0.1)

#func reset():
#	$Horizontal.rotation.y = lerp_angle($Horizontal.rotation.y, 0 ,0.1)


func _on_Timer_timeout():
	for gun in $Horizontal/Vertical.get_children():
		gun.loaded = true



















var muzzle_velocity = 800 # strictly the horizontal velocity, in m/s
var _muzzle_velocity = muzzle_velocity * CONSTANTS.UNITS_PER_METER

var _current_target_distance = 0

func set_distance(dist):
	_current_target_distance = dist


func fire():
	_fire_shell()


func _fire_shell():
	var shell = preload("res://Shell203JP.tscn").instance()
	owner.add_child(shell)
	shell.global_transform = global_transform
	shell.linear_velocity = _muzzle_velocity * -shell.global_transform.basis.z
	var h_time_half = (_current_target_distance / _muzzle_velocity) / 2.0
	var v0 = h_time_half * 9.8 #* CONSTANTS.UNITS_PER_METER
	
	shell.linear_velocity.y += v0
