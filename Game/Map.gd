extends MeshInstance


func _ready() -> void:
	$DD.connect("updated_player_HUD", $HUD, "set_ship_basics")
