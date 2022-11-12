extends TileMap

signal closed

onready var animation_player:AnimationPlayer = $AnimationPlayer


func _ready():
	reset()


func activate():
	animation_player.play("Close")


func reset():
	animation_player.play("Opened")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Close":
		emit_signal("closed")
