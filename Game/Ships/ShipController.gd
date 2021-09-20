extends Spatial

export(NodePath) onready var shipbase = get_node(shipbase)

export var vertical_cam_speed := 0.1

export var mouse_sens := 0.008

export var max_range = 1000

onready var _max_h = tan(deg2rad(5)) * max_range # 5 is the value IN the gun camera

var _bSkyView = false

var _last_local_cam_trans

signal distance(dist)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE:
			
			if $GH/GV/Camera.current:
				$GH/GV.translate(Vector3.UP * -event.relative.y * vertical_cam_speed)
				$GH.rotate_y(-event.relative.x * mouse_sens)
				$GH/GV.translation.y = clamp($GH/GV.translation.y , 2, _max_h)
			
			else:
				$H.rotate_y(-event.relative.x * mouse_sens)
				$H/V.rotate_x(-event.relative.y * mouse_sens)


func _process(delta: float) -> void:
	
	global_transform.origin = shipbase.global_transform.origin
	
	if Input.is_action_just_pressed("sprint"):
		if $H/V/Camera.current:
			$GH/GV/Camera.make_current()
		else:
			$H/V/Camera.make_current()
	
	if Input.is_action_pressed("ctrl") or _bSkyView:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("back"):
		shipbase.till_decrease()
	elif Input.is_action_just_pressed("forward"):
		shipbase.till_increase()
	
	if Input.is_action_pressed("left"):
		shipbase.set_rudder_key_state(-1)
	elif Input.is_action_pressed("right"):
		shipbase.set_rudder_key_state(1)
	else:
		shipbase.set_rudder_key_state(0)
		
	if Input.is_action_just_pressed("map"):
		_bSkyView = !_bSkyView
		
		if _bSkyView: # use tween for smoother transition
			_last_local_cam_trans = $H/V/Camera.transform
			$H/V/Camera.global_transform = $SkyView.global_transform
		else:
			$H/V/Camera.transform = _last_local_cam_trans



func _on_ShipBase_rudder_angle(normalized) -> void:
	$HUD.set_rudder_angle(normalized)

func _on_ShipBase_s_till(till) -> void:
	$HUD.set_till(till)

func _on_ShipBase_speed(vel) -> void:
	$HUD.set_speed(vel)


func _on_TakeRange_timeout() -> void:
	if $GH/GV/Camera/RayCast.is_colliding():
		var point = $GH/GV/Camera/RayCast.get_collision_point()
		shipbase.set_target_point(point)
		
		point -= $GH/GV/Camera/RayCast.global_transform.origin
		point.y = 0
		var _distance = point.length()
		emit_signal("distance", _distance)
		
