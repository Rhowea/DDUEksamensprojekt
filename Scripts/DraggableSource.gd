extends TextureRect

export var ingredientName:String

func get_drag_data(position):
	var icon = self.texture
	var data = [ingredientName, icon]
	var preview = TextureRect.new()
	preview.expand = true
	preview.rect_size.x = 32
	preview.rect_size.y = 32
	preview.texture = icon
	set_drag_preview(preview)
	return data
