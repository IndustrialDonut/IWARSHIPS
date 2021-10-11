extends Spatial

export(NodePath) onready var ship_rb = get_node(ship_rb)

export var quarter_speed : float = 10 # knots?
export var rudder_rate : float = 10 # rudder traverse rate
const max_rudder : float = 3.0 # degrees ofc

var _till : int = ENUMS.SHIP_TILL.REST

var _rudder_key_state = 0

signal rudder_angle(normalized, type)
signal speed(vel, type)
signal s_till(till, type)

func _physics_process(delta: float) -> void:
	_process_rudder_state(delta)
	_throttle()
	
	emit_signal("rudder_angle", ($RP.rotation_degrees.y + max_rudder)/ (2 *max_rudder), ENUMS.DATA.RUDDER_ANGLE)
	emit_signal("s_till", _till, ENUMS.DATA.SHIP_TILL)
	emit_signal("speed", ship_rb.global_transform.basis.xform_inv(ship_rb.linear_velocity), ENUMS.DATA.SHIP_VELOCITY)


func till_increase() -> void:
	if _till < ENUMS.SHIP_TILL.FULL:
		_till += 1

func till_decrease() -> void:
	if _till > ENUMS.SHIP_TILL.BACK:
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
	var force = (_till - ENUMS.SHIP_TILL.REST) * quarter_speed
	ship_rb.add_force(-$RP.global_transform.basis.z * force, $RP.global_transform.origin - ship_rb.global_transform.origin)
