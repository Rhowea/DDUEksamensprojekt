extends Control

onready var rect1 = $ColorRect1
onready var rect2 = $ColorRect2
onready var rect3 = $ColorRect3
onready var rect4 = $ColorRect4
onready var rect5 = $ColorRect5
onready var rect6 = $ColorRect6
onready var rect7 = $ColorRect7
onready var bars :={0: rect1, 1: rect2, 2: rect3, 3: rect4, 4: rect5, 5: rect6, 6: rect7,}

func setBarHeight(income):
	var highest = 0
	for n in income:
		if income[n] > highest:
			highest = income[n]
	for n in income:
		bars[n].rect_size.y = 150 * (income[n]/highest)
