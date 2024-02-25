extends StateEnemy

export var floor_raycast_path : NodePath
export var max_distance : int = 64
export var attack_duration : float = 3
export var attack_distance : int = 32

var face_direction : int = 1
var floor_raycast : RayCast2D

onready var attack_timer : Timer = $AttackTimer


func _ready():
	floor_raycast = get_node(floor_raycast_path)


# warning-ignore:unused_argument
func enter(msg={}):
	body.play_animation("Idle")
	body.gravity = Global.GRAVITY * 0.5
	_update_direction()
	
	attack_timer.start(attack_duration)


func exit():
	body.direction_x = 0


# warning-ignore:unused_argument
func physics_process(delta):
	if attack_timer.is_stopped():
		var still_attack : bool = true
		if floor_raycast.get_collider():
			if floor_raycast.get_collider().is_in_group("Hidden Fly Collision") == false:
				still_attack = false
				
		if abs(_get_raw_distance_to_player().x) < attack_distance and still_attack == true:
			body.velocity = Vector2.ZERO
			fsm.enter_state("Stab")
			return
	
	
	if floor_raycast.get_collider():
		body.velocity.y = -25
	
	if abs(_get_raw_distance_to_player().x) > max_distance and _get_direction_to_player().x == face_direction * -1 or body.is_on_wall():
		_update_direction()
	
	body.direction_x = face_direction
	
	if _get_hurt():
		fsm.enter_state("Hurt", {"skip" : true})


func _update_direction():
# warning-ignore:narrowing_conversion
	face_direction = _get_direction_to_player().x
