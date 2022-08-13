extends StatePlayer


func enter(msg={}):
	if _get_up():
		fsm.enter_state("SlashUp")
	else:
		fsm.enter_state("Slash")
