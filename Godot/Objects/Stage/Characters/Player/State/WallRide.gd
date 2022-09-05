extends StatePlayer

export var jump_delay_duration : float = 0.1

var up_velocity : float = 50
var jumped : bool = false

onready var jump_delay_timer : Timer = $JumpDelayTimer


func enter(msg={}):
	body.sprite_switched = -1
	body.direction_x = 0
	
	body.animation_player.offset.x = -9
	body.play_animation("WallRide")


func exit():
	body.sprite_switched = 1
	body.animation_player.offset.x = 0
	body.gravity = Global.GRAVITY


func physics_process(delta):
	if jump_delay_timer.is_stopped():
		if jumped:
			fsm.enter_state("jump", {"wall_direction" : body.pivot.scale.x})
			jumped = false
			
			return
		
		body.velocity.y = 3
		
		_direction_auto()
		
		if _get_wallride() == false:
			fsm.enter_state("fall")
		if _get_jump():
			jumped = true
			jump_delay_timer.start(jump_delay_duration)
		if body.on_floor():
			fsm.enter_state("Idle")
		if _get_hurt():
			fsm.enter_state("Hurt")
	else:
		body.velocity.y = 0
		body.gravity = 0
