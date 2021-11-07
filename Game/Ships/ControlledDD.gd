extends Spatial

## IDK what the high-level thing here is supposed to even be?? An interface to
## the outside somehow, a wrapper for all the functionality that makes the ship?
## idk! Can it be empty? Perhaps? Perhaps I'll discover a need for it? This
## necesarry hierarchy to the godot scene tree kinda gets on my nerves.
## --- this all makes much more sense to me now. keep functionality low, and connections
## and intermingling as needed high.

#export var health : float = 100

signal updated_player_HUD(info, type)

func _ready() -> void:
	$Radar.set_active(true)
	$Radar.set_team("BLUE")


func _process(delta: float) -> void:
	
	## REPLACE WITH REMOTE TRANSFORMS
	$CameraControl.global_transform.origin = $ShipRB.global_transform.origin
	
	$Weapons.global_transform.origin = $ShipRB.global_transform.origin
	$Weapons.rotation.y = $ShipRB.rotation.y # only rotate in the plane (vertical stabilization)


func set_slot_weapon(index, weapon_scene):
	$Weapons.set_slot_weapon(index, weapon_scene)


func _on_ShipRB_HUD_data_changed(data, type) -> void:
	#$HUD.set_basics(data, type)
	emit_signal("updated_player_HUD", data, type)


func _on_CameraControl_distance(dist) -> void:
	#$Weapons.set_distance(dist)
	#$HUD.set_distance(dist)
	emit_signal("updated_player_HUD", dist, ENUMS.DATA.TARGET_DISTANCE)


func _on_CameraControl_targeted_point(point_global) -> void:
	$TARGET.global_transform.origin = point_global
	$Weapons.set_target_point(point_global)


func _on_Radar_radar_hit(separation2d) -> void:
	emit_signal("updated_player_HUD", separation2d, ENUMS.DATA.RADAR_ACTIVE)
