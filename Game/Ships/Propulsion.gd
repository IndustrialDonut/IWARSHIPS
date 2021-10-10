extends Spatial

export(NodePath) onready var ship_rb = get_node(ship_rb)

export var quarter_speed : float = 10 # knots?

var _till : int

const max_till = 4 # min is -1, 0 is no throttle

var _rudder_key_state = 0

const max_rudder : float = 3.0 # degrees ofc

export var rudder_rate : float = 10 # rudder traverse rate

signal rudder_angle(normalized, type)
signal speed(vel, type)
signal s_till(till, type)

func _physics_process(delta: float) -> void:
	_process_rudder_state(delta)
	_throttle()
	
	emit_signal("rudder_angle", ($RP.rotation_degrees.y + max_rudder)/ (2 *max_rudder), "rudder")
	emit_signal("s_till", _till, "till")
	emit_signal("speed", ship_rb.global_transform.basis.xform_inv(ship_rb.linear_velocity), "speed")


func till_increase() -> void:
	if _till < max_till:
		_till += 1

func till_decrease() -> void:
	if _till > -1:
		_till -= 1


func set_rudder_key_state(state) -> void:
	_rudder_key_state = state


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


func _throttle() -> void:
	var force = _till * quarter_speed
	ship_rb.add_force(-$RP.global_transform.basis.z * force, $RP.global_transform.origin - ship_rb.global_transform.origin)
