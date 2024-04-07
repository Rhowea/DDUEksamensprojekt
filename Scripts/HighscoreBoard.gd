extends Control

var playerNames
var playerScores
var playerGrades
onready var ownRank = $VBoxContainer/OwnScore/OwnRank
onready var ownName = $VBoxContainer/OwnScore/OwnName
onready var ownScore = $VBoxContainer/OwnScore/OwnScore
onready var ownGrade = $VBoxContainer/OwnScore/OwnGrade

func _ready():
	playerNames = $VBoxContainer/Scoreboard/PlayerNames.get_children()
	playerNames.erase($VBoxContainer/Scoreboard/PlayerNames/Header)
	playerScores = $VBoxContainer/Scoreboard/Scores.get_children()
	playerScores.erase($VBoxContainer/Scoreboard/Scores/Header)
	playerGrades = $VBoxContainer/Scoreboard/Grades.get_children()
	playerGrades.erase($VBoxContainer/Scoreboard/Grades/Header)

func makeOwnScoreVisible():
	ownRank.visible = true
	ownName.visible = true
	ownScore.visible = true
	ownGrade.visible = true
