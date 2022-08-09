extends StateEnemy

export var action_duration : float = 0.5
export var attack_distance : float = 2.5

onready var action_timer : Timer = $ActionTimer


func _ready():
	action_timer.connect("timeout", self, "_on_action_timeout")


func enter(_msg={}):
	if body.pivot:
		body.pivot.scale.x = _get_direction_to_player().x
	
	body.play_animation("Idle")
	
	action_timer.start(action_duration)


func exit():
	action_timer.stop()


func physics_process(_delta):
	if _get_hurt():
		fsm.enter_state("Hurt")


func _on_action_timeout():
	var distance = _get_distance_to_player()
	
	if distance < attack_distance:
		fsm.enter_state("Attack")
	else:
		fsm.enter_state("Walk")
