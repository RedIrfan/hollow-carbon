extends StatePlayer


func enter(msg={}):
	body.speed = body.DEFAULT_SPEED


func physics_process(delta):
	body.play_animation("Walk")
	
	if _direction_auto() == false:
		fsm.enter_state("Idle")
	
	if _get_hurt():
		fsm.enter_state("Hurt")
	
	if _get_jump():
		fsm.enter_state("jump")
	
	if _get_fall():
		fsm.enter_state("fall")
	
	if _get_dash():
		fsm.enter_state("dash")
	
	if _get_attack():
		body.direction_x = 0
		fsm.enter_state("Attack")
