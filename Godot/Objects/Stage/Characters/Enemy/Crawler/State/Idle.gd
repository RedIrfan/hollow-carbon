extends StateEnemyIdle

export var hitbox_path : NodePath
export var damage : int = 2

var hitbox : Hitbox


func _ready():
	hitbox = get_node(hitbox_path)


func enter(msg={}):
	.enter(msg)
	hitbox.set_damage(damage)


func _on_action_timeout():
	fsm.enter_state("crawl")
