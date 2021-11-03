extends Control

onready var gun = preload("res://Weapons/TurretDouble.tscn")
onready var torp = preload("res://Weapons/Torps.tscn")

signal slot_changed(slot_index, weapon_scene)

func set_num_slots(num):
	
	for child in $HBoxContainer.get_children():
		child.queue_free()
	
	for i in range(num):
		
		var new = OptionButton.new()
		
		new.add_item("Gun", ENUMS.ARM.GUN)
		new.set_item_metadata(0, gun)
		
		new.add_item("Torp", ENUMS.ARM.TORP)
		new.set_item_metadata(1, torp)
		
		$HBoxContainer.add_child(new)
		
		new.size_flags_horizontal = SIZE_EXPAND_FILL
		
		new.connect("item_selected", self, "_option_changed")
	
	# sync the default UI loadout to the ship
	_option_changed(null)


func _option_changed(_option):
	
	var i = 0
	for child in $HBoxContainer.get_children():
		emit_signal("slot_changed", i, child.get_item_metadata(child.selected))
		i += 1
