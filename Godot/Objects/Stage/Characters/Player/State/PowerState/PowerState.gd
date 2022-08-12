class_name PowerStatePlayer
extends StatePlayer

export var player_health : int = 100
export var player_speed : int = 80
export var player_damage_multiplier : float = 1.0


func enter(msg={}):
	body.DEFAULT_HEALTH = player_health
	body.DEFAULT_SPEED = player_speed
	body.damage_multiplier = player_damage_multiplier
