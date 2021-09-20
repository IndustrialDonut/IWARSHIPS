extends RigidBody



func _physics_process(delta):
	$MeshInstance.look_at(linear_velocity, Vector3.UP)
	if self.global_transform.origin.y < -5:
		self.queue_free()
