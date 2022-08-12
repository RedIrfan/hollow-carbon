extends Control

var player : Node

onready var health_bar : TextureProgress = $MarginContainer/TextureRect/HealthBar
onready var energy_bar : TextureProgress = $MarginContainer/TextureRect/EnergyBar


func _ready():
	add_to_group("Seter")


func setup():
	player = Global.stage_master().player
	
	health_bar.max_value = player.DEFAULT_HEALTH
	energy_bar.max_value = player.metal.MAXIMUM_ENERGY


func _physics_process(delta):
	if player:
		health_bar.value = player.health
		energy_bar.value = player.metal.energy
