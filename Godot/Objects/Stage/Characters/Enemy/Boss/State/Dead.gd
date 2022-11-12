extends StateEnemyDead


func process_dead():
	get_tree().call_group("Projectile", "queue_free")
	
	body.visible = false
	body.direction_x = 0
	body.gravity = 0
	
	body.on_dead_event._restart_event()
