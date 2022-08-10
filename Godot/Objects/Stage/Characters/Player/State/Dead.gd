extends StatePlayer


func enter(msg={}):
	body.direction_x = 0
	body.emit_signal("dead")
