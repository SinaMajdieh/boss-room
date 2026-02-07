extends Label

var player: Player

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	if not player:
		push_warning("[]Player Debug Menu: Player Range Attack]: No player was found")
		return

func _process(_delta):
	if player:
		text = "Range Attack: %s" % player.range_attacks.get_attack_name()
	else :
		text = "Range Attack: None"