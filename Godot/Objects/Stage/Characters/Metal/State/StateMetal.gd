class_name StateMetal
extends State

export var energy_reduction : float = 10


func attack():
	body.energy -= energy_reduction
	_attack_behaviour()


func _attack_behaviour():
	pass
