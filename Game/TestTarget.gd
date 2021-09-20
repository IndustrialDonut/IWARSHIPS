extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var health = 10
func damage(dmg):
	health -= dmg
	if health <= 0:
		self.queue_free()
