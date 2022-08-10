extends StateEnemy

var explosion = preload("res://Objects/Stage/Effects/Explosion/Explosion.tscn")
var blue_orb = preload("res://Objects/Stage/Items/BlueOrb/BlueOrb.tscn")


func enter(_msg={}):
	Global.pause(true)
	yield(get_tree().create_timer(0.1), "timeout")
	Global.pause(false)
	
	var item : Item = blue_orb.instance()
	item.spawn(body.global_position)
	
	var effect : Effect = explosion.instance()	
	effect.spawn(body, body.global_position)
	
	body.queue_free()
