class_name EnemySpawner
extends Node2D

var minimal_distance : int = 512

var can_spawn : bool = true

var enemy_object : PackedScene

onready var visibility_notifier_2d : VisibilityNotifier2D = $VisibilityNotifier2D


func _ready():
	add_to_group("Reseter")
	visibility_notifier_2d.connect("screen_entered", self, "_on_screen_entered")


func spawn(new_position, enemy):
	Global.stage_master().add_child(self)
	self.global_position = new_position
	
	enemy_object = load(enemy)
	_check_distance()


func _check_distance():
	var pos = global_position.distance_to(Global.stage_master().player.global_position)
	
	if pos < minimal_distance:
		_spawn_enemy()


func reset():
	can_spawn = true
	_check_distance()


func _spawn_enemy():
	if can_spawn:
		var enemy = enemy_object.instance()
		enemy.spawned = true
		Global.stage_master().add_child(enemy)
		enemy.global_position = self.global_position
		
		can_spawn = false


func _on_screen_entered():
	_spawn_enemy()
