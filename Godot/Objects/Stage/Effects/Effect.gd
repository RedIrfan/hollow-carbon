class_name Effect
extends Node2D

signal destroyed()

export var kill_duration : float = 0.1
export var use_timer :bool = true

var spawner : Node = null

onready var kill_timer : Timer = $KillTimer


func _ready():
# warning-ignore:return_value_discarded
	kill_timer.connect("timeout", self, "_on_kill_timeout")


func spawn(nspawner, new_position, params={}):
	Global.stage_master().add_child(self)
	
	spawner = nspawner
	self.global_position = new_position
	
	kill_timer.start(kill_duration)
	
	_spawn_behaviour(params)


func _spawn_behaviour(_params={}):
	pass


func _destroy():
	queue_free()
	emit_signal("destroyed")


func _on_kill_timeout():
	if use_timer:
		_destroy()
