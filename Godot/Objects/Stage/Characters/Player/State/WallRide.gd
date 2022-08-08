extends StatePlayer

var up_velocity : float = 50


func enter(msg={}):
	body.direction_x = 0
	
	body.animation_player.offset.x = -9
	body.play_animation("WallRide")


func exit():
	body.animation_player.offset.x = 0


func physics_process(delta):
	body.velocity.y = 3
	
	_direction_auto()
	
	if _get_wallride() == false:
		fsm.enter_state("fall")
	if _get_jump():
		fsm.enter_state("jump", {"wall_direction" : body.pivot.scale.x})
	if body.on_floor():
		fsm.enter_state("Idle")
