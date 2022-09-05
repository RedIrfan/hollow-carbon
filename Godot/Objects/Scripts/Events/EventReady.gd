class_name EventReady
extends Event


func start():
	var tween = get_tree().create_tween().set_parallel(true)
	var gui = Global.stage_master().gui
	var player = Global.stage_master().player
	var old_player_pos = player.global_position
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	
	gui.enter_gui("ReadyText")
	yield(gui, "gui_changed")
	
	player.global_position = self.global_position
	player.metal.global_position = self.global_position + player.metal.ball_position
	
	player.play_animation("Walk")
	
	tween.tween_property(player, "global_position", old_player_pos, 1)
	tween.tween_property(player.metal, "global_position", old_player_pos + player.metal.ball_position, 1)
	yield(tween, "finished")
	
	gui.enter_gui("Hud")
	yield(gui, "gui_changed")
	
	exit()
