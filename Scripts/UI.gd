extends Control

onready var window = $Panel
onready var set1 = $Panel/Ingredients
onready var set2 = $Panel/VegMeatRatio
onready var set3 = $Panel/Price
onready var set4 = $Panel/Graph
onready var set5 = $Panel/Grades

var rng = RandomNumberGenerator.new()
var set1Interacted = false
var set2Interacted = false
var set3Interacted = false
var canSetVars = true
var meatVegRatio
var price
var income := {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}
#Ingredients[Attractablity, Environmental Goodness]
var ingredients := {
	"Carrot": [0.4, 0.7],
	"Potato": [1, 0.6],
	"Tomato": [0.8, 0.7],
	"Chickpeas": [0.2, 1],
	"Fish": [0.7, 0.7],
	"Beef": [1, 0.1],
	"Chicken": [0.8, 0.4],
	"Water": [0.4, 1],
	"Soda": [1, 0.4],
	"Energy Drink": [0.8, 0.2]
}

func _on_Button1_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
			print(window.visible)
		set1.visible = true
		set2.visible = false
		set3.visible = false

func _on_Button2_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
			print(window.visible)
		set1.visible = false
		set2.visible = true
		set3.visible = false

func _on_Button3_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
			print(window.visible)
		set1.visible = false
		set2.visible = false
		set3.visible = true

func _on_WindowDialog_popup_hide():
		print(window.visible)

func _on_Set1_has_interacted():
	set1Interacted = true
	print("Set 1 is ready")
	checkForReady()

func _on_Set2_has_interacted():
	meatVegRatio = set2.slider.value
	set2Interacted = true
	print("Set 2 is ready")
	checkForReady()

func _on_Set3_has_interacted():
	price = set3.slider.value
	set3Interacted = true
	print("Set 3 is ready ", price)
	checkForReady()

func checkForReady():
	if set1Interacted == true and set2Interacted == true and set3Interacted == true:
		print("Ready to calculate")
		$Button4.visible = true

func _on_Button4_pressed():
	canSetVars = false
	if set4.visible == true:
		set1.visible = false
		set2.visible = false
		set3.visible = false
		set4.visible = false
		calcEcoImpact()
		set5.visible = true
	elif set5.visible == true:
		#Score submission
		print("Score submission goes here")
	else:
		for n in income:
			#How many buy
			var buyerRatio = calcCustomerRatioOfBuyers(price, calcAttract())
			#Random function
			var customerAmount = calcAmountOfCustomers()
			#Amount of customers times how many buy
			income[n] = customerAmount * buyerRatio * (price * 100)
		print(income)
		set1.visible = false
		set2.visible = false
		set3.visible = false
		set4.setBarHeight(income)
		set4.visible = true

func calcAttract():
	var ratioAttract = -4 * pow(set2.slider.value, 4) + 4 * pow(set2.slider.value, 2)
	return (ratioAttract + calcIngredientAttract())/4

func calcIngredientAttract():
	return ingredients[set1.slot1.contents][0] + ingredients[set1.slot2.contents][0] + ingredients[set1.slot3.contents][0]

func calcCustomerRatioOfBuyers(price, attract):
	return pow((price - 1), 2) + pow(attract, 2)

func calcAmountOfCustomers():
	rng.randomize()	
	#Attractibility * max potential customers +- random variation
	var variability
	if rng.randf() < 1:
		variability = -25 * rng.randf()
	else:
		variability = 25 * rng.randf()
	
	return max(calcAttract() * 75 + variability, 0)

func calcEcoImpact():
	#slider * meat + (1 - slider) * veg + drink
	var totalImpactScore = (1 - set2.slider.value) * ingredients[set1.slot1.contents][1] + set2.slider.value * ingredients[set1.slot2.contents][1] + ingredients[set1.slot3.contents][1] * 2
	
	if totalImpactScore >= 4:
		set5.grade.text = "S"
	elif totalImpactScore >= 3:
		set5.grade.text = "A"
	elif totalImpactScore >= 2:
		set5.grade.text = "B"
	elif totalImpactScore >= 1.5:
		set5.grade.text = "C"
	elif totalImpactScore >= 1:
		set5.grade.text = "D"
	else:
		set5.grade.text = "F"
	print("totalImpactScore = ", totalImpactScore)
