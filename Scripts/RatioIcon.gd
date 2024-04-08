extends TextureRect

export var whoAmI : String

func _process(_delta):
	if visible:
		rect_pivot_offset.x = rect_size.x / 2
		rect_pivot_offset.y = rect_size.y / 2

func _on_value_changed(value:float):
	yield(get_tree(), "idle_frame")
	if whoAmI == "Carrot":
		if value == 0.9:
			visible = false
		else:
			visible = true
			rect_scale.x = 1 / (1 + value)
			rect_scale.y = 1 / (1 + value)
	
	if whoAmI == "Meat":
		if value == 0.1:
			visible = false
		else:
			visible = true
			rect_scale.x = 1 / (2 - value)
			rect_scale.y = 1 / (2 - value)
