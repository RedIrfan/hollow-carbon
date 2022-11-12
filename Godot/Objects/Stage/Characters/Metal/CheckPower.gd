extends StateMetal


func physics_process(_delta):
	match Global.get_eye():
		Global.Eyes.METAL:
			fsm.enter_state("Metal")
