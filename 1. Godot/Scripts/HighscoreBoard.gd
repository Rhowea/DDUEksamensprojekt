extends Control

var playerNames
var playerScores
var playerGrades


func _ready():
	playerNames = $VBoxContainer/Scoreboard/PlayerNames.get_children()
	playerNames.erase($VBoxContainer/Scoreboard/PlayerNames/Header)
	playerScores = $VBoxContainer/Scoreboard/Scores.get_children()
	playerScores.erase($VBoxContainer/Scoreboard/Scores/Header)
	playerGrades = $VBoxContainer/Scoreboard/Grades.get_children()
	playerGrades.erase($VBoxContainer/Scoreboard/Grades/Header)
