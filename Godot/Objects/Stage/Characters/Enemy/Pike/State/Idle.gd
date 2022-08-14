extends StateEnemyIdle

export var attack_distance : float = 32


func _on_action_timeout():
	var distance = _get_distance_to_player()
	
	if body.on_floor():
		fsm.enter_state("Flyup")
	elif distance <= attack_distance:
		fsm.enter_state("Stab")
	else:
		fsm.enter_state("Move")
