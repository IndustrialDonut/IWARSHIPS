extends "res://DestroyerBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_damage = 2
	health = 20
	detection = 200
	_gun_range = 150
	manueverability = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
