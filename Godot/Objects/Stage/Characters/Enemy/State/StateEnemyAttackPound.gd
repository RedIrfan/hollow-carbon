class_name StateEnemyAttackPound
extends StateEnemyAttack


func physics_process(delta):
	.physics_process(delta)
	
	if body.on_floor():
		activate_recovery()


func _on_animation_finished():
	match state:
		states.STARTUP:
			activate_damage()
		states.RECOVERY:
			_end_state()
