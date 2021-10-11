extends Spatial

## IDK what the high-level thing here is supposed to even be?? An interface to
## the outside somehow, a wrapper for all the functionality that makes the ship?
## idk! Can it be empty? Perhaps? Perhaps I'll discover a need for it? This
## necesarry hierarchy to the godot scene tree kinda gets on my nerves.
## --- this all makes much more sense to me now. keep functionality low, and connections
## and intermingling as needed high.

#export var health : float = 100


func _process(delta: float) -> void:
	$CameraControl.global_transform.origin = $ShipRB.global_transform.origin
	$Weapons.global_transform.origin = $ShipRB.global_transform.origin


func _on_ShipRB_HUD_data_changed(data, type) -> void:
	$HUD.set_basics(data, type)


func _on_CameraControl_distance(dist) -> void:
	$Weapons.set_distance(dist)
	$HUD.set_distance(dist)
