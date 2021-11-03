extends MeshInstance


func _ready() -> void:
	
	$DD.connect("updated_player_HUD", $HUD, "set_ship_basics")
	
	$HUD.set_num_slots(3)


func _on_HUD_slot_changed(slot_index, weapon_scene) -> void:
	$DD.set_slot_weapon(slot_index, weapon_scene)
