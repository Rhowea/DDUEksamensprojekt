extends TextureRect

export var ingredientName:String
onready var animPlayer = $AnimationPlayer

func _ready():
	hint_tooltip = ingredientName

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
	#play animation

func _mouse_exited():
	animPlayer.play("RESET")

