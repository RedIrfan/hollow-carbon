class_name StateMetalMaster
extends StateMaster


func attack():
	if current_state and body.energy > 0:
		current_state.attack()
