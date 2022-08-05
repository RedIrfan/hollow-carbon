extends StatePlayer


func physics_process(delta):
	var dir_x = _get_direction()
	
	if dir_x != 0:
		body.direction_x = dir_x
	else:
		fsm.enter_state("Idle")
