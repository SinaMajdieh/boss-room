extends Label
var attack_state: PlayerState

func _ready() -> void:
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	if not player:
		push_warning("[]Player Debug Menu: Combo INdex]: No player was found")
		return
	attack_state = player.state_machine.get_node_state("attack")

func _process(_delta: float) -> void:
	if not attack_state:
		return
	text = "Combo Index: %2d" % attack_state.get_combo_index()
