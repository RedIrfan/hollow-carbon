extends StateEnemy

export var check_wall_raycast_path : NodePath
export var check_floor_90_angle_raycast_path : NodePath
export var check_floor_next_path : NodePath

export var crawl_duration_min : float = 1.5
export var crawl_duration_max : float = 5.0

var check_wall_raycast : RayCast2D
var check_floor_90_angle_raycast : RayCast2D
var check_floor_next_raycast : RayCast2D

var ready : bool = false
var body_rotated : int = 0

onready var timer : Timer = $Timer


func _ready():
	check_wall_raycast = get_node(check_wall_raycast_path)
	check_floor_90_angle_raycast = get_node(check_floor_90_angle_raycast_path)
	check_floor_next_raycast = get_node(check_floor_next_path)
	
	ready = true
	
	timer.connect("timeout", self, "_on_timer_timeout")


func enter(msg={}):
	.enter(msg)
	body.play_animation("Crawl")
	
	body.gravity = 0
	
	timer.start(rand_range(crawl_duration_min, crawl_duration_max))


func exit():
	body.direction_x = 0
	body.velocity = Vector2.ZERO


func physics_process(delta):
	if _get_hurt():
		fsm.enter_state("Hurt")
	if ready:
		if check_wall_raycast.get_collider():
			
			rotate_body(check_wall_raycast, -90)
		elif ! check_floor_next_raycast.get_collider():
			if check_floor_90_angle_raycast.get_collider():
				rotate_body(check_floor_90_angle_raycast, 90)
		
		var speed = body.speed * body.pivot.scale.x
		var forward_direction = Vector2(1, 0).rotated(body.rotation)
		
		body.velocity.y = speed * forward_direction.y
		body.velocity.x = speed * forward_direction.x


func rotate_body(target : RayCast2D, given_rotation):
	if ! target.get_collider().is_in_group("Blocked Wallride"):
		body.global_position = target.get_collision_point()
		body.rotation_degrees += given_rotation * body.pivot.scale.x
	else:
		body.pivot.scale.x *= -1


func _on_timer_timeout():
	fsm.enter_state("idle")
