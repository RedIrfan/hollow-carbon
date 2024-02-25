extends StatePlayer

export var hitbox_path : NodePath
export var damage : int = 2
export var strafing_speed : float = 40
export var falling_speed : float = 90

var hitbox : Hitbox


func _ready():
	hitbox = get_node(hitbox_path)


func enter(_msg={}):
	body.speed = strafing_speed
	
	body.play_animation('DownStab')
	body.animation_player.offset = Vector2(0, 3)
	hitbox.set_damage(damage)


func exit():
	body.animation_player.offset = Vector2(0, 0)
	body.speed = body.DEFAULT_SPEED
	hitbox.set_damage(0)


func physics_process(_delta):
	body.velocity.y = falling_speed
	
# warning-ignore:return_value_discarded
	_direction_auto()
	
	if body.is_on_floor():
		fsm.enter_state('idle')
