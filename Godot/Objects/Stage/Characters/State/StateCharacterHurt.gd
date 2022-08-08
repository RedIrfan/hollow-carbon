class_name StateCharacterHurt
extends StateCharacter

export var hurt_duration : float = 0.5

onready var hurt_timer : Timer = $HurtTimer


func enter(msg={}):
	body.pivot.flash(true)
