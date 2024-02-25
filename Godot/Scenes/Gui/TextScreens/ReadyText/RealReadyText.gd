extends "res://Scenes/Gui/TextScreens/ReadyText/ReadyText.gd"

onready var lives_value : Label = $Lives/LivesValue
onready var animation_player2 : AnimationPlayer = $AnimationPlayer2


func enter():
	lives_value.set_text(str(Global.stage_master().player_lives))
	.enter()
	animation_player2.play("Open")


func exit():
	.exit()
	animation_player2.play("Close")
