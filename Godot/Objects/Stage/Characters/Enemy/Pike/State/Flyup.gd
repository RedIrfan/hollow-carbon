extends StateEnemy

export var check_distance_path : NodePath
export var fly_force : float = 5.0

var check_fly_distance : RayCast2D


func _ready():
	check_fly_distance = get_node(check_distance_path)


func enter(_msg={}):
	body.play_animation("Idle")
	body.gravity = Global.GRAVITY * 0.5


func exit():
	body.gravity = Global.GRAVITY


func physics_process(_delta):
	if check_fly_distance.get_collider() or body.on_floor():
		body.velocity.y = -fly_force
	else:
		fsm.enter_state("Move")
	
	if _get_hurt():
		fsm.enter_state("Hurt", {"skip" : true})
