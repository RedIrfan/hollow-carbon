class_name GameCamera
extends Camera2D

export var speed : float = 10
export var bonus_position : Vector2 = Vector2(0,0)

var pan_target : Node = null
var pan_position : Vector2 = Vector2.ZERO
var panning : bool = false
var player : Node = null


func _ready():
	player = Global.stage_master().player
	
	current = true


func _physics_process(delta):
	var target_pos = Vector2.ZERO
	if panning:
		target_pos = pan_position + bonus_position
	elif player:
		target_pos = player.global_position + bonus_position
	
	if target_pos != Vector2.ZERO:
		self.global_position = self.global_position.linear_interpolate(target_pos, speed * delta)


func pan(mode:bool, pposition:Vector2=Vector2.ZERO):
	panning = mode
	pan_position = pposition
