class_name Helper extends Node


static func decimal_place_string(fValue, num_places):
	# formatting to have x decimal places at value = 0
	if fValue == 0:
		var string = "0.0"
		for i in range(num_places-1):
			string += "0"
		return string
	
	var a = str(fValue)
	var array = a.split('.',false)
	var new = array[0] + '.' + array[1].substr(0,num_places)
	return new
