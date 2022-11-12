class_name StateEnemyShoot
extends StateEnemyAttack

export var projectile : PackedScene
export var shoot_position : NodePath = ""
export var exception_group : String = ""
export var projectile_params = []


func _spawn_projectile():
	var bullet : Projectile = projectile.instance()
	
	if projectile_params.has("Player"):
		projectile_params[projectile_params.find("Player")] = body.player
	
	bullet.spawn(body, get_node(shoot_position).global_position, body.pivot.scale.x, exception_group, projectile_params)


func _set_damage(ndamage:int):
	._set_damage(ndamage)
	if ndamage > 0:
		_spawn_projectile()
