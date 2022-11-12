class_name Character
extends KinematicBody2D

signal dead()
signal default_value_changed()

export var DEFAULT_HEALTH : int = 100 setget set_default_health
export var DEFAULT_SPEED : int = 50 setget set_default_speed
export var animation_player_path : NodePath = ""
export(String, "Left", "Right") var facing_direction : String = "Right"
export var handle_x_velocity : bool = true

var health : float = DEFAULT_HEALTH
var speed : float = DEFAULT_SPEED
var sprite_switched : int = 1

var attack_data = null

var direction_x : int = 0
var velocity : Vector2 = Vector2.ZERO
var gravity : float = Global.GRAVITY

var animation_player : Node

onready var pivot : Node2D = $Pivot
onready var check_floor : RayCast2D = $Pivot/CheckFloor
onready var fsm : StateMaster = $StateMaster


func _ready():
	add_to_group("Character")
	add_to_group("Reseter")
	
	pivot.scale.x = -1 if facing_direction == "Left" else 1


func reset():
	visible = true
	attack_data = null
	health = DEFAULT_HEALTH
	velocity = Vector2.ZERO
	direction_x = 0
	fsm.reset()
	pivot.flash(false)


func _physics_process(delta):
	move(delta)
	flip()


func move(delta):
	var snap = Vector2.DOWN * 2.5
	
	if velocity.y < 1:
		snap = Vector2.ZERO
#	if on_floor():
#		snap = check_floor.get_collision_normal()
		
	velocity.y = clamp(velocity.y + gravity * delta, -100, Global.MAX_FALL_VELOCITY)
	
	if handle_x_velocity:
		velocity.x = direction_x * speed
#	velocity = move_and_slide(velocity, Vector2.UP, true)
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true)


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


func on_floor(raycast_only:bool=false) -> bool:
	if raycast_only:
		if check_floor.get_collider():
			return true
	else:
		if self.is_on_floor() or check_floor.get_collider():
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
	var value_difference = DEFAULT_HEALTH - health
	DEFAULT_HEALTH = nhealth
	health = abs(DEFAULT_HEALTH - value_difference)
	emit_signal("default_value_changed")


func set_default_speed(nspeed:int):
	DEFAULT_SPEED = nspeed
	speed = DEFAULT_SPEED
	emit_signal("default_value_changed")
