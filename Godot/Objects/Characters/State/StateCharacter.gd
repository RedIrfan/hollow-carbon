class_name StateCharacter
extends State


func _get_hurt() -> bool:
	if body.attack_data != null:
		return true
	return false


func _get_fall()->bool:
	if body.velocity.y > 0:
		return true
	return false
