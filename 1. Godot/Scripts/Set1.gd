extends Control

onready var slots = $VBoxContainer/HBoxContainer
onready var slot1 = $VBoxContainer/HBoxContainer/Slot1
onready var slot2 = $VBoxContainer/HBoxContainer/Slot2
onready var slot3 = $VBoxContainer/HBoxContainer/Slot3
onready var set1 = $VBoxContainer/Ingredients1
onready var set2 = $VBoxContainer/Ingredients2
onready var set3 = $VBoxContainer/Ingredients3

signal has_interacted

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

func _on_slot_contents_updated():
	for x in slots.get_children():
		if x.contents == null:
			return
	emit_signal("has_interacted")
