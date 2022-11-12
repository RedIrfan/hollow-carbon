extends StatePlayer

var jump_force : float = 1300
var minimal_jump_duration : float = 0.1

var wall_jump : bool = false
var wall_jump_duration : float = 0.2
var wall_direction : int = 1
var dash : bool = false

onready var walljump_timer : Timer = $WallJumpTimer
onready var minimaljump_timer : Timer = $MinimalJumpTimer


func enter(msg={}):
	body.gravity = Global.GRAVITY * 1.5
	body.velocity.y = -jump_force
	dash = false
	
	if msg.has("dash"):
		dash = true
	
	if msg.has("wall_direction"):
		wall_jump = true
		walljump_timer.start(wall_jump_duration)
		
		wall_direction = msg["wall_direction"]
	
	minimaljump_timer.start(minimal_jump_duration)
	body.play_animation("Jump")


func exit():
	body.gravity = Global.GRAVITY
	walljump_timer.stop()
	
	if dash == true:
		fsm.get_state("dash").after_image_timer.stop()
		body.speed = body.DEFAULT_SPEED


func physics_process(delta):
	body.play_animation("Jump")
	
	if walljump_timer.is_stopped():
		_direction_auto()
	else:
		body.direction_x = wall_direction * -1
	
	if minimaljump_timer.is_stopped():
		if _get_fall() or _get_jump() == false:
			body.velocity.y = 0
			fsm.enter_state("fall")
	
	if _get_wallride() and walljump_timer.is_stopped():
		fsm.enter_state("wallride")
	if _get_attack():
		body.velocity.y = 0
		fsm.enter_state("Attack", {"air" : true})
	if _get_hurt():
		fsm.enter_state("Hurt")
