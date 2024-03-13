extends Control

onready var window = $Panel/WindowDialog


func _on_Button1_pressed():
	if window.visible == false:
		window.popup()
		print(window.visible)

func _on_Button2_pressed():
	pass # Replace with function body.

func _on_Button3_pressed():
	pass # Replace with function body.

func _on_WindowDialog_popup_hide():
		print(window.visible)
