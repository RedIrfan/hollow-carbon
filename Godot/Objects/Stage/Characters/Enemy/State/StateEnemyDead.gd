class_name StateEnemyDead
extends StateEnemy

export var spawn_health : bool = true
export var explosion = preload("res://Objects/Stage/Effects/Explosion/Explosion.tscn")
export var freeze_duration : float = 0.1

var blue_orb = preload("res://Objects/Stage/Items/BlueOrb/BlueOrb.tscn")

onready var dead_timer : Timer = $DeadTimer


func enter(_msg={}):
	Global.pause(true)
	
	dead_timer.start(freeze_duration)
	yield(dead_timer, "timeout")
	
	Global.pause(false)
	
	if spawn_health:
		var item : Item = blue_orb.instance()
		item.spawn(body.global_position)
	
	var effect : Effect = explosion.instance()	
	effect.spawn(body, body.global_position)
	
	process_dead()


func process_dead():
	body.queue_free()
