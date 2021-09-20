extends Spatial

var _selected_units := [] #this is what you have to work with for commanding, attacking, etc

var mouse_sens = 0.01
var move_speed = 8

onready var selection_box = $Vertical/SelectionBox
var start_selection_pos = Vector2()
var ray_length = 9000
onready var cam = $Vertical/Camera

var _last_mouse_pos : Vector2


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED:
		rotate_y(-event.relative.x * mouse_sens)
		$Vertical.rotate_x(-event.relative.y * mouse_sens)


func _process(delta: float) -> void:
	var mpos = get_viewport().get_mouse_position()
	
	if Input.is_action_just_pressed("left_mouse"):
		selection_box.start_selection_pos = mpos
		start_selection_pos = mpos
		
	if Input.is_action_pressed("left_mouse"):
		selection_box.mpos = mpos
		selection_box.is_visible = true
	else:
		selection_box.is_visible = false
		
	if Input.is_action_just_released("left_mouse"):
		_select_units(mpos)
	
	if Input.is_action_just_released("zoom_in"):
		global_transform.origin.y -= 1
	elif Input.is_action_just_released("zoom_out"):
		global_transform.origin.y += 1
	
	
	var move_amount = move_speed * delta * (global_transform.origin.y*0.1 + 1)
	
	if Input.is_action_pressed("sprint"):
		move_amount *= 2
		
	if Input.is_action_pressed("back"):
		translate_object_local(Vector3(0,0,move_amount))
		
	if Input.is_action_pressed("forward"):
		translate_object_local(Vector3(0,0,-move_amount))
		
	if Input.is_action_pressed("left"):
		translate_object_local(Vector3(-move_amount,0,0))
		
	if Input.is_action_pressed("right"):
		translate_object_local(Vector3(move_amount,0,0))
		
	
	_compass_alignment()
	
	if Input.is_action_just_pressed("pan"):
		_last_mouse_pos = get_viewport().get_mouse_position()
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	elif Input.is_action_just_released("pan"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
	if Input.is_action_just_pressed("main_command"):
		var pos = get_water_pos()
		if pos:
			if Input.is_action_pressed("sprint"):
				for unit in _selected_units:
					unit.add_move(pos)
			else:
				for unit in _selected_units:
					unit.set_move(pos)


func _mouse_click_unit_select(mpos):
	var result = _raycast_from_mouse(mpos, 3)
	if result and "health" in result.collider and result.collider.is_in_group("Units"):
		return result.collider


func _mouse_box_unit_select(top_left, bot_right):
	if top_left.x > bot_right.x:
		var tmp = bot_right.x
		bot_right.x = top_left.x
		top_left.x = tmp
	if top_left.y > bot_right.y:
		var tmp = bot_right.y
		bot_right.y = top_left.y
		top_left.y = tmp
	var box = Rect2(top_left, bot_right - top_left)
	var box__selected_units = []
	for unit in get_tree().get_nodes_in_group("Units"):
		if unit.is_in_group("Units") and box.has_point(cam.unproject_position(unit.global_transform.origin)):
			box__selected_units.append(unit)
			#unit.select()
	return box__selected_units


func get_water_pos():
	var cam_height = cam.global_transform.origin.y
	var aim_norm = cam.project_ray_normal(get_viewport().get_mouse_position())
	if aim_norm.y < 0:
		var fac = cam_height / aim_norm.y
		aim_norm *= -fac
		var aim_pos = aim_norm + cam.global_transform.origin
		return aim_pos
	else:
		return null


func _raycast_from_mouse(mpos, collision_mask):
	var ray_start = cam.project_ray_origin(mpos)
	var ray_end = ray_start + cam.project_ray_normal(mpos) * ray_length
	var space_state = get_world().direct_space_state
	return space_state.intersect_ray(ray_start, ray_end, [], collision_mask)


func _select_units(mpos):
	var new_selected_units = []
	if (mpos - start_selection_pos).length_squared() < 10:
		var u = _mouse_click_unit_select(mpos)
		if u:
			new_selected_units.append(u)
	else:
		var u = _mouse_box_unit_select(start_selection_pos, mpos)
		if u:
			new_selected_units = u
		
	if not Input.is_action_pressed("sprint"):
		_selected_units = new_selected_units
	else:
		_selected_units += new_selected_units
		
	for unit in get_tree().get_nodes_in_group("Units"):
		unit.deselect()
	for unit in _selected_units:
		unit.select()


func _compass_alignment():
	$Node2D/Sprite.rotation = rotation.y + PI
