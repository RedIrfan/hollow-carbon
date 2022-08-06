extends StatePlayer

var jump_force : float = 100


func enter(msg={}):
	body.velocity.y -= jump_force


func physics_process(delta):
	_direction_auto()
	
	if body.velocity.y > 0 or _get_jump() == false:
		body.velocity.y = 0
		fsm.enter_state("fall")
	
	if _get_wallride():
		fsm.enter_state("wallride")
