class_name Item
extends Node2D

var body : Node

onready var pivot : Node2D = $Pivot
onready var area2d : Area2D = $Area2D


func _ready():
	area2d.connect("body_entered", self ,"_on_body_entered")


func spawn(new_position):
	Global.stage_master().add_child(self)
	self.global_position = new_position


func _on_body_entered(nbody):
	if nbody.is_in_group("Player"):
		body = nbody
		
		_pickup_behaviour()


func _pickup_behaviour():
	_destroy()


func _destroy():
	queue_free()
