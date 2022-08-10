class_name StatePlayerAttack
extends StateCharacterAttack


func _change_direction(dir:Vector2):
	if dir.x != 66:
		._change_direction(dir)
