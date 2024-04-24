extends Control

onready var scoreLabel = $VBoxContainer/Lables/Score
onready var playerNameLine = $VBoxContainer/PlayerName
onready var multText = $VBoxContainer/Lables/MultText
onready var ecoMultLabel = $VBoxContainer/Lables/EcoBonus
onready var TotalScore = $VBoxContainer/Lables/PlayerTotalScore
var grade:String = "G"
var ecobonus
signal addToRequestQueue(body)
var scoreSubmitted = false

func _submit_score(_text):
	if scoreSubmitted == false and playerNameLine.text != "":
		scoreSubmitted = true
#		if playerNameLabel.text != "":
		var playerName = playerNameLine.text
		var score = scoreLabel.get_text()
		var command = "add_score"
		var data = {"username" : playerName, "score" : String(int(float(score) * ecobonus)), "grade" : grade}
		emit_signal("addToRequestQueue", {"command" : command, "data" : data})
	#	request_queue.push_back({"command" : command, "data" : data})

func setScoreLabel(score:int, ecoBonus:float):
	ecobonus = ecoBonus
	scoreLabel.text = String(int(score/ecoBonus))
	multText.text = "Score multiplier! Grade: " + grade
	ecoMultLabel.text ="x" + String(ecoBonus)
	TotalScore.text = String(score)
