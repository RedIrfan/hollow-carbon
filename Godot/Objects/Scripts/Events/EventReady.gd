class_name EventReady
extends Event

var fully_starting_out : bool = true


func start():
	var stage_master = Global.stage_master()
	var gui = stage_master.gui
	var player = stage_master.player
	var old_player_pos = player.global_position
	
	stage_master.start_position = old_player_pos
	stage_master.current_saved_position = old_player_pos
	player.global_position = self.global_position
	player.metal.global_position = self.global_position + player.metal.ball_position
	
	if stage_master.player_dead == false:
		start_event(stage_master, gui, player, old_player_pos)
	else:
		yield(stage_master, "player_revived")
		Global.pause(true)
		start_event(stage_master, gui, player, old_player_pos)


func start_event(stage_master, gui, player, old_player_pos):
	if fully_starting_out:
		gui.get_gui("FadePanel").set_fade(Tween.EASE_OUT, Color(0,0,0,1), Color(0,0,0,0), 0.5)
		gui.enter_gui("FadePanel")
		yield(gui.get_gui("FadePanel"), "exited")
		
		gui.enter_gui("ReadyText")
		yield(gui, "gui_changed")
	
	player.play_animation("Walk")
	
	var tween = get_tree().create_tween().set_parallel(true)
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(player, "global_position", old_player_pos, 1.2)
	tween.tween_property(player.metal, "global_position", old_player_pos + player.metal.ball_position, 1.2)
	yield(tween, "finished")
	
	if fully_starting_out:
		gui.enter_gui("Hud")
		yield(gui, "gui_changed")
	
	stage_master.play_starting_music()
	
	fully_starting_out = false
	exit()
