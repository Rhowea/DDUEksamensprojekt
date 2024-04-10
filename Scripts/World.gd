extends Spatial

onready var animPlayer = $DirectionalLight/AnimationPlayer

func _on_MainUI_dayHasPassed():
	animPlayer.play("Pass day")
