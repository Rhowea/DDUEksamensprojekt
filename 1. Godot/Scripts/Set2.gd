extends Control

onready var slider = $VBoxContainer/HSlider

signal has_interacted
var hasBeenInteractedWith = false

func _on_HSlider_drag_ended(_value_changed):
	if hasBeenInteractedWith == false:
		hasBeenInteractedWith = true
		emit_signal("has_interacted")

func _on_visibility_changed():
	print("Slider value: ", slider.value)
	print("Resetting icon size")
	$"VBoxContainer/HBoxContainer2/Carrot Icon"._on_value_changed(slider.value)
	$"VBoxContainer/HBoxContainer2/Meat Icon"._on_value_changed(slider.value)

