extends TextureRect

export var ingredientName:String
onready var animPlayer = $AnimationPlayer

func _ready():
	hint_tooltip = ingredientName

func _process(_delta):
	if visible:
		rect_pivot_offset.x = rect_size.x / 2
		rect_pivot_offset.y = rect_size.y / 2

func get_drag_data(_position):
	var icon = self.texture
	var data = [ingredientName, icon]
	var preview = TextureRect.new()
	preview.expand = true
	preview.rect_size.x = 64
	preview.rect_size.y = 64
	preview.texture = icon
	set_drag_preview(preview)
	return data

func _mouse_entered():
	animPlayer.play("bounce")

func _mouse_exited():
	animPlayer.play("RESET")

