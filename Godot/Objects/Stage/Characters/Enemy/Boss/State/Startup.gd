extends StateEnemy

export var start_state_path : NodePath


func physics_process(_delta):
	if body.activated:
		fsm.enter_state( get_node(start_state_path).name )
