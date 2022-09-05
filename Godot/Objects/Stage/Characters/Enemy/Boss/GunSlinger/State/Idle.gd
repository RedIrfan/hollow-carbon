extends StateEnemyIdle

export var wall_raycast_path : NodePath
export var jump_distance : float  = 32.0
export var stop_jump_forward : float = 48.0

var previous_state = ""
var shoot_count : int = 0
var jump_dir : int = 0

var wall_raycast : RayCast2D


func _ready():
	wall_raycast = get_node(wall_raycast_path)


func physics_process(delta):
	.physics_process(delta)
	
	if jump_dir != 0:
		if _get_direction_to_player().x == jump_dir * -1 or _get_distance_to_player() > stop_jump_forward:
			jump_dir = 0


func enter(msg={}):
	.enter(msg)
	if previous_state != "":
		match previous_state:
			"ShootFront":
				fsm.enter_state("ShootDiagonal")
			"ShootDiagonal":
				fsm.enter_state("ShootFront")
			"Jump":
				if body.health < body.DEFAULT_HEALTH*0.6 and shoot_count >= 1:
					fsm.enter_state("ShootUp")
					shoot_count = 0
				else:
					shoot_count + 1
					fsm.enter_state("ShootFront")
		previous_state = ""


func _on_action_timeout():
	var raw_distance = _get_raw_distance_to_player()
	var distance = _get_distance_to_player()
	var r_distance_y = abs(raw_distance.y)
	
	if wall_raycast.get_collider() and jump_dir == 0:
		jump_dir = _get_direction_to_player().x
	
	if body.health < body.DEFAULT_HEALTH*0.6:
		if shoot_count < 3:
			shoot_count += 1
		else:
			fsm.enter_state("ShootUp")
			shoot_count = 0
			return
	
	if jump_dir != 0:
		previous_state = "Jump"
		fsm.enter_state("JumpForward")
	elif abs(raw_distance.x) < jump_distance:
		previous_state = "Jump"
		fsm.enter_state("JumpBackward")
	elif r_distance_y < 32:
		previous_state = "ShootFront"
		fsm.enter_state("ShootFront")
	else:
		previous_state = "ShootDiagonal"
		fsm.enter_state("ShootDiagonal")
