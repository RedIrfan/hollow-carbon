class_name StatePlayer
extends StateCharacter


func _get_direction() -> int:
	if Input.is_action_pressed("move_right"):
		return 1
	if Input.is_action_pressed("move_left"):
		return -1
	return 0

