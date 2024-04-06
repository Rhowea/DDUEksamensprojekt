extends TextureButton

onready var animPlayer = $AnimationPlayer
export var slotNumber:int
signal contents_updated

var possibleIngredients = {0: ["Carrot", "Potato", "Tomato"], 1: ["Chickpeas", "Fish", "Beef", "Chicken"], 2: ["Water", "Soda", "Energy Drink"]}
var contents = null

func can_drop_data(_position, data):
	return typeof(data) == TYPE_ARRAY and possibleIngredients[slotNumber].has(data[0])

func drop_data(_position, data):
	contents = data[0]
	self.texture_normal = data[1]
#	print(contents)
#	print("Something was dropped")
	animPlayer.play("RESET")
	emit_signal("contents_updated")

func _mouse_entered():
	if contents == null:
		animPlayer.play("bounce")

func _mouse_exited():
	animPlayer.play("RESET")
