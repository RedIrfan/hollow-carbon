extends Character

var damage_multiplier : float  = 1

var metal : Node2D

onready var check_wall : RayCast2D = $Pivot/CheckWall


func _ready():
	add_to_group('Player')


func on_wall() -> bool:
	if check_wall.get_collider() or is_on_wall():
		var returnvalue = true
		if check_wall.get_collider():
			if check_wall.get_collider().is_in_group("Blocked Wallride"):
				returnvalue = false
		
		return returnvalue
	return false
