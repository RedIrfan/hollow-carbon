class_name StateMetal
extends State

export var metal_maximum_energy : int = 100
export var metal_speed : int = 5
export var recoil : Vector2 = Vector2(10, 0)
export var energy_reduction : float = 10
export var cooldown_duration  : float = 1

var cooldown_timer : Timer


func _ready():
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)


func enter(msg={}):
	body.MAXIMUM_ENERGY = metal_maximum_energy
	body.speed = metal_speed


func attack():
	if cooldown_timer.is_stopped() and body.energy > energy_reduction:
		body.energy -= energy_reduction
		body.global_position -= recoil * body.pivot.scale.x
		_attack_behaviour()
		
		cooldown_timer.start(cooldown_duration)


func _attack_behaviour():
	pass
