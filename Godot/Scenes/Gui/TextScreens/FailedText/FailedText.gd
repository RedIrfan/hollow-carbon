extends "res://Scenes/Gui/TextScreens/ReadyText/ReadyText.gd"


onready var animation_player2 : AnimationPlayer = $AnimationPlayer2


func enter():
	.enter()
	animation_player2.play("open")


func exit():
	.exit()
	animation_player2.play_backwards("open")


func _on_RetryButton_pressed():
	exit()


func _on_GiveUpButton_pressed():
	pass
