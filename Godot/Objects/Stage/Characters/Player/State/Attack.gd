extends StatePlayer


func enter(msg={}):
	if _get_up():
		fsm.enter_state("SlashUp", msg)
	elif _get_down() and body.is_on_floor() == false:
		fsm.enter_state("downstab")
	else:
		fsm.enter_state("Slash", msg)
