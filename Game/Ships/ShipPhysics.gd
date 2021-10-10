extends Spatial

export(NodePath) onready var ship_rb = get_node(ship_rb)


func _physics_process(delta: float) -> void:
	_buoyancy()


func _buoyancy() -> void:
	
	var force = Vector3(0, ship_rb.mass * 9.8 * lerp(0.9, 1.2, -ship_rb.global_transform.origin.y), 0)
	var pos = $CB.global_transform.origin - ship_rb.global_transform.origin
	ship_rb.add_force(force, pos)
