extends StatePlayer


func physics_process(delta):
	body.play_animation("Walk")
	
	if _direction_auto() == false:
		fsm.enter_state("Idle")
	
	if _get_jump():
		fsm.enter_state("jump")
	
	if _get_fall():
		fsm.enter_state("fall")
	
	if _get_dash():
		fsm.enter_state("dash")
	
	if _get_attack():
		fsm.enter_state("Slash")
