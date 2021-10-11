extends Spatial

## Much more accurately named camera controller

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
	
	_target_point()
	
	if Input.is_action_just_pressed("sprint"):
		if $H/V/Camera.current:
			$GH/GV/Camera.make_current()
		else:
			$H/V/Camera.make_current()
	
	if Input.is_action_pressed("ctrl") or _bSkyView:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
		
	if Input.is_action_just_pressed("map"):
		_toggle_map_view()


func _toggle_map_view():
		_bSkyView = !_bSkyView
		
		if _bSkyView: # use tween for smoother transition
			_last_local_cam_trans = $H/V/Camera.transform
			$H/V/Camera.global_transform = $SkyView.global_transform
		else:
			$H/V/Camera.transform = _last_local_cam_trans


func _target_point() -> void:
	var cam_point = $GH/GV/Camera.global_transform.origin
	
	var cam_point_flat = cam_point
	cam_point_flat.y = 0
	
	var d = 1.0 / (tan(abs($GH/GV/Camera.rotation.x)) / cam_point.y)
	
	var dir = -$GH/GV/Camera.global_transform.basis.z
	dir.y = 0
	dir = dir.normalized()
	
	var world_target = dir * d + cam_point_flat
	
	emit_signal("distance", d)

