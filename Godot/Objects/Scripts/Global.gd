extends Node

signal core_changed()
signal eye_changed()

enum Cores {
	CARBON,
}

enum Eyes {
	METAL,
}

var game_data = {
	"current_core" : Cores.CARBON,
	"current_eye" : Eyes.METAL,
}

const GRAVITY : float = 150.0
const MAX_FALL_VELOCITY : float = 200.0


func stage_master():
	return get_tree().get_root().get_child(1)


func pause(mode:bool):
	get_tree().paused = mode


func set_core(new_core:int):
	game_data["current_core"] = new_core


func set_eye(new_eye:int):
	game_data["current_eye"] = new_eye


func get_core() -> int:
	return game_data["current_core"]


func get_eye() -> int:
	return game_data["current_eye"]
