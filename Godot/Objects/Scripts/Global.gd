extends Node

signal paused(mode)
signal sfx_volume_changed(new_volume)
signal music_volume_changed(new_volume)

var default_game_data = {
	"sfx_volume" : 0,
	"music_volume" : -2.1,
}

var game_data = {
	"sfx_volume" : 0,
	"music_volume" : -2.1,
}

enum PAUSES {
	NONE,
	FULL,
	CUTSCENE
}
var current_pause = PAUSES.NONE
var current_sfx_volume : float = 0 setget set_current_sfx_volume
var current_music_volume : float = -2.1 setget set_current_music_volume

const DEAFEN_AMOUNT : float = 1.5
const GRAVITY : float = 150.0
const MAX_FALL_VELOCITY : float = 200.0


func stage_master():
	return get_tree().get_root().get_child(1)


func pause(mode:bool, mode_pause:int=PAUSES.FULL):
	if mode == true:
		current_pause = mode_pause
		if mode_pause == PAUSES.FULL:
			current_music_volume -= DEAFEN_AMOUNT
			current_sfx_volume -= DEAFEN_AMOUNT
	else:
		current_music_volume = get_music_volume()
		current_sfx_volume = get_sfx_volume()
		
		current_pause = PAUSES.NONE
	get_tree().paused = mode
	emit_signal("paused", current_pause)


func set_current_sfx_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), new_volume)


func set_sfx_volume(new_volume):
	if current_pause != PAUSES.FULL:
		set_current_sfx_volume(new_volume)
	
	game_data["sfx_volume"] = new_volume
	emit_signal("sfx_volume_changed", new_volume)


func set_current_music_volume(new_volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume)


func set_music_volume(new_volume):
	if current_pause != PAUSES.FULL:
		set_current_music_volume(new_volume)
	
	game_data["music_volume"] = new_volume
	emit_signal("music_volume_changed", new_volume)


func get_sfx_volume():
	return game_data["sfx_volume"]


func get_music_volume():
	return game_data["music_volume"]


func play_soundfx(new_pos, sound_file):
	var sfx = SoundPlayer.new()
	stage_master().add_child(sfx)
	sfx.spawn(new_pos, sound_file)


func change_scene(scene_path:String):
	get_tree().change_scene(scene_path)
