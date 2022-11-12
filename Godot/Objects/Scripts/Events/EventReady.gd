class_name EventReady
extends Event


func start():
	var gui = Global.stage_master().gui
	var player = Global.stage_master().player
	var old_player_pos = player.global_position
	
	Global.stage_master().start_position = old_player_pos
	Global.stage_master().current_saved_position = old_player_pos
	player.global_position = self.global_position
	player.metal.global_position = self.global_position + player.metal.ball_position
	
	gui.get_gui("FadePanel").set_fade(Tween.EASE_OUT, Color(0,0,0,1), Color(0,0,0,0), 0.5)
	gui.enter_gui("FadePanel")
	yield(gui, "gui_changed")
	
	gui.enter_gui("ReadyText")
	yield(gui, "gui_changed")
	
	player.play_animation("Walk")
	
	var tween = get_tree().create_tween().set_parallel(true)
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(player, "global_position", old_player_pos, 1)
	tween.tween_property(player.metal, "global_position", old_player_pos + player.metal.ball_position, 1)
	yield(tween, "finished")
	
	gui.enter_gui("Hud")
	yield(gui, "gui_changed")
	
	Global.stage_master().play_starting_music()
	
	exit()
