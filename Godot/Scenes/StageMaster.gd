class_name StageMaster
extends Node2D

var player : Node setget set_player, get_player

var start_position : Vector2 = Vector2.ZERO
var current_saved_position : Vector2 = Vector2.ZERO


func _ready():
	add_to_group("Stage Master")
	
	start_position = get_player().global_position
	player.connect("dead", self, "_on_player_dead")


func restart():
	get_tree().call_group("Reseter", "reset")


func full_restart():
	restart()


func _on_player_dead():
	pass


func set_player(nplayer):
	player = nplayer


func get_player():
	if player == null:
		set_player(get_tree().get_nodes_in_group("Player")[0])
	return player
