class_name Enemy
extends Character

var player : Node


func _ready():
	player = Global.stage_master().player
