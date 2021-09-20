extends "res://ShipBase.gd"


var detection = 100
var _gun_range = 50
var _damage = 1
var _min_acc = 0.4

var spotted := false

var closest_enemy = null

func _process(delta: float) -> void:
	for turret in $Hull/TurretContainer.get_children():
		if targeted_location != Vector3.ZERO:
			turret.look_at(targeted_location, Vector3.UP)
