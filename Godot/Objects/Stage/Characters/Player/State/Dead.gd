extends StatePlayer

var explosion = preload("res://Objects/Stage/Effects/Explosion/Explosion.tscn")


func enter(_msg={}):
	body.direction_x = 0
	body.visible = false
	
	var effect : Effect = explosion.instance()
	var explosion_pos = body.global_position
	explosion_pos.y -= 12
	
	effect.pause_mode = PAUSE_MODE_PROCESS
	effect.spawn(body, explosion_pos)
	
	body.emit_signal("dead")
