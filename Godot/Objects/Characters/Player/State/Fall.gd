extends StatePlayer


func enter(msg={}):
	pass


func physics_process(delta):
	_direction_auto()
	
	if body.on_floor():
		fsm.enter_state("idle")
	if _get_wallride():
		fsm.enter_state("wallride")
