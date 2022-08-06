extends StatePlayer


func enter(msg={}):
	body.direction_x = 0


func physics_process(_delta):
	if _get_direction() != 0:
		fsm.enter_state("walk")
	if _get_jump():
		fsm.enter_state("jump")
