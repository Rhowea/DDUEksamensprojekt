extends Spatial

onready var animPlayer = $AnimationPlayer

func _on_MainUI_dayHasPassed():
	animPlayer.play("Pass day")
