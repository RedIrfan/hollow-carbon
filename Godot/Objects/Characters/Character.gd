class_name Character
extends KinematicBody2D

export var DEFAULT_HEALTH : int = 100 setget set_default_health
export var DEFAULT_SPEED : int = 50 setget set_default_speed
export var animation_player_path : NodePath = ""

var health : float = DEFAULT_HEALTH
var speed : float = DEFAULT_SPEED

var attack_data = null

var direction_x : int = 0
var velocity : Vector2 = Vector2.ZERO
var gravity : float = Global.GRAVITY

var animation_player : Node

onready var pivot : Node2D = $Pivot


func _ready():
	add_to_group("Character")


func _physics_process(delta):
	move(delta)
	flip()


func move(delta):
	velocity.y += gravity * delta
	
	velocity.x = direction_x * speed
	velocity = move_and_slide(velocity, Vector2.UP)


func flip():
	if direction_x != 0:
		pivot.scale.x = direction_x


func play_animation(animation_name:String):
	if animation_player == null:
		get_animation_player()
	if animation_player != null:
		if animation_player is AnimatedSprite:
			animation_player.play(animation_name)


func hurt(nattack_data):
	attack_data = nattack_data


func on_floor() -> bool:
	if self.is_on_floor():
		return true
	return false


func connect_to_animation(body:Node, method_name:String):
	animation_player.connect("animation_finished", body, method_name)


func disconnect_from_animation(body:Node, method_name:String):
	animation_player.disconnect("animation_finished", body, method_name)


func get_animation_player():
	if animation_player_path != "":
		animation_player = get_node(animation_player_path)
	return animation_player


func set_default_health(nhealth:int):
	DEFAULT_HEALTH = nhealth
	health = DEFAULT_HEALTH


func set_default_speed(nspeed:int):
	DEFAULT_SPEED = nspeed
	speed = DEFAULT_SPEED
