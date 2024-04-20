extends Spatial

onready var animPlayer = $Sun/AnimationPlayer

func _on_MainUI_dayHasPassed():
	animPlayer.play("Pass day")
