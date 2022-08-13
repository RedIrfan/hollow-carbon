class_name StatePlayer
extends StateCharacter


func _get_up() -> bool:
	return Input.is_action_pressed("action_up")


func _get_direction() -> int:
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_left"):
		return 0
	elif Input.is_action_pressed("move_right"):
		return 1
	elif Input.is_action_pressed("move_left"):
		return -1
	return 0


func _get_attack()->bool:
	if Input.is_action_just_pressed("action_attack"):
		return true
	return false


func _get_jump() -> bool:
	if Input.is_action_pressed("action_jump"):
		return true
	return false


func _get_dash()->bool:
	if Input.is_action_pressed("action_dash"):
		return true
	return false


func _get_wallride() -> bool:
	if body.on_wall() and _get_direction():
		return true
	return false


func _direction_auto() -> bool:
	var dir_x = _get_direction()
	
	body.direction_x = dir_x
	
	if dir_x != 0:
		return true
	return false
