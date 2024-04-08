extends Control

onready var window = $AspectRatioContainer/VBoxContainer/Panel
onready var set1 = $AspectRatioContainer/VBoxContainer/Panel/Ingredients
onready var set2 = $AspectRatioContainer/VBoxContainer/Panel/VegMeatRatio
onready var set3 = $AspectRatioContainer/VBoxContainer/Panel/Price
onready var set4 = $AspectRatioContainer/VBoxContainer/Panel/Graph
onready var set5 = $AspectRatioContainer/VBoxContainer/Panel/Grades
onready var set6 = $AspectRatioContainer/VBoxContainer/Panel/ScoreSubmit
onready var set7 = $AspectRatioContainer/VBoxContainer/Panel/HighscoreBoard
onready var button4 = $AspectRatioContainer2/Button4
onready var restartIcon = "res://Icons/Restart.png"

var rng = RandomNumberGenerator.new()
var set1Interacted = false
var set2Interacted = false
var set3Interacted = false
var canSetVars = true
var meatVegRatio
var price
var income := {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}
var score = -1
var grade = "G"
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
var serverResponseBody
signal dayHasPassed()

var http_request : HTTPRequest = HTTPRequest.new()
const SERVER_URL = "http://kroog.dk/db_test.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
const SECRET_KEY = 1234567890
var nonce = null
var request_queue : Array = []
var is_requesting : bool = false

func _ready():
	randomize()
	add_child(http_request)
	http_request.connect("request_completed",self,"_http_request_completed")

func _process(_delta):
	if is_requesting:
		return
	if request_queue.empty():
		return
	is_requesting = true
	if nonce == null:
		request_nonce()
	else:
		_send_request(request_queue.pop_front())

func _send_request(request: Dictionary):
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.print(request['data'])})
	var body = "command=" + request['command'] + "&" + data
	var cnonce = String(Crypto.new().generate_random_bytes(32)).sha256_text()
	var client_hash = (nonce + cnonce + body + String(SECRET_KEY)).sha256_text()
	print("Client hash: " + client_hash)
	
	nonce = null
	
	var headers = SERVER_HEADERS.duplicate()
	headers.push_back("cnonce: " + cnonce)
	headers.push_back("hash: " + client_hash)
	
	var err = http_request.request(SERVER_URL, headers, false, HTTPClient.METHOD_POST, body)
		
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return	
	print("Requesting...\n\tCommand: " + request['command'] + "\n\tBody: " + body)

func _http_request_completed(_result, _response_code, _headers, _body):
	is_requesting = false
	if _result != http_request.RESULT_SUCCESS:
		printerr("Error w/ connection: " + String(_result))
		return
	
	var response_body = _body.get_string_from_utf8()
	var response = parse_json(response_body)

	if response['error'] != "none":
		printerr("We returned error: " + response['error'])
		return
	
	if response['command'] == "get_nonce":
		nonce = response['response']['nonce']
		print("Get nonce: " + response['response']['nonce'])
		return	
	
	if response["response"]["size"] == 0:
		setServerResponseBody("An array of size 0 was received")
		if set6.visible:
			_on_Button4_pressed()
#		emit_signal("response", "An array of size 0 was recieved")
	if response['response']['size'] > 1:
#		var totalResponse:String = ""
		for n in (response['response']['size']):
			set7.playerNames[n].text = String(response["response"][String(n)]["player_name"])
			set7.playerScores[n].text = String(response["response"][String(n)]["score"])
			set7.playerGrades[n].text = String(response["response"][String(n)]["grade"])
	if response["response"]["size"] == 1:
		set7.makeOwnScoreVisible()
		set7.ownRank.text = String(response["response"]["0"]["rank"])
		set7.ownName.text = String(response["response"]["0"]["player_name"])
		set7.ownScore.text = String(response["response"]["0"]["score"])
		set7.ownGrade.text = String(response["response"]["0"]["grade"])
		

func request_nonce():
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.print({})})
	var body = "command=get_nonce&" + data
	var err = http_request.request(SERVER_URL, SERVER_HEADERS, false, HTTPClient.METHOD_POST, body)
	
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return
	print("Requeste nonce")

func addToRequestQueue(body):
	request_queue.push_back(body)

func _on_Button1_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
		showScreen(set1)

func _on_Button2_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
		showScreen(set2)

func _on_Button3_pressed():
	if canSetVars == true:
		if window.visible == false:
			window.visible = true
		showScreen(set3)

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
		button4.visible = true

func _on_Button4_pressed():
	canSetVars = false
	if set4.visible == true:
		calcEcoImpact()
		showScreen(set5)
	elif set5.visible == true:
		set6.setScoreLabel(String(calcTotalScore()))
		showScreen(set6)
		#Score submission
		print("Score submission goes here")
	elif set6.visible == true:
		getScores()
		showScreen(set7)
		button4.icon = load(restartIcon)
	elif set7.visible == true:
		get_tree().reload_current_scene()
	else:
		for n in income:
			#How many buy
			var buyerRatio = calcCustomerRatioOfBuyers(price, calcAttract())
			#Random function
			var customerAmount = calcAmountOfCustomers()
			#Amount of customers times how many buy
			income[n] = customerAmount * buyerRatio * (price * 100)
		print(income)
		set4.setBarHeight(income)
		emit_signal("dayHasPassed")
		button4.disabled = true
		yield($"../../AnimationPlayer", "animation_finished")
		button4.disabled = false
		showScreen(set4)
		set4.playAnim()

func calcAttract():
	var ratioAttract = -4 * pow(set2.slider.value, 4) + 4 * pow(set2.slider.value, 2)
	return (ratioAttract + calcIngredientAttract())/4

func calcIngredientAttract():
	return ingredients[set1.slot1.contents][0] + ingredients[set1.slot2.contents][0] + ingredients[set1.slot3.contents][0]

func calcCustomerRatioOfBuyers(priceOfMeal, attract):
	return pow((priceOfMeal - 1), 2) + pow(attract, 2)

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
	grade = set5.grade.text
	set6.grade = grade

func calcTotalScore():
	var total = 0
	for i in income:
		total = total + income[i]
	return int(total)

func showScreen(set:Control):
	var sets = [set1, set2, set3, set4, set5, set6, set7]
	for i in sets:
		if i == set:
			i.visible = true
		else:
			i.visible = false

func setServerResponseBody(body):
	serverResponseBody = body
	print("serverResponseBody: ", serverResponseBody)

func getScores():
	var command = "get_scores"
	var data = {"score_ofset" : 0, "score_number" : 10}
	var request := {"command" : command, "data" : data}
	print("getting scores")
	addToRequestQueue(request)
	var command2 = "get_player"
	var data2 = {"player_name" : set6.playerNameLine.get_text()}
	print("data2: ", data2)
	var request2 := {"command" : command2, "data" : data2}
	print("Getting own score")
	addToRequestQueue(request2)
