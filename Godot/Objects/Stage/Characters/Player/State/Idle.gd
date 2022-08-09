extends StatePlayer


func enter(msg={}):
	if msg.has("fall"):
		body.play_animation("Land")
	else:
		body.play_animation("Idle")
	
	body.direction_x = 0


func physics_process(_delta):
	if _get_direction() != 0:
		fsm.enter_state("walk")
	if _get_jump():
		fsm.enter_state("jump")
	if _get_fall():
		fsm.enter_state("fall")
	if _get_attack():
		fsm.enter_state("Slash")
	if _get_hurt():
		fsm.enter_state("Hurt")
