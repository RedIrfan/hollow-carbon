extends Effect

export var explosion_sound : AudioStreamSample

onready var explosion_sound_player : AudioStreamPlayer = $AudioStreamPlayer
onready var animation_player : AnimationPlayer = $AnimationPlayer

#
#func _ready():
#	explosion_sound_player.stream = explosion_sound


func _spawn_behaviour(_params={}):
#	explosion_sound_player.play()
	animation_player.play("Explode")


func _on_AudioStreamPlayer_finished():
	_destroy()
