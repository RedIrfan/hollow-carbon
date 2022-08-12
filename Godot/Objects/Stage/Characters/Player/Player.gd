extends Character

var metal : Node2D

onready var check_wall : RayCast2D = $Pivot/CheckWall


func _ready():
	add_to_group('Player')
	add_to_group("Reseter")


func on_wall() -> bool:
	if check_wall.get_collider() or is_on_wall():
		return true
	return false
