class_name StateEnemyJump
extends StateEnemy

export var jump_animation: String = "JumpForward"
export var jump_force: int = 40
export var jump_direction : int = 1
export var on_floor_delay : float = 0.2

var jump_timer : Timer


func _ready():
	jump_timer = Timer.new()
	add_child(jump_timer)
	jump_timer.one_shot = true


func enter(msg={}):
	body.play_animation(jump_animation)
	
	body.velocity.y -= jump_force
	body.direction_x = _get_direction_to_player().x * jump_direction
	
	jump_timer.start(on_floor_delay)


func exit():
	body.direction_x = 0


func physics_process(delta):
	if body.is_on_floor() and jump_timer.is_stopped():
		fsm.enter_state("Idle")
