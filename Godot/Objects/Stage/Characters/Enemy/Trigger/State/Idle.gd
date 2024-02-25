extends StateEnemyIdle

export var jump_distance : int = 15
export var jump_forward_distance : int = 128
export var stop_jump_forward : int = 64
export var check_wall_raycast : NodePath = ""

var jump_dir : int = 0

var wall_raycast : RayCast2D


func _ready():
	wall_raycast = get_node(check_wall_raycast)


func physics_process(delta):
	.physics_process(delta)
	
	if jump_dir != 0:
		if _get_direction_to_player().x == jump_dir * -1 or _get_distance_to_player() > stop_jump_forward:
			jump_dir = 0


func _on_action_timeout():
	var distance = _get_distance_to_player()
	
	if wall_raycast.get_collider() and jump_dir == 0:
# warning-ignore:narrowing_conversion
		jump_dir = _get_direction_to_player().x
	
	if distance > jump_forward_distance or jump_dir != 0:
		fsm.enter_state("JumpForward")
	elif distance < jump_distance:
		fsm.enter_state("JumpBackward")
	else:
		fsm.enter_state("Shoot")
