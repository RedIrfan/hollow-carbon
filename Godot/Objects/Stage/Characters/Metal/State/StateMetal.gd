class_name StateMetal
extends State

export var energy_reduction : float = 10
export var cooldown_duration  : float = 1

var cooldown_timer : Timer


func _ready():
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)


func attack():
	if cooldown_timer.is_stopped():
		body.energy -= energy_reduction
		_attack_behaviour()
		
		cooldown_timer.start(cooldown_duration)


func _attack_behaviour():
	pass
