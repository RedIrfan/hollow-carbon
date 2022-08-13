extends StateEnemy

export var front_raycast_path : NodePath
export var idle_distance : float = 5

var walk_direction : int = 1
var front_raycast : RayCast2D

onready var direction_timer : Timer = $ChangeDirectionTimer


func _ready():
	front_raycast = get_node(front_raycast_path)


func enter(msg={}):
	body.play_animation("Walk")
	walk_direction = body.pivot.scale.x


func exit():
	body.direction_x = 0


func physics_process(delta):
	if _get_hurt():
		fsm.enter_state("Hurt")
		
	if _get_raw_distance_to_player().y < 0.1 and _get_raw_distance_to_player().y > -0.1:
		walk_direction = _get_direction_to_player().x
	elif front_raycast.get_collider() == null and direction_timer.is_stopped():
		walk_direction *= -1
		direction_timer.start(0.1)
	
	body.direction_x = walk_direction
	
	var distance = _get_distance_to_player()
	
	if distance < idle_distance:
		fsm.enter_state("Idle")
	
