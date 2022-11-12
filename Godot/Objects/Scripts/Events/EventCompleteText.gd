extends Event


func start():
	var gui = Global.stage_master().gui
	var fade_panel = gui.get_gui("FadePanel")
	
	fade_panel.set_fade(Tween.EASE_IN, Color(1,1,1,0), Color(1,1,1,1), 2)
	gui.enter_gui("FadePanel")
	yield(fade_panel, 'exited')
	
	print("faded")
	fade_panel.visible = true
	gui.current_gui = null
	
	fade_panel.set_fade(Tween.EASE_OUT, Color(1,1,1,1), Color(1,1,1,0), 1)
	gui.enter_gui("FadePanel")
	yield(gui, 'gui_changed')
	yield(fade_panel, 'exited')
	print("fadedsecondtime")
	
	gui.enter_gui("CompletedText")
	yield(gui, "gui_changed")
	
	yield(get_tree().create_timer(1), "timeout")
	
	gui.get_gui("CompletedText").exit()
	yield(gui.get_gui("CompletedText"), "exited")
	
	exit()
