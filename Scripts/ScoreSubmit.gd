extends Control

onready var scoreLabel = $VBoxContainer/Lables/Score
onready var playerNameLabel = $VBoxContainer/PlayerName
signal addToRequestQueue(body)
signal proceedToSet7

func _submit_score():
	var user_name = playerNameLabel.get_text()
	var score = scoreLabel.get_text()
	var command = "add_score"
	var data = {"username" : user_name, "score" : score}
	emit_signal("addToRequestQueue", {"command" : command, "data" : data})
	emit_signal("proceedToSet7")
#	request_queue.push_back({"command" : command, "data" : data})

func setScoreLabel(score:String):
	scoreLabel.text = String(score)
