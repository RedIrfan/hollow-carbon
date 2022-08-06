extends StatePlayer

var up_velocity : float = 50


func enter(msg={}):
	body.direction_x = 0


func physics_process(delta):
	print('wallriding')
	body.velocity.y = 0
	
	_direction_auto()
	
	if _get_jump():
		fsm.enter_state("jump")
