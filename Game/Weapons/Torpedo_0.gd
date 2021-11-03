extends Spatial

export var travel_speed : int = 10 # m/s?
export var travel_depth_abs : float = 0.5


func _ready() -> void:
	set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	global_translate(-global_transform.basis.z * delta * travel_speed)


func setup(gTrans) -> void:
	global_transform = gTrans
	global_transform.origin.y = -travel_depth_abs

