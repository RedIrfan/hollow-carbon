class_name StateEnemyIdle
extends StateEnemy

export var action_duration : float = 0.5
export var look_to_player : bool = true

var action_timer : Timer


func _ready():
	action_timer = Timer.new()
	add_child(action_timer)
	action_timer.one_shot = true
	
	action_timer.connect("timeout", self, "_on_action_timeout")


func enter(_msg={}):
	if body.pivot and look_to_player:
		body.pivot.scale.x = _get_direction_to_player().x
	
	body.play_animation("Idle")
	
	action_timer.start(action_duration)


func exit():
	action_timer.stop()


func physics_process(_delta):
	if _get_hurt():
		fsm.enter_state("Hurt")


func _on_action_timeout():
	pass
