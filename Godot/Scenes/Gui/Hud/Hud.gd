extends GuiChild

var player : Node

onready var boss_health_bar : TextureProgress = $BossHealthBar
onready var health_bar : TextureProgress = $MarginContainer/TextureRect/HealthBar
onready var energy_bar : TextureProgress = $MarginContainer/TextureRect/EnergyBar
onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	add_to_group("Seter")
	boss_health_bar.visible = false


func enter():
	.enter()
	animation_player.play("Slide")


func exit():
	animation_player.play_backwards("Slide")
	yield(animation_player, "animation_finished")
	.exit()


func setup():
	player = Global.stage_master().player
	
	health_bar.max_value = player.DEFAULT_HEALTH
	energy_bar.max_value = player.metal.MAXIMUM_ENERGY


func physics_process(delta):
	if Global.stage_master().boss != null:
		if boss_health_bar.visible == false:
			boss_health_bar.visible = true
			boss_health_bar.max_value = Global.stage_master().boss.DEFAULT_HEALTH
		else:
			boss_health_bar.value = Global.stage_master().boss.health
	if player:
		health_bar.value = player.health
		energy_bar.value = player.metal.energy
