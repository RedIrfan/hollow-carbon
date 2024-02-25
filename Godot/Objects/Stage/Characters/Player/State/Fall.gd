extends StatePlayer


func enter(_msg={}):
	body.play_animation("Fall")


func physics_process(_delta):
	body.play_animation("Fall")
	
# warning-ignore:return_value_discarded
	_direction_auto()
	
	if body.on_floor():
		fsm.enter_state("idle", {"fall" : true})
	if _get_wallride():
		fsm.enter_state("wallride")
	if _get_attack():
		fsm.enter_state("Attack")
	if _get_hurt():
		fsm.enter_state("Hurt")
