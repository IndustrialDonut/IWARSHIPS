extends Control

## Maybe for RWR have the actual alpha of the sprite increase/decrease according
## to the strength of the 'ping' by the radar.

const HALFPI = deg2rad(90)

func set_data(sep2d):
	
	var cam3dforward = get_viewport().get_camera().global_transform.basis.z
	
	var cam2dforward = - Vector2(cam3dforward.x, cam3dforward.z)
	
	$Base.rotation = cam2dforward.angle_to(sep2d)
	
	var hud_dist = sep2d.length() * CONSTANTS.KM_PER_UNIT
	
	$MovementHelper/Range.text = Helper.decimal_place_string(hud_dist, 2) + " km"
	
	$Base/Sprite.modulate.a = 0.7


func _process(delta: float) -> void:
	$Base/Sprite.modulate.a -= delta
