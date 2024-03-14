extends Control

onready var set1 = $VBoxContainer/Ingredients1
onready var set2 = $VBoxContainer/Ingredients2
onready var set3 = $VBoxContainer/Ingredients3

func _on_TextureButton1_pressed():
	set1.visible = true
	set2.visible = false
	set3.visible = false
	print("Displaying set 1")

func _on_TextureButton2_pressed():
	set1.visible = false
	set2.visible = true
	set3.visible = false
	print("Displaying set 2")

func _on_TextureButton3_pressed():
	set1.visible = false
	set2.visible = false
	set3.visible = true
	print("Displaying set 3")
