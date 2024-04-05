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
	playerScores = $VBoxContainer/Scoreboard/Scores.get_children()
	playerGrades = $VBoxContainer/Scoreboard/Grades.get_children()
