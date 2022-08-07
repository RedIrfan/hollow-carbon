class_name State
extends Node

var fsm
var body


func _ready():
	add_to_group("State")


func enter_condition(_msg={}) -> bool:
	return true


func enter(_msg={}):
	pass


func exit():
	pass


func physics_process(_delta):
	pass


func process(_delta):
	pass
