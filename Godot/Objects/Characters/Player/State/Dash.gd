extends StatePlayer

export var dash_duration : float = 0.3
export var dash_speed : int = 200

onready var dash_timer : Timer = $DashTimer


func enter(msg={}):
	body.pivot.flash(true, Vector3(1,1,1))
	body.speed = dash_speed
	
	dash_timer.start(dash_duration)


func exit():
	body.speed = body.DEFAULT_SPEED
	body.pivot.flash(false)


func physics_process(delta):
	if dash_timer.is_stopped():
		fsm.enter_state("idle")
