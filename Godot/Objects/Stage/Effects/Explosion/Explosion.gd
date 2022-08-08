extends Effect

onready var animation_player : AnimatedSprite = $AnimatedSprite


func _ready():
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	animation_player.play("default")


func _spawn_behaviour(params={}):
	animation_player.play("explode")


func _on_animation_finished():
	_destroy()
