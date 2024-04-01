extends Control

var playerNames
var playerScores
var playerGrades

func _ready():
	playerNames = $VBoxContainer/Scoreboard/PlayerNames.get_children()
	playerScores = $VBoxContainer/Scoreboard/Scores.get_children()
	playerGrades = $VBoxContainer/Scoreboard/Grades.get_children()
