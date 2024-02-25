extends Effect

onready var animation : AnimatedSprite = $AnimatedSprite


func _spawn_behaviour(_param={}):
	animation.play("default")


func _on_AnimatedSprite_animation_finished():
	_destroy()
