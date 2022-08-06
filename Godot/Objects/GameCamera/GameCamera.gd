extends Node2D

var player : Node

onready var camera : Camera2D = $Camera2D


func _ready():
	player = Global.stage_master().player
	
	camera.current = true


func _physics_process(delta):
	if player:
		self.global_position = player.global_position
