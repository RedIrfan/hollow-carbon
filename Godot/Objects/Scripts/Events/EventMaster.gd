class_name EventMaster
extends Area2D

var events = []
var process_index : int = 0


func _ready():
	self.connect("body_entered", self, "_on_body_entered")
	
	for child in get_children():
		if child.is_in_group("Event"):
			events.append(child)


func start_event():
	
	events[process_index].start()
	
	events[process_index].connect("ended", self, "_on_event_ended")


func _on_event_ended(event):
	process_index = clamp(process_index + 1, 0, events.size() - 1)
	start_event()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		process_index = 0
		start_event()
