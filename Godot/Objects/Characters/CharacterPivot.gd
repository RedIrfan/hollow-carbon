class_name CharacterPivot
extends Node2D

export var flash_duration : float = 0.1

var flash_state : int = 0

onready var flash_timer : Timer = $FlashTimer


func _ready():
	flash_timer.connect("timeout", self, "_on_flash_timeout")
	
	flash_timer.one_shot = false


func flash(mode:bool, color:Vector3=Vector3(1,1,0)):
	if mode == true:
		material.set_shader_param("color", color)
		material.set_shader_param("color_progress", 1)
	else:
		material.set_shader_param("color_progress", 0)


func flash_with_time(mode:bool, color:Vector3=Vector3(1,1,0)):
	if mode == true:
		material.set_shader_param("color", color)
		material.set_shader_param("color_progress", 1)
		
		flash_state = 1
		flash_timer.start(flash_duration)
	else:
		flash_timer.stop()
		
		material.set_shader_param("color_progress", 0)


func _on_flash_timeout():
	flash_state = 0 if flash_state == 1 else 1
	material.set_shader_param("color_progress", flash_state)
