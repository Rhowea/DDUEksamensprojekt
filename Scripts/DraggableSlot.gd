extends TextureButton

export var slotNumber:int
signal contents_updated

var possibleIngredients = {0: ["Carrot", "Potato", "Tomato"], 1: ["Soy Beans", "Fish", "Beef", "Chicken"], 2: ["Water", "Soda", "Energy Drink"]}
var contents = null

func can_drop_data(position, data):
	return typeof(data) == TYPE_STRING and possibleIngredients[slotNumber].has(data)

func drop_data(position, data):
	contents = data
	print(contents)
	print("Something was dropped")
	emit_signal("contents_updated")
