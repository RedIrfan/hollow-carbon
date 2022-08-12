extends StateEnemy

var jump_force: int = 40

onready var jump_timer : Timer =$JumpTimer


func enter(msg={}):
	body.play_animation("JumpForward")
	
	body.velocity.y -= jump_force
	body.direction_x = _get_direction_to_player().x
	
	jump_timer.start(0.2)


func exit():
	body.direction_x = 0


func physics_process(delta):
	if body.on_floor() and jump_timer.is_stopped():
		fsm.enter_state("Idle")
