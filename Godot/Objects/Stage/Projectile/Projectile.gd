class_name Projectile
extends Node2D

export var speed : float = 100
export var duration : float = 5
export var direction : Vector2 = Vector2.RIGHT
export var damage : float = 1

var direction_x : int = 0

var body : Node

onready var pivot : Node2D = $Pivot
onready var kill_timer : Timer = $KillTimer
onready var hitbox : Hitbox = $Hitbox


func _ready():
	kill_timer.connect("timeout", self, "_on_kill_timeout")
	hitbox.connect("hit", self, "_on_hitbox_hit")
	
	hitbox.set_damage(damage)


func spawn(spawner, new_position, face_direction, exception_group:String="", param=[]):
	Global.stage_master().add_child(self)
	
	body = spawner
	self.global_position = new_position
	
	direction_x = face_direction
	pivot.scale.x = direction_x
	
	hitbox.body = body
	hitbox.exception_group = exception_group
	
	kill_timer.start(duration)
	
	_spawn_behaviour(param)


func _spawn_behaviour(param=[]):
	pass


func _physics_process(delta):
	_projectile_process(delta)


func _projectile_process(delta):
	var npos = direction.normalized()
	npos.x *= direction_x
	
	self.global_position += (npos * speed) * delta


func _on_kill_timeout():
	_destroy()


func _on_hitbox_hit(area):
	_destroy()


func _destroy():
	queue_free()
