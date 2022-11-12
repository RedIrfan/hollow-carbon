class_name StageMaster
extends Node2D

export var camera_path : NodePath
export var music_path : AudioStreamMP3

var player : Node setget set_player, get_player
var camera : Node setget set_camera, get_camera
var gui : Node setget set_gui, get_gui
var boss = null
var boss_music : AudioStreamMP3 = preload("res://Assets/Music/Stage/BossTheme.mp3")

var start_position : Vector2 = Vector2.ZERO
var start_facing_direction : int = 0
var start_player_lives : int = 3

var current_saved_position : Vector2 = Vector2.ZERO
var player_saved_facing_direction : int = 1

var player_lives : int = start_player_lives

onready var music_player : AudioStreamPlayer = $MusicPlayer


func _ready():
	add_to_group("Stage Master")
	
	start_facing_direction = get_player().pivot.scale.x
# warning-ignore:return_value_discarded
	player.connect("dead", self, "_on_player_dead")
	
	get_tree().call_group("Seter", "setup")


func change_music(music_file):
	music_player.stream = music_file
	music_player.play()


func play_starting_music():
	change_music(music_path)


func restart():
	player.global_position = current_saved_position
	player.pivot.scale.x = player_saved_facing_direction
	get_tree().call_group("Reseter", "reset")
#	get_tree().call_group("Seter", "setup")


func full_restart():
	current_saved_position = start_position
	player_saved_facing_direction = start_facing_direction
	player_lives = start_player_lives
	
	restart()


func save_reset():
	get_tree().call_group("ResetSaver", "save_reset")


func _on_player_dead():
	player_lives -= 1
	
	Global.pause(true)
	yield(get_tree().create_timer(1.5), "timeout")
	
	gui.get_gui("FadePanel").set_fade(Tween.EASE_IN, Color(0,0,0,0), Color(0,0,0,1), 0.5)
	gui.enter_gui("FadePanel")
	yield(gui.get_gui("FadePanel"), "exited")
	gui.get_gui("FadePanel").visible = true
	
	gui.current_gui.exit()
	gui.current_gui = null
	if player_lives > 0:
		process_dead()
	else:
		gui.enter_gui("FailedText")
		gui.get_gui("FailedText").visible = true
		gui.get_gui("FadePanel").visible = false
		yield(gui.get_gui("FailedText"), "exited")
		
		gui.get_gui("FadePanel").visible = true
		process_dead(true)


func process_dead(full_dead:bool = false):
	if full_dead == false:
		restart()
	else:
		full_restart()
	
	gui.current_gui = null
	gui.get_gui("FadePanel").set_fade(Tween.EASE_OUT, Color(0,0,0,1), Color(0,0,0,0), 0.5)
	gui.enter_gui("FadePanel")
	yield(gui, "gui_changed")

	gui.enter_gui("Hud")
	yield(gui, "gui_changed")
	Global.pause(false)


func stage_finished():
	gui.get_gui("FadePanel").set_fade(Tween.EASE_IN, Color(0,0,0,0), Color(0,0,0,1), 0.5)
	gui.enter_gui("FadePanel")
	yield(gui.get_gui("FadePanel"), "exited")
	gui.get_gui("FadePanel").visible = true
	
	Global.change_scene("res://Scenes/Menu/MainMenu/MainMenu.tscn")


func set_boss(new_boss):
	boss = new_boss
	change_music(boss_music)
	boss.activated = true


func set_player(nplayer):
	player = nplayer


func set_camera(ncamera):
	camera = ncamera


func set_gui(ngui):
	gui = ngui


func get_player():
	if player == null:
		set_player(get_tree().get_nodes_in_group("Player")[0])
	return player


func get_camera():
	if camera == null:
		set_camera(get_node(camera_path))
	return camera


func get_gui():
	if gui == null:
		set_gui(get_tree().get_nodes_in_group("Gui Master")[0])
	return gui
