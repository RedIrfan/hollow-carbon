class_name StatePlayerAttack
extends StateCharacterAttack

export var direction_changeable: bool = false
export var changeable_exception:String = ""


func enter(msg={}):
	damage *= body.damage_multiplier
	.enter(msg)


func _change_direction(dir:Vector2):
	if dir.x != 66:
		._change_direction(dir)


func physics_process(delta):
	.physics_process(delta)
	if direction_changeable:
		if Input.is_action_pressed("move_right"):
#			body.pivot.scale.x = 1
			body.direction_x = 1
		elif Input.is_action_pressed("move_left"):
#			body.pivot.scale.x =-1
			body.direction_x = -1
		
		if changeable_exception == 'ground' and body.is_on_floor():
			body.direction_x = 0
