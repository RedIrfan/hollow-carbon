extends StatePlayer


func physics_process(delta):
	if _direction_auto() == false:
		fsm.enter_state("Idle")
	
	if _get_jump():
		fsm.enter_state("jump")
	
	if _get_dash():
		fsm.enter_state("dash")
