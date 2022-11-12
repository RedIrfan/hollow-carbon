extends ItemAddValuePlayer


func _add_value() -> bool:
	if body.health < body.DEFAULT_HEALTH:
		body.health += value_added
		
		return true
	return false
