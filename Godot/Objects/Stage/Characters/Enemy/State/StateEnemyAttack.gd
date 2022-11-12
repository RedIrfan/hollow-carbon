class_name StateEnemyAttack
extends StateCharacterAttack


func _get_direction_to_player() -> Vector2:
	var body_pos = Vector2(body.global_position.x, 0)
	var player_pos = Vector2(body.player.global_position.x, 0)
	
	return body_pos.direction_to(player_pos)


func _change_direction(dir:Vector2):
	._change_direction(dir)
	if dir.x == 99:
		body.direction_x = _get_direction_to_player().x
