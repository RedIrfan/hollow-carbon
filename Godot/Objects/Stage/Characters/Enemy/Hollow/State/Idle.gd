extends StateEnemy

export var attack_distance : float = 2.5


func enter(_msg={}):
	body.play_animation("Idle")


func physics_process(_delta):
	var distance = _get_distance_to_player()
	
	if distance < attack_distance:
		fsm.enter_state("Attack")
	else:
		fsm.enter_state("Walk")
