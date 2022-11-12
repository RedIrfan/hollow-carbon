extends Projectile


func _spawn_behaviour(params=[]):
	if params.size() >= 1:
		direction = params[0]
