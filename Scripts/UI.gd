extends Control

onready var window = $WindowDialog
onready var set1 = $WindowDialog/Set1
onready var set2 = $WindowDialog/Set2
onready var set3 = $WindowDialog/Set3

var set1Interacted = false
var set2Interacted = false
var set3Interacted = false

func _on_Button1_pressed():
	if window.visible == false:
		window.popup()
		print(window.visible)
	set1.visible = true
	set2.visible = false
	set3.visible = false

func _on_Button2_pressed():
	if window.visible == false:
		window.popup()
		print(window.visible)
	set1.visible = false
	set2.visible = true
	set3.visible = false

func _on_Button3_pressed():
	if window.visible == false:
		window.popup()
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
	set2Interacted = true
	print("Set 2 is ready")
	checkForReady()

func _on_Set3_has_interacted():
	set3Interacted = true
	print("Set 3 is ready")
	checkForReady()

func checkForReady():
	if set1Interacted == true and set2Interacted == true and set3Interacted == true:
		print("Ready to calculate")



