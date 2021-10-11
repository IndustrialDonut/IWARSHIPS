extends Spatial

export(ENUMS.ARM) var contained = ENUMS.ARM.GUN


func fire():
	get_child(0).fire()
