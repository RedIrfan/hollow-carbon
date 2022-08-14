class_name StageMaster
extends Node2D

export var camera_path : NodePath

var player : Node setget set_player, get_player
var camera : Node setget set_camera, get_camera

var start_position : Vector2 = Vector2.ZERO
var current_saved_position : Vector2 = Vector2.ZERO


func _ready():
	add_to_group("Stage Master")
	
	start_position = get_player().global_position
	player.connect("dead", self, "_on_player_dead")
	
	current_saved_position = start_position
	
	get_tree().call_group("Seter", "setup")


func restart():
	player.global_position = current_saved_position
	get_tree().call_group("Reseter", "reset")
	get_tree().call_group("Seter", "setup")


func full_restart():
	current_saved_position = start_position
	restart()


func _on_player_dead():
	restart()


func set_player(nplayer):
	player = nplayer


func set_camera(ncamera):
	camera = ncamera


func get_player():
	if player == null:
		set_player(get_tree().get_nodes_in_group("Player")[0])
	return player


func get_camera():
	if camera == null:
		set_camera(get_node(camera_path))
	return camera
