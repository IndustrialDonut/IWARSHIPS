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
