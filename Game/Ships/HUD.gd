extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func set_rudder_angle(normalized) -> void:
	$ColorRect/TextureRect.rect_position.x = normalized * $ColorRect.rect_size.x
	$ColorRect/TextureRect.rect_position.x -= $ColorRect/TextureRect.rect_size.x/2.0


func set_till(till) -> void:
	var word
	match till:
		-1:
			word = "BACK"
		0:
			word = "REST"
		1:
			word = "1/4"
		2:
			word = "2/4"
		3:
			word = "3/4"
		4:
			word = "FULL"
	
	$Till.text = "Till " + word


func set_speed(vel : Vector3) -> void:
	vel = -vel
	$Speed.text = str(vel.z) + " kts"


func set_distance(dist) -> void:
	$reticle/range.text = str(int(dist)) + " meters"
