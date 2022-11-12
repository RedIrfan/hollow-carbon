class_name EventCheckpoint
extends Event

export(String ,"Left", "Right") var facing_direction = "Right"


func start():
	Global.stage_master().current_saved_position = self.global_position
	Global.stage_master().player_saved_facing_direction = 1 if facing_direction == "Right" else -1
	Global.stage_master().save_reset()
	exit()
