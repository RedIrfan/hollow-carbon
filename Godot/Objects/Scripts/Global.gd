extends Node

var GRAVITY : float = 9.8


func stage_master():
	return get_tree().get_root().get_child(1)
