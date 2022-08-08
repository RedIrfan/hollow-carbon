extends StatePlayer


func enter(msg={}):
	body.play_animation("Fall")


func physics_process(delta):
	body.play_animation("Fall")
	
	_direction_auto()
	
	if body.on_floor():
		fsm.enter_state("idle", {"fall" : true})
	if _get_wallride():
		fsm.enter_state("wallride")
	if _get_attack():
		fsm.enter_state("Slash")
