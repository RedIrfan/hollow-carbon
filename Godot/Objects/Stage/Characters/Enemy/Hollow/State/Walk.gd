extends StateEnemy

export var idle_distance : float = 5


func enter(msg={}):
	body.play_animation("Walk")


func exit():
	body.direction_x = 0


func physics_process(delta):
	if _get_hurt():
		fsm.enter_state("Hurt")
	
	body.direction_x = _get_direction_to_player().x
	
	var distance = _get_distance_to_player()
	
	if distance < idle_distance:
		fsm.enter_state("Idle")
	
