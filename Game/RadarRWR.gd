extends Spatial

signal radar_hit(separation2d)
signal radar_RWR_hit(separation2d)

var team = "RED"

var _on : bool = false
var _max_range = 800

func _ready() -> void:
	$RayCast.cast_to = Vector3(0, 0, -_max_range)
	$RayCast.add_exception($Area)


func _physics_process(delta: float) -> void:
	if _on:
		_scan_radar()


func set_team(team):
	self.team = team


func set_active(boolean = true):
	_on = boolean


func ping_by_radar(rad):
	
	var separation = rad.global_transform.origin - global_transform.origin
	
	emit_signal("radar_RWR_hit", _v3planeProj(separation))


func _scan_radar():
	
	var all_radars = get_tree().get_nodes_in_group("RADAR")
	
	if all_radars.size() <= 1:
		return
	
	var closest = all_radars[0] if all_radars[0] != self else all_radars[1]
	var closest_dist2 = (closest.global_transform.origin - global_transform.origin).length_squared()
	
	for radar in all_radars:
		
		if radar != self:# and team != radar.team:
			
			$RayCast.look_at(radar.global_transform.origin, Vector3.UP) # runs every frame
			
			if $RayCast.is_colliding():
				
				if $RayCast.get_collider().get_collision_layer_bit(1):
					# won't run if hits an obstacle on layer 1 only first
					
					radar.ping_by_radar(self)
					
					var separation3 = radar.global_transform.origin - global_transform.origin
					
					var v2d = _v3planeProj(separation3)
					
					var dist2 = v2d.length_squared()
					
					if dist2 < closest_dist2:
						
						closest = radar
						closest_dist2 = dist2
					
	
	var dist = sqrt(closest_dist2)
	
	var the_sep = closest.global_transform.origin - global_transform.origin
	
	if dist < _max_range:
		
		# active radar show hit.
		emit_signal("radar_hit", _v3planeProj(the_sep))


func _v3planeProj(v3):
	return Vector2(v3.x, v3.z)
