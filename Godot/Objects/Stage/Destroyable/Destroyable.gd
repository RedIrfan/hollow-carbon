class_name Destroyable
extends Node2D

var explosion_effect : PackedScene = preload("res://Objects/Stage/Effects/Explosion/Explosion.tscn")

export var DEFAULT_HEALTH : int = 1 setget set_default_health
export var dropped_item : PackedScene

var health : float = DEFAULT_HEALTH

onready var pivot : Node = $Pivot
onready var hurtbox : Hurtbox = $Hurtbox
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var explosion_position : Position2D = $ExplosionPosition


func hurt(hurt_data):
	health -= hurt_data["damage"]
	animation_player.play("Hurt")
	
	if health <= 0:
		dead()


func dead():
	var ex = explosion_effect.instance()
	ex.spawn(self, explosion_position.global_position)
	
	if dropped_item != null:
		var item : Item = dropped_item.instance()
		item.spawn(explosion_position.global_position)
	
	_destroy()


func _destroy():
	queue_free()


func set_default_health(nhealth:int):
	DEFAULT_HEALTH = nhealth
	health = DEFAULT_HEALTH
