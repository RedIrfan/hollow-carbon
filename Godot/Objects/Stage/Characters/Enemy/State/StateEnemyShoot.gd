class_name StateEnemyShoot
extends StateEnemyAttack

export var projectile : PackedScene
export var shoot_position : NodePath = ""
export var exception_group : String = ""


func _spawn_projectile():
	var bullet : Projectile = projectile.instance()
	
	bullet.spawn(body, get_node(shoot_position).global_position, body.pivot.scale.x, exception_group)


func _set_damage(ndamage:int):
	._set_damage(ndamage)
	if ndamage > 0:
		_spawn_projectile()
