class_name StateCharacterAttack
extends StateCharacter

export var animation_name : String = ""
export var air_animation_name :String = ""
export var animation_offset : Vector2 = Vector2.ZERO
export var hitbox_path : NodePath
export var startup_duration : float = 0.01
export var active_duration : float = 0.01

var ground : bool = true


func enter(msg={}):
	body.connect_to_animation(self, "_on_animation_finished")
	
	body.animation_player.offset = animation_offset
	
	ground = true
	if air_animation_name != "":
		if _get_fall() or msg.has("air"):
			ground = false
			body.play_animation(air_animation_name)
	
	if ground == true:
		body.direction_x = 0
		body.play_animation(animation_name)


func exit():
	body.animation_player.offset = Vector2.ZERO
	
	body.disconnect_from_animation(self, "_on_animation_finished")


func _on_animation_finished():
	if ground == true:
		fsm.enter_state(fsm.initial_state.name)
	else:
		fsm.enter_state("Fall")
