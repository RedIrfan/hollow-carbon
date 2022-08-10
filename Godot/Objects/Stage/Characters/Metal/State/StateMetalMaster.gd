class_name StateMetalMaster
extends StateMaster


func attack():
	if current_state:
		current_state.attack()
