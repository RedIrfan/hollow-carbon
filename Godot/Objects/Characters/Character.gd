class_name Character
extends KinematicBody2D

export var DEFAULT_HEALTH : int = 100 setget set_default_health
export var DEFAULT_SPEED : int = 50 setget set_default_speed

var health : float = DEFAULT_HEALTH
var speed : float = DEFAULT_SPEED

var direction_x : int = 0
var velocity : Vector2 = Vector2.ZERO

onready var pivot : Node2D = $Pivot


func _ready():
	add_to_group("Character")


func _physics_process(delta):
	move(delta)
	flip()


func move(delta):
	velocity.y += Global.GRAVITY * delta
	
	velocity.x = direction_x * speed
	velocity = move_and_slide(velocity, Vector2.UP)


func flip():
	if direction_x != 0:
		pivot.scale.x = direction_x


func on_floor() -> bool:
	if self.is_on_floor():
		return true
	return false


func set_default_health(nhealth:int):
	DEFAULT_HEALTH = nhealth
	health = DEFAULT_HEALTH


func set_default_speed(nspeed:int):
	DEFAULT_SPEED = nspeed
	speed = DEFAULT_SPEED
