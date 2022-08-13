extends StateEnemyIdle

export var attack_distance : float = 2.5


func _on_action_timeout():
	var distance = _get_distance_to_player()
	
	if distance < attack_distance:
		body.pivot.scale.x = _get_direction_to_player().x
		fsm.enter_state("Attack")
	else:
		fsm.enter_state("Walk")
