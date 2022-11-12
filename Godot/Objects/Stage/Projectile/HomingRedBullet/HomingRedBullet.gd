extends Projectile

export var steer_force : float = 10
var velocity : Vector2 =  Vector2.ZERO
var acceleration : Vector2 = Vector2.ZERO
var next_vel = Vector2.ZERO
var shoot_up : bool = true

var target : Node = null


func _spawn_behaviour(params=[]):
	velocity.y = -speed * 1.2
	if params.size() >= 1:
		target = params[0]


func _projectile_process(delta):
	if shoot_up == true:
		velocity.y += speed * 1.2 * delta
		if velocity.y >= -2:
			shoot_up = false
	
	if target and shoot_up == false:
		var desired = self.global_position.direction_to(target.global_position) * speed
		var steer = (desired - velocity).normalized() * steer_force
		velocity += steer * delta
	
#	velocity = velocity.linear_interpolate(velocity, steer_force * delta)
	velocity = velocity.limit_length(speed)
	
	self.global_position += velocity * delta
	
	next_vel = Vector2.ZERO
