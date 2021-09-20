extends Spatial


export(NodePath) onready var shipbase = get_node(shipbase)

var selected_weapon : int = -1 # start with nothing selected

var torp_salvo_size = 3

var _salvo_counter = 0


func select(weapon_enum : int):
	selected_weapon = weapon_enum


func _process(delta: float) -> void:
	
	global_transform.origin = shipbase.global_transform.origin
	
	if Input.is_action_just_pressed("select_torpedo"):
		select(ENUM.ARM.TORP)
	
	var look_to = shipbase.targeted_location
	
	look_to.y = $Torps.global_transform.origin.y
	
	$Torps.look_at(look_to, Vector3.UP)
	
	if Input.is_action_just_pressed("fire"):
		fire()


func fire() -> void:
	
	if selected_weapon == ENUM.ARM.TORP:
		_launch_torp()
		_salvo_counter += 1
		$Torps/Salvo.start()


func _on_Salvo_timeout() -> void:
	if _salvo_counter < torp_salvo_size:
		_launch_torp()
		_salvo_counter += 1
	else:
		_salvo_counter = 0
		$Torps/Salvo.stop()

func _launch_torp() -> void:
	var torp = preload("res://Ships/Torpedo_0.tscn").instance()
	owner.add_child(torp)
	torp.setup($Torps.global_transform)
