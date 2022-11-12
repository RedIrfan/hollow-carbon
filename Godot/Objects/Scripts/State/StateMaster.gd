tool
class_name StateMaster
extends Node

export var initial_state_path : NodePath
export var body_path : NodePath

var body

var states = {}
var initial_state
var current_state
var next_state
var previous_state


func _ready():
	if ! Engine.editor_hint:
		add_to_group('State Master')
		
		for child in get_children():
			if child.is_in_group('State'):
				states[child.name.to_lower()] = child
		
		body = get_node(body_path)
		initial_state = get_node(initial_state_path)
		enter_state(initial_state.name)


func reset():
	enter_state(initial_state.name)


func enter_state(state_name:String, msg={}):
	state_name = state_name.to_lower()
	if states.has(state_name):
		if states[state_name].enter_condition(body, msg):
			next_state = states[state_name]
			previous_state = current_state
			if current_state:
				current_state.exit()
				current_state = null
			current_state = states[state_name]
			current_state.fsm = self
			current_state.body = body
			current_state.enter(msg)
	else:
		printerr("STATE MASTER: " + self.body.name + " DOES NOT HAVE A " + state_name + " STATE! (enter_state)")


func get_state(state_name:String):
	state_name = state_name.to_lower()
	if states.has(state_name):
		return states[state_name]
	return null


func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)


func _process(delta):
	if current_state:
		current_state.process(delta)


func _get_configuration_warning():
	if initial_state_path == "":
		return  "INITIAL STATE NEEDED!"
	
	if body_path == "":
		return "BODY PATH NEEDED!"
	
	return ""
