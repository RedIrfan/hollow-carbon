class_name Event
extends Node2D

signal finished(event)


func _ready():
	add_to_group("Event")
	set_physics_process(false)


func start():
	exit()


func finished():
	emit_signal("finished", self)


func _on_exit():
	pass


func exit():
	_on_exit()
	set_physics_process(false)
	finished()
