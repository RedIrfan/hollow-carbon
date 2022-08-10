extends StateMetal

var bullet = preload("res://Objects/Stage/Projectile/BlueEnergy/BlueEnergy.tscn")


func _attack_behaviour():
	var c = bullet.instance()
	
	c.spawn(self, body.global_position, body.pivot.scale.x, "Player")
