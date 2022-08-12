class_name EventCheckpoint
extends Event


func start():
	Global.stage_master().current_saved_position = self.global_position
	exit()
