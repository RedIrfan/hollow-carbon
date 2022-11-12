extends StatePlayer


func physics_process(_delta):
	match Global.get_core():
		Global.Cores.CARBON:
			fsm.enter_state("Carbon")
