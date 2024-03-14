extends Control

onready var window = $WindowDialog
onready var set1 = $WindowDialog/Set1
onready var set2 = $WindowDialog/Set2
onready var set3 = $WindowDialog/Set3

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
