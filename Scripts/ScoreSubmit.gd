extends Control

onready var scoreLabel = $VBoxContainer/Lables/Score
onready var playerNameLabel = $VBoxContainer/PlayerName
var grade = "G"
signal addToRequestQueue(body)
var scoreSubmitted = false

func _submit_score(_text):
	if scoreSubmitted == false and playerNameLabel.text != "":
		scoreSubmitted = true
#		if playerNameLabel.text != "":
		var user_name = playerNameLabel.get_text()
		var score = scoreLabel.get_text()
		var command = "add_score"
		var data = {"username" : user_name, "score" : score, "grade" : grade}
		emit_signal("addToRequestQueue", {"command" : command, "data" : data})
	#	request_queue.push_back({"command" : command, "data" : data})

func setScoreLabel(score:String):
	scoreLabel.text = String(score)
