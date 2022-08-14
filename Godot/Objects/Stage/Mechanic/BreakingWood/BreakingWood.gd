extends Node2D

signal destroyed

export var check_for_player : bool = true
export var break_time_duration : float = 0.5
export(Array, NodePath) var set_off

var break_time_count  : float = 0.0
var break_count : int = 0

var breaking:bool = false
var destroyed : bool = false
var dead : bool = false

onready var sprite: Sprite = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var area2d : Area2D = $Area2D
onready var visibility_notifier : VisibilityNotifier2D = $Sprite/VisibilityNotifier2D
onready var static_body : StaticBody2D = $StaticBody2D


func _ready():
	add_to_group("Reseter")
	
	area2d.connect("body_entered", self, "_on_body_entered")
	area2d.connect("body_exited", self, "_on_body_exited")
	visibility_notifier.connect("screen_exited", self, "_on_screen_exited")
	
	for child in set_off:
		self.connect("destroyed", get_node(child), "_destroy")


func reset():
	destroyed = false
	dead = false
	breaking = false
	
	static_body.set_collision_layer_bit(0, true)
	static_body.set_collision_mask_bit(1, true)
	
	sprite.position = Vector2(0,0)
	sprite.frame_coords = Vector2(0,0)
	
	break_time_count = 0
	break_count = 0


func _physics_process(delta):
	if breaking == true:
		break_time_count += 1 * delta
		
		if break_time_count >= break_time_duration:
			break_time_count = 0
			_break()
	elif destroyed == true:
		sprite.global_position += (Vector2.DOWN * Global.GRAVITY) * delta


func _break():
	break_count += 1
	
	match break_count:
		1:
			sprite.frame_coords = Vector2(1,0)
		2:
			sprite.frame_coords = Vector2(2,0)
		3:
			sprite.frame_coords = Vector2(0,1)
	
	if break_count <= 3:
		animation_player.play("Break")
	else:
		_destroy()


func _destroy():
	if destroyed == false:
		breaking = false
		destroyed = true
		static_body.set_collision_layer_bit(0, false)
		static_body.set_collision_mask_bit(1, false)
		animation_player.play("Destroy")
		emit_signal("destroyed")


func _on_screen_exited():
	if destroyed == true:
		sprite.visible = false
		dead = true
		destroyed = false
		breaking = false


func _on_body_entered(body):
	if check_for_player:
		if body.is_in_group("Player") and destroyed == false and dead == false:
			breaking = true


func _on_body_exited(body):
	if check_for_player:
		if body.is_in_group("Player") and breaking == true and destroyed == false and dead == false:
			breaking = false
