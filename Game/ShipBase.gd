extends RigidBody

export var rudder_rate : float = 10 # rudder traverse rate

export var health : float = 100

export var quarter_speed : float = 10 # knots?

const max_till = 4 # min is -1, 0 is no throttle

const max_rudder : float = 3.0 # degrees ofc

var targeted_location : Vector3

var _till : int

var _rudder_key_state = 0

signal rudder_angle(normalized)
signal speed(vel)
signal s_till(till)

func _physics_process(delta) -> void:
	_process_rudder_state(delta)
	_buoyancy()
	_throttle()
	
	emit_signal("rudder_angle", ($RP.rotation_degrees.y + max_rudder)/ (2 *max_rudder))
	emit_signal("s_till", _till)
	emit_signal("speed", global_transform.basis.xform_inv(linear_velocity))


func till_increase() -> void:
	if _till < max_till:
		_till += 1

func till_decrease() -> void:
	if _till > -1:
		_till -= 1


func set_rudder_key_state(state) -> void:
	_rudder_key_state = state


func set_target_point(point) -> void:
	targeted_location = point


func _process_rudder_state(delta) -> void:
	match _rudder_key_state:
		1:
			if $RP.rotation_degrees.y < max_rudder:
				$RP.rotation_degrees.y += delta
		0:
			if not is_zero_approx($RP.rotation_degrees.y):
				if $RP.rotation_degrees.y > 0:
					$RP.rotation_degrees.y -= delta
				else:
					$RP.rotation_degrees.y += delta
		-1:
			if abs($RP.rotation_degrees.y) < max_rudder:
				$RP.rotation_degrees.y -= delta


func _buoyancy() -> void:
	add_force(Vector3(0,-mass * 9.8, 0), $CG.global_transform.origin - global_transform.origin)
	add_force(Vector3(0, mass * 9.8 * lerp(0.9, 1.2, -transform.origin.y), 0), $CB.global_transform.origin - global_transform.origin)


func _throttle() -> void:
	var force = _till * quarter_speed
	add_force(-$RP.global_transform.basis.z * force, $RP.global_transform.origin - global_transform.origin)
