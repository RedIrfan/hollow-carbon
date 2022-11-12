extends StateEnemyIdle

export var jump_distance : float = 96


func _on_action_timeout():
	if _get_raw_distance_to_player().x < jump_distance and _get_raw_distance_to_player().y < 32:
		fsm.enter_state("jump")
	else:
		fsm.enter_state("idle")
