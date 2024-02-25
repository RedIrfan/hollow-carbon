class_name GameCamera
extends Camera2D

export var speed : float = 10
export var bonus_position : Vector2 = Vector2(0,0)

var pan_target : Node = null
var pan_position : Vector2 = Vector2.ZERO
var panning : bool = false
var player : Node = null

var starting_limit : Array = [limit_left, limit_top, limit_right, limit_bottom]
var starting_position : Vector2 = Vector2.ZERO

var saved_limit : Array = []
var saved_position : Vector2 = Vector2.ZERO


func _ready():
	player = Global.stage_master().player
	
	starting_limit = get_limit_array()
	starting_position = self.global_position
	
	saved_limit = starting_limit
	saved_position = starting_position
	
	current = true
	
	add_to_group("ResetSaver")
	add_to_group("Reseter")


func save_reset():
	saved_limit = get_limit_array()
	saved_position = self.global_position


func delete_saved_reset():
	saved_limit = starting_limit
	saved_position = starting_position


func reset():
	limit_left = saved_limit[0]
	limit_top = saved_limit[1]
	limit_right = saved_limit[2]
	limit_bottom = saved_limit[3]
	
	set_physics_process(false)
	self.global_position = saved_position
	set_physics_process(true)


func _physics_process(delta):
	var target_pos = Vector2.ZERO
	if panning:
		target_pos = pan_position + bonus_position
	elif player:
		target_pos = player.global_position + bonus_position
	
	if target_pos != Vector2.ZERO:
		self.global_position = self.global_position.linear_interpolate(target_pos, speed * delta)


func pan(mode:bool, pposition:Vector2=Vector2.ZERO):
	panning = mode
	pan_position = pposition


func get_limit_array():
	return [limit_left, limit_top, limit_right, limit_bottom]
