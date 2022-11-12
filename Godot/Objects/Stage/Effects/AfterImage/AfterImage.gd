extends Effect

var interpolate_speed : float = 0.01

onready var sprite :Sprite = $Sprite


func _ready():
	sprite.material.set_shader_param('color_progress', 1)
	
	interpolate_speed = 1.0 / kill_duration


func _spawn_behaviour(params={}):
	if params.has("animated_sprite"):
		sprite.texture = params['animated_sprite'].frames.get_frame( params['animated_sprite'].animation,  params['animated_sprite'].frame)
		sprite.scale.x = spawner.pivot.scale.x
		sprite.offset =  params['animated_sprite'].offset
		sprite.global_position = params['animated_sprite'].global_position
		if params.has("color"):
			sprite.material.set_shader_param('color', params['color'])


func _process(delta):
	var new_color = lerp(sprite.modulate.a, 0, interpolate_speed * delta)
	sprite.modulate.a = new_color

