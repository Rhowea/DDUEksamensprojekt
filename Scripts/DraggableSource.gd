extends TextureRect

export var ingredientName:String

func get_drag_data(position):
	var data = ingredientName
	var preview = Label.new()
	preview.text = data
	set_drag_preview(preview)
	return data
