extends Control

## Maybe for RWR have the actual alpha of the sprite increase/decrease according
## to the strength of the 'ping' by the radar.

const HALFPI = deg2rad(90)

func _process(delta: float) -> void:
	$Base/ActiveClosestTarget.modulate.a -= delta


func set_data(sep2d, type):
	
	var cam3dforward = get_viewport().get_camera().global_transform.basis.z
	
	if type == ENUMS.DATA.RADAR_ACTIVE:
		
		$Base/ActiveClosestTarget.modulate.a = 0.7
		
		$Base.rotation = _get_rotation(sep2d, cam3dforward)
		
		var hud_dist = sep2d.length() * CONSTANTS.KM_PER_UNIT
		
		$MovementHelper/Range.text = Helper.decimal_place_string(hud_dist, 2) + " km"
	
	
	elif type == ENUMS.DATA.RADAR_RWR:
		
		print('rwr hit')
		
		$Base2.rotation = _get_rotation(sep2d, cam3dforward)
		
		$Base2/PassiveClosestTarget.modulate.a = 0.5


func _get_rotation(sep2d, cam3dFor):
	
	var cam2dforward = - Vector2(cam3dFor.x, cam3dFor.z)
	
	return cam2dforward.angle_to(sep2d)
