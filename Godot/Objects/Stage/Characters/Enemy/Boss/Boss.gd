class_name Boss
extends Enemy

export var on_dead_event_path : NodePath

var on_dead_event : EventMaster
var activated : bool = false


func _ready():
	on_dead_event = get_node(on_dead_event_path)


func setup():
	pass


func reset():
	.reset()
	activated = false
