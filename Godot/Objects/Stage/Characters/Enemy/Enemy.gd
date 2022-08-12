class_name Enemy
extends Character

var enemy_spawner = preload("res://Objects/Stage/Characters/Enemy/EnemySpawner/EnemySpawner.tscn")

var spawned : bool = false

var player : Node


func _ready():
	add_to_group("Seter")
	add_to_group("Enemy")
	
	player = Global.stage_master().player


func reset():
	queue_free()


func setup():
	if spawned == false:
		var spawner = enemy_spawner.instance()
		spawner.spawn(self.global_position, self.filename)
		
		queue_free()
