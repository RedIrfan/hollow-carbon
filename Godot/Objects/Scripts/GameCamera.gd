class_name GameCamera
extends Camera2D

export var bonus_position : Vector2 = Vector2(0,0)

var player : Node


func _ready():
	player = Global.stage_master().player
	
	current = true


func _physics_process(delta):
	if player:
		self.global_position = player.global_position + bonus_position
