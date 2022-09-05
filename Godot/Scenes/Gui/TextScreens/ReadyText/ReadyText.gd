extends GuiChild

onready var animation_player : AnimationPlayer = $AnimationPlayer


func enter():
	.enter()
	yield(get_tree().create_timer(0.1), "timeout")
	animation_player.play("Open")


func exit():
	animation_player.play_backwards("Open")
	yield(animation_player,"animation_finished")
	.exit()
