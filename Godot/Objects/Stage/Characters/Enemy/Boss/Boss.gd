class_name Boss
extends Enemy

var activated : bool = false


func setup():
	pass


func reset():
	.reset()
	activated = false
