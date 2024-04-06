extends TextureRect

export var whoAmI : String

func _on_value_changed(value:float):
	if whoAmI == "Carrot":
		if value == 0.9:
			visible = false
		else:
			visible = true
			rect_min_size.x = 90 + 5/value
			rect_min_size.y = 90 + 5/value
	
	if whoAmI == "Meat":
		if value == 0.1:
			visible = false
		else:
			visible = true
			rect_min_size.x = 90 + 5/(1 - value)
			rect_min_size.y = 90 + 5/(1 - value)
