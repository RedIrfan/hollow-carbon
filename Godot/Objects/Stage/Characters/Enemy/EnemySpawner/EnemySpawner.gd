class_name EnemySpawner
extends Node2D

var minimal_distance : int = 512

var can_spawn : bool = true
var save_data
var spawner_data ={
	"can_spawn" : true
}

var enemy_object : PackedScene

onready var visibility_notifier_2d : VisibilityNotifier2D = $VisibilityNotifier2D


func _ready():
	add_to_group("Reseter")
	add_to_group("ResetSaver")
	
# warning-ignore:return_value_discarded
	visibility_notifier_2d.connect("screen_entered", self, "_on_screen_entered")


func spawn(new_position, enemy, enemy_save_data):
	Global.stage_master().add_child(self)
	self.global_position = new_position
	save_data = enemy_save_data
	
	enemy_object = load(enemy)
	_check_distance()


func _check_distance():
	var pos = global_position.distance_to(Global.stage_master().player.global_position)
	
	if pos < minimal_distance:
		_spawn_enemy()


func reset():
#	if save_data.size() > 0:
#		spawner_data = save_data
	can_spawn = spawner_data["can_spawn"]
	_check_distance()


func save_reset():
	spawner_data["can_spawn"] = can_spawn


func delete_saved_reset():
	spawner_data["can_spawn"] = true


func _spawn_enemy():
	if can_spawn:
		var enemy = enemy_object.instance()
		enemy.spawned = true
		Global.stage_master().add_child(enemy)
		enemy.global_position = self.global_position
		enemy.set_save_data(save_data)
		
		can_spawn = false


func _on_screen_entered():
	_spawn_enemy()
