extends Effect

var explode_sfx : AudioStreamSample = load("res://Assets/Soundfx/Game/ExplosionSound.wav")

onready var animation_player : AnimatedSprite = $AnimatedSprite


func _ready():
# warning-ignore:return_value_discarded
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	animation_player.play("default")


func _spawn_behaviour(_params={}):
	Global.play_soundfx(self.global_position, explode_sfx)
	animation_player.play("explode")


func _on_animation_finished():
	_destroy()
