class_name Destroyable
extends Node2D

export var DEFAULT_HEALTH : int = 1 setget set_default_health

var health : float = DEFAULT_HEALTH

onready var pivot : Node = $Pivot
onready var hurtbox : Hurtbox = $Hurtbox
onready var animation_player : AnimationPlayer = $AnimationPlayer


func hurt(hurt_data):
	health -= hurt_data["damage"]
	animation_player.play("Hurt")
	
	if health <= 0:
		dead()


func dead():
	_destroy()


func _destroy():
	queue_free()


func set_default_health(nhealth:int):
	DEFAULT_HEALTH = nhealth
	health = DEFAULT_HEALTH
