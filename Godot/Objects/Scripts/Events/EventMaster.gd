class_name EventMaster
extends Area2D

var events = []
var process_index : int = 0

var activated : bool = true

var last_event : Node = null
var current_event : Node = null


func _ready():
	self.connect("body_entered", self, "_on_body_entered")
	
	for child in get_children():
		if child.is_in_group("Event"):
			events.append(child)


func _start_event():
	if current_event:
		last_event = current_event
	
	if process_index >= events.size():
		current_event = null
	else:
		current_event = events[process_index]
	
	if last_event != null:
		last_event.disconnect("finished", self, "_on_event_finished")
	
	if current_event != null:
		current_event.connect("finished", self, "_on_event_finished")
		current_event.start()


func _restart_event():
	activated = true
	process_index = 0
	
	_start_event()


func _next_event():
	
	if current_event != null:
		process_index += 1
		
		if process_index >= events.size() - 1:
			_finished()
	else:
		process_index = 0
	
	_start_event()


func _finished():
	activated = false


func _on_event_finished(event):
	_next_event()


func _on_body_entered(body):
	if body.is_in_group("Player") and activated:
		_restart_event()
