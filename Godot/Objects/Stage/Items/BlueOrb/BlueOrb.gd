class_name ItemAddValuePlayer
extends Item

export var value_added : int = 5


func _pickup_behaviour():
	if _add_value():
		_destroy()


func _add_value() -> bool:
	if body.metal.energy < body.metal.MAXIMUM_ENERGY:
		body.metal.energy += value_added
		
		return true
	return false
