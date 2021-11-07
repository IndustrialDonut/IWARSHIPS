extends Spatial

signal radar_hit(separation2d)

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


func ping_by_radar(ship, is_seen):
	var seen = "seen" if is_seen else "not seen"
	#print("We are ", seen, " by ", ship)


func _scan_radar():
	for radar in get_tree().get_nodes_in_group("RADAR"):
		if radar != self:# and team != radar.team:
			
			$RayCast.look_at(radar.global_transform.origin, Vector3.UP) # runs every frame
			
			if $RayCast.is_colliding():
				if $RayCast.get_collider().get_collision_layer_bit(1):
					# won't run if hits an obstacle on layer 1 only first
					
					var separation = radar.global_transform.origin - global_transform.origin
					
					var v2d = Vector2(separation.x, separation.z)
					
					if _max_range > v2d.length():
						
						emit_signal("radar_hit", v2d)
						
						radar.ping_by_radar(self, true)
					else:
						radar.ping_by_radar(self, false)
