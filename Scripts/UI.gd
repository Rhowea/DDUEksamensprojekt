extends Control

onready var window = $Panel
onready var set1 = $Panel/Set1
onready var set2 = $Panel/Set2
onready var set3 = $Panel/Set3

var rng = RandomNumberGenerator.new()
var set1Interacted = false
var set2Interacted = false
var set3Interacted = false
var meatVegRatio
var price

func _on_Button1_pressed():
	if window.visible == false:
		window.visible = true
		print(window.visible)
	set1.visible = true
	set2.visible = false
	set3.visible = false

func _on_Button2_pressed():
	if window.visible == false:
		window.visible = true
		print(window.visible)
	set1.visible = false
	set2.visible = true
	set3.visible = false

func _on_Button3_pressed():
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
	print("Set 3 is ready")
	checkForReady()

func checkForReady():
	if set1Interacted == true and set2Interacted == true and set3Interacted == true:
		print("Ready to calculate")
		$Button4.visible = true

func _on_Button4_pressed():
	#How many buy
	var buyerRatio = calcCustomerRatioOfBuyers(price, calcAttract())
	#Random function
	var customerAmount = calcAmountOfCustomers()
	#Amount of customers times how many buy
	customerAmount * buyerRatio * (price * 100)

func calcAttract():
	pass

func calcCustomerRatioOfBuyers(price, attract):
	return pow(price - 1, 2) + pow(attract, 2)

func calcAmountOfCustomers():
	rng.randomize()	
	#Attractibility * max potential customers +- random variation
	var variability
	if rng.randf() < 1:
		variability = -10 * rng.randf()
	else:
		variability = 10 * rng.randf()
	
	return calcAttract() * 90 + variability
