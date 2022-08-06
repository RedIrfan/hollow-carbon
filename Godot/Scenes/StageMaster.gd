class_name StageMaster
extends Node2D

var player : Node setget set_player, get_player


func _ready():
	add_to_group("Stage Master")


func set_player(nplayer):
	player = nplayer


func get_player():
	if player == null:
		set_player(get_tree().get_nodes_in_group("Player")[0])
	return player
