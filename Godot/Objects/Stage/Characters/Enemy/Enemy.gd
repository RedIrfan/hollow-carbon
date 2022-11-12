class_name Enemy
extends Character

export var delete_on_reset: bool = true

var enemy_spawner = preload("res://Objects/Stage/Characters/Enemy/EnemySpawner/EnemySpawner.tscn")

var spawned : bool = false
var save_data : Dictionary = {}

var player : Node setget set_player, get_player


func _ready():
	add_to_group("Seter")
	add_to_group("Enemy")


func reset():
	if delete_on_reset:
		queue_free()
	else:
		.reset()


func setup():
	if spawned == false:
		var spawner = enemy_spawner.instance()
		spawner.spawn(self.global_position, self.filename, get_save_data())
		
		queue_free()


func set_player(nplayer):
	player = nplayer


func get_player():
	if player == null:
		set_player(Global.stage_master().player)
	return player


func set_save_data(spawner_save_data):
	save_data = spawner_save_data
	
	pivot.scale.x = save_data["face_direction"]


func get_save_data():
	return {
		"face_direction" : pivot.scale.x,
	}
