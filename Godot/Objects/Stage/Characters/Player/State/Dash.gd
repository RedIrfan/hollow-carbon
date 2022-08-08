extends StatePlayer

export var dash_duration : float = 0.2
export var dash_speed : int = 200
export var cooldown_duration : float = 0.1

onready var dash_timer : Timer = $DashTimer
onready var cooldown_timer : Timer = $CooldownTimer


func enter_condition(_msg={}) -> bool:
	if cooldown_timer.is_stopped():
		return true
	return false


func enter(msg={}):
	body.gravity = 0
	body.velocity.y = 0
	
	body.play_animation("Dash")
	
	body.pivot.flash(true, Vector3(1,1,1))
	body.speed = dash_speed
	
	dash_timer.start(dash_duration)


func exit():
	body.gravity = Global.GRAVITY
	
	body.speed = body.DEFAULT_SPEED
	body.pivot.flash(false)
	
	cooldown_timer.start(cooldown_duration)


func physics_process(delta):
	if dash_timer.is_stopped():
		fsm.enter_state("idle")
