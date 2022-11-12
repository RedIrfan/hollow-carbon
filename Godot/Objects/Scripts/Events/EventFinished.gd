extends Event


func start():
	Global.stage_master().stage_finished()
	yield(get_tree().create_timer(0.1), "timeout")
	
	exit()
