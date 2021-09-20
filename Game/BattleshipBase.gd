extends "res://Ships/CruiserBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_damage = 4
	health = 40
	detection = 400
	_gun_range = 300
	manueverability = 6


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
