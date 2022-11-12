class_name EventMaster
extends Area2D

export var on_ready : bool = false
export var pause_on_play : bool = false

var events = []
var process_index : int = 0

var can_activate : bool = true
var activated : bool = false

var save_data = {
	"can_activate" : true,
	"activated" : false
}

var last_event : Node = null
var current_event : Node = null


func _ready():
	add_to_group("Reseter")
	add_to_group("ResetSaver")
	self.connect("body_entered", self, "_on_body_entered")
	
	for child in get_children():
		if child.is_in_group("Event"):
			events.append(child)
	
	if on_ready:
		_start_up_events()


func save_reset():
	save_data["can_activate"] = can_activate
	save_data["activated"] = activated


func reset():
	last_event = null
	current_event = null
	
	can_activate = save_data["can_activate"]
	activated = save_data["activated"]


func _start_up_events():
	if pause_on_play:
		Global.pause(true, Global.PAUSES.CUTSCENE)
		set_pause_mode(Node.PAUSE_MODE_PROCESS)
	
	_start_event()


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
	can_activate = true
	activated = true
	process_index = 0
	
	_start_up_events()


func _next_event():
	
	if current_event != null:
		process_index += 1
		
		if process_index >= events.size() - 1:
			_finished()
	else:
		process_index = 0
	
	_start_event()


func _finished():
	can_activate = false
	activated = false
	Global.pause(false)


func _on_event_finished(event):
	_next_event()


func _on_body_entered(body):
	if body.is_in_group("Player") and activated == false and can_activate == true:
		_restart_event()
