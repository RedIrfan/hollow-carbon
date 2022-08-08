extends Node

const GRAVITY : float = 150.0

const MAX_FALL_VELOCITY : float = 200.0


func stage_master():
	return get_tree().get_root().get_child(1)
