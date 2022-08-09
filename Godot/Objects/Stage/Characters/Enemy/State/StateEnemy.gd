class_name StateEnemy
extends StateCharacter


func _get_distance_to_player() -> Vector2:
	if body.player:
		return body.player.global_position.distance_to(body.global_position)
	return Vector2.ZERO
