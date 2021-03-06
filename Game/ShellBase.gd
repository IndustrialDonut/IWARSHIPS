extends RigidBody


func _ready() -> void:
	set_as_toplevel(true)


func _physics_process(delta):
	$MeshInstance.look_at(linear_velocity + global_transform.origin, Vector3.UP)
	if self.global_transform.origin.y < -5:
		self.queue_free()
