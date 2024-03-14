extends Control

signal has_interacted
var hasBeenInteractedWith = false

func _on_HSlider_drag_ended(value_changed):
	if hasBeenInteractedWith == false:
		hasBeenInteractedWith = true
		emit_signal("has_interacted")
