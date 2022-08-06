extends Character


onready var check_wall : RayCast2D = $Pivot/CheckWall


func _ready():
	add_to_group('Player')


func on_wall() -> bool:
	if check_wall.get_collider() or is_on_wall():
		return true
	return false
