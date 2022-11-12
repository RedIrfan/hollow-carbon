class_name StateEnemy
extends StateCharacter


func _get_direction_to_player() -> Vector2:
	var body_pos = Vector2(body.global_position.x, 0)
	var player_pos = Vector2(body.player.global_position.x, 0)
	
	return body_pos.direction_to(player_pos)


func _get_distance_to_player() -> float:
	if body.player:
		return body.player.global_position.distance_to(body.global_position)
	return 0.0


func _get_raw_distance_to_player() -> Vector2:
	if body.player:
		return body.player.global_position - body.global_position
	return Vector2.ZERO
