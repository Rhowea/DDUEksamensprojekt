extends TextureRect

func _process(_delta):
	if visible:
		rect_pivot_offset.x = rect_size.x / 2
		rect_pivot_offset.y = rect_size.y / 2

func _on_value_changed(value:float):
	yield(get_tree(), "idle_frame")
	rect_scale.x = 1 / pow(2 - value, 2)
	rect_scale.y = 1 / pow(2 - value, 2)
